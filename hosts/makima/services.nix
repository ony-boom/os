{
  services.upower.enable = true;

  # Audio quirks for this machine (ThinkPad L14 Gen 2, sof-hda-dsp):
  #
  # 1. The UCM config splits the analog output into two mutually exclusive
  #    profiles: "... Headphones ..." and "... Speaker". WirePlumber sometimes
  #    boots into the Headphones one with nothing plugged in, leaving the
  #    laptop with no Speaker sink at all. Pin the Speaker profile as the
  #    default; a manually selected profile (wpctl/pavucontrol) is still
  #    remembered via WirePlumber's state file.
  # 2. HDMI audio is never used on this machine: disable those sinks so the
  #    device pickers only show interfaces that actually matter.
  # 3. Give the remaining nodes short names instead of
  #    "Tiger Lake-LP Smart Sound Technology Audio Controller ...".
  services.pipewire.wireplumber.extraConfig."51-makima-audio" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          {"device.name" = "alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic";}
        ];
        actions.update-props = {
          "device.profile" = "HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)";
        };
      }
      {
        matches = [
          {"node.name" = "~alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI[0-9]__sink";}
        ];
        actions.update-props = {
          "node.disabled" = true;
        };
      }
      {
        matches = [
          {"node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";}
        ];
        actions.update-props = {
          "node.description" = "Laptop Speakers";
        };
      }
      {
        matches = [
          {"node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink";}
        ];
        actions.update-props = {
          "node.description" = "Jack Headphones";
        };
      }
      {
        matches = [
          {"node.name" = "alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Mic1__source";}
        ];
        actions.update-props = {
          "node.description" = "Laptop Microphone";
        };
      }
      {
        matches = [
          {"node.name" = "alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Mic2__source";}
        ];
        actions.update-props = {
          "node.description" = "Jack Microphone";
        };
      }
      {
        matches = [
          {"node.name" = "alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo";}
        ];
        actions.update-props = {
          "node.description" = "USB Headset";
        };
      }
      {
        matches = [
          {"node.name" = "alsa_input.usb-GeneralPlus_USB_Audio_Device-00.mono-fallback";}
        ];
        actions.update-props = {
          "node.description" = "USB Headset Microphone";
        };
      }
    ];
  };
}
