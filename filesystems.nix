{
  fileSystems."/".options                = [ "noatime" "compress=zstd" "space_cache=v2" "discard=async" ];
  fileSystems."/home".options            = [ "noatime" "compress=zstd" "space_cache=v2" "discard=async" ];
  fileSystems."/nix".options             = [ "noatime" "compress=zstd" "space_cache=v2" "discard=async" ];
  fileSystems."/var".options             = [ "noatime" "compress=zstd" "space_cache=v2" "discard=async" ];
  fileSystems."/.snapshots".options      = [ "noatime" "compress=zstd" "space_cache=v2" "discard=async" ];
  fileSystems."/var/lib/libvirt".options = [ "noatime" "compress=zstd" "space_cache=v2" "discard=async" ];
}
