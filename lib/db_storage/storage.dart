import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_basic_project/models/vpn_info_model.dart';

class Storage {
  static late Box boxofData;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    boxofData = await Hive.openBox("data");
  }

  static bool get isModeDark => boxofData.get('isModeDark') ?? false;

  static set isModeDark(bool value) => boxofData.put('isModeDark', value);

  /// for save single seletction vpn details

  static VpnInfoModel get vpnInfo {
    var vpnData = boxofData.get("vpn");

    if (vpnData is String) {
      return VpnInfoModel.fromJson(jsonDecode(vpnData));
    } else if (vpnData is Map) {
      return VpnInfoModel.fromJson(Map<String, dynamic>.from(vpnData));
    } else {
      return VpnInfoModel(
        base64OpenVpnConfigrationData: "",
        countryLongName: "",
        countryShortName: "",
        hostName: "",
        ip: "",
        vpnSessionNum: '',
        ping: '',
        speed: '',
      );
    }
  }

  static set vpnInfo(VpnInfoModel value) {
    boxofData.put("vpn", jsonEncode(value));
  }

  /// for saving all vpn service details

  static List<VpnInfoModel> get vpnList {
    List<VpnInfoModel> temVpnList = [];

    final dataVpn = jsonDecode(boxofData.get('vpnList') ?? '[]');

    for (var data in dataVpn) {
      temVpnList.add(VpnInfoModel.fromJson(data));
    }

    return temVpnList;
  }

  static set vpnList(List<VpnInfoModel> valueList) =>
      boxofData.put('vpnList', jsonEncode(valueList));
}
