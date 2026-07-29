{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.networking.netbirdTailscale;

  # Tailscale claims the whole CGNAT block: it puts `100.64.0.0/10 dev
  # tailscale0` in table 52 and reaches that table from an `ip rule` at
  # priority 5270. Rules are evaluated in priority order and the first table
  # that matches wins, so that one rule beats every NetBird route in the main
  # table (priority 32766) even though NetBird's prefixes are more specific --
  # longest-prefix match only applies *within* a table, never across them.
  #
  # NetBird hands each account a single /16 out of the same /10, so carving
  # just that /16 back out to the main table is enough to let both run. This is
  # the override Tailscale documents for overlapping subnets:
  # https://tailscale.com/docs/reference/troubleshooting/network-configuration/lan-traffic-overlapping-subnets
  mkScript = name: text:
    pkgs.writeShellApplication {
      inherit name text;
      runtimeInputs = with pkgs; [iproute2 gawk coreutils];
    };

  # Resolving the range at runtime rather than pinning it in Nix keeps this
  # working before you know your account's /16 -- and across an account change.
  resolveRange =
    if cfg.range != null
    then ''net="${cfg.range}"''
    else ''
      # The link shows up a moment before NetBird puts an address on it.
      addr=""
      for _ in $(seq 1 30); do
        addr=$(ip -4 -brief addr show dev "$iface" 2>/dev/null | awk '{print $3}' | head -n1)
        if [ -n "$addr" ]; then break; fi
        sleep 1
      done

      if [ -z "$addr" ]; then
        echo "no IPv4 address on $iface yet; leaving routing untouched" >&2
        exit 0
      fi

      # Prefer the prefix NetBird actually configured; fall back to the /16 the
      # address sits in when it only carries a host route.
      net=$(ip -4 route show dev "$iface" scope link proto kernel | awk '{print $1}' | head -n1)
      if [ -z "$net" ] || [ "''${net#*/}" = "32" ]; then
        net="$(echo "''${addr%%/*}" | cut -d. -f1,2).0.0/16"
      fi
    '';

  up = mkScript "netbird-tailscale-up" ''
    iface="${cfg.interface}"
    prio="${toString cfg.priority}"

    ${resolveRange}

    # Idempotent: `ip rule add` happily stacks duplicates.
    while ip rule del priority "$prio" 2>/dev/null; do :; done
    ip rule add to "$net" priority "$prio" lookup main

    # Tailscale's MagicDNS resolver is 100.100.100.100, which is itself inside
    # the /10. On the 1-in-64 accounts whose range is 100.100.0.0/16 the rule
    # above would strand it, so pin it back to Tailscale's table. Harmless when
    # Tailscale is down: an empty table 52 just falls through to the next rule.
    case "$net" in
      100.100.*)
        while ip rule del priority "$((prio - 100))" 2>/dev/null; do :; done
        ip rule add to 100.100.100.100/32 priority "$((prio - 100))" lookup 52
        ;;
    esac

    echo "routing $net via main table at priority $prio (ahead of Tailscale)"
  '';

  down = mkScript "netbird-tailscale-down" ''
    prio="${toString cfg.priority}"
    while ip rule del priority "$prio" 2>/dev/null; do :; done
    while ip rule del priority "$((prio - 100))" 2>/dev/null; do :; done
  '';
in {
  options.networking.netbirdTailscale = {
    enable =
      lib.mkEnableOption ""
      // {
        description = ''
          Let NetBird and Tailscale run at the same time by giving NetBird's
          slice of 100.64.0.0/10 a policy-routing rule ahead of Tailscale's.
        '';
      };

    interface = lib.mkOption {
      type = lib.types.str;
      default = "wt0";
      description = "NetBird's WireGuard interface.";
    };

    range = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "100.92.0.0/16";
      description = ''
        NetBird's account network range. Left null it is derived from the
        address NetBird assigns, which is what you want unless you route a
        wider prefix over NetBird than the one it puts on the interface.
      '';
    };

    priority = lib.mkOption {
      type = lib.types.ints.positive;
      default = 2500;
      description = ''
        Policy-routing priority for the override. Must sort ahead of (be
        numerically lower than) Tailscale's 5210-5270 rules. `priority - 100`
        is used for the MagicDNS pin.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.netbird-tailscale = {
      description = "Keep NetBird's range reachable while Tailscale is up";
      # Triggered by the interface itself, so it also fires on a NetBird
      # reconnect -- not just at boot, when wt0 may not exist yet.
      bindsTo = ["sys-subsystem-net-devices-${cfg.interface}.device"];
      after = ["sys-subsystem-net-devices-${cfg.interface}.device"];
      wantedBy = ["sys-subsystem-net-devices-${cfg.interface}.device"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = lib.getExe up;
        ExecStop = lib.getExe down;
      };
    };
  };
}
