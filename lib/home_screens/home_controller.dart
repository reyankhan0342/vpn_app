import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/db_storage/storage.dart';
import 'package:vpn_basic_project/models/vpn_configration_model.dart';
import 'package:vpn_basic_project/models/vpn_info_model.dart';
import 'package:vpn_basic_project/vpn_engine/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<VpnInfoModel> vpnInfoModel = Storage.vpnInfo.obs;

  final vpnConeectionState = VpnEngine.vpnDisConnectedNow.obs;

  void connectToVpnNow() async {
    if (vpnInfoModel.value.base64OpenVpnConfigrationData.isEmpty) {
      Get.snackbar(
          "Country Location", " Please Select country/ location first");

      return;
    }

    if (vpnConeectionState.value == VpnEngine.vpnDisConnectedNow) {
      final dataConfigVpn = Base64Decoder()
          .convert(vpnInfoModel.value.base64OpenVpnConfigrationData);

      final configration = Utf8Decoder().convert(dataConfigVpn);

      final vpnConfigration = VpnConfigrationModel(
          config: configration,
          username: "vpn",
          password: 'vpn',
          countryname: vpnInfoModel.value.countryLongName);

      await VpnEngine.startVpnNow(vpnConfigration);
    }

    await VpnEngine.stopVpnNow();
  }

  Color get getRoundButtonColor {
    switch (vpnConeectionState.value) {
      case VpnEngine.vpnDisConnectedNow:
        return Colors.redAccent;

      case VpnEngine.vpnConnectedNow:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText {
    switch (vpnConeectionState.value) {
      case VpnEngine.vpnDisConnectedNow:
        return "Tap to Connect";

      case VpnEngine.vpnConnectedNow:
        return " DisConnecting";

      default:
        return " Connecting ...";
    }
  }
}
