import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/db_storage/storage.dart';
import 'package:vpn_basic_project/home_screens/home_controller.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn_info_model.dart';
import 'package:vpn_basic_project/vpn_engine/vpn_engine.dart';

class VpnLocationsCustomCard extends StatelessWidget {
  final VpnInfoModel? vpnInfoModel;
  VpnLocationsCustomCard({super.key, this.vpnInfoModel});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    final homeController = Get.find<HomeController>();

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: screenSize.height * .01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          homeController.vpnInfoModel.value = vpnInfoModel!;

          Storage.vpnInfo = vpnInfoModel!;
          Get.back();

          if (homeController.vpnConeectionState.value ==
              VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();

            Future.delayed(
                Duration(seconds: 3), () => homeController.connectToVpnNow());
          } else {
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.flag,
              size: 40,
              color: Colors.grey,
            ),
          ),
          title: Text(vpnInfoModel!.countryLongName.toString()),
          subtitle: Row(
            children: [
              Icon(
                Icons.shutter_speed,
                color: Colors.redAccent,
                size: 20,
              ),
              SizedBox(
                height: 4,
              ),
              Text(speedFormatbytes(int.parse(vpnInfoModel!.speed), 2))
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfoModel!.vpnSessionNum.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).lightTextColor),
              ),
              SizedBox(
                height: 4,
              ),
              Icon(
                Icons.person_2,
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }

  String speedFormatbytes(int speedBytes, int decimals) {
    if (speedBytes <= 0) {
      return "0 B";
    }

    const suffixesTitle = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];

    var speedTitelIndex = (log(speedBytes) / log(1024)).floor();

    return "${(speedBytes / pow(1024, speedTitelIndex)).toStringAsFixed(decimals)}${suffixesTitle[speedTitelIndex]}";
  }
}
