{
  fileSystems."/mnt/extra-storage" = {
    device = "/dev/disk/by-uuid/d795bfe1-ee5a-4030-ba44-21c357ec3524";
    fsType = "ext4";
    options = ["rw" "user" "nofail"];
  };
}
