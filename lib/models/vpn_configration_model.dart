class VpnConfigrationModel {
  final String username;
  final String password;

  final String countryname;
  final String config;

  VpnConfigrationModel(
      {required this.config,
      required this.countryname,
      required this.password,
      required this.username});
}
