class Constants {
  // - single_options_ok {Ok, [default Empty or Blank]}
  // - single_options_testing {Pass, Monitoring, Maintenance} (ใช้ "Pass" แทนกรณีที่ค่าเป็น "Normal" ด้วยเลย)
  // - multiple_options_condition {Dirtiness, Degradation, Clean, Normal, [default Empty or Blank]}
  // - multiple_options_lightning_arrester {Dirtiness, Degradation, Clean, Normal, [default Empty or Blank]}
  // - multiple_options_drop_fuse_cut_out {Dirtiness, Damage, Degradation, Clean, Normal, [default Empty or Blank]}
  // - multiple_options_connection {Loosening, Burn, Damage, Normal, [default Empty or Blank]}
  // - multiple_options_ground {Burn, Damage, Normal, [default Empty or Blank]}
  static final List<String> single_options_ok = ['Ok'];
  static final List<String> single_options_testing = ['Pass', 'Monitoring', 'Maintenance'];
  static final List<String> multiple_options_condition = ['Dirtiness', 'Degradation', 'Clean', 'Normal'];
  static final List<String> multiple_options_lightning_arrester = ['Dirtiness', 'Degradation', 'Clean', 'Normal'];
  static final List<String> multiple_options_drop_fuse_cut_out = ['Dirtiness', 'Damage', 'Degradation', 'Clean', 'Normal'];
  static final List<String> multiple_options_connection = ['Loosening', 'Burn', 'Damage', 'Normal'];
  static final List<String> multiple_options_ground = ['Burn', 'Damage', 'Normal'];


}
