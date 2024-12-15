import 'dart:convert';
import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_basic_project/db_storage/storage.dart';
import 'package:vpn_basic_project/models/ip_info_model.dart';
import 'package:vpn_basic_project/models/vpn_info_model.dart';

class VpnApis {
  Future<List<VpnInfoModel>> fetchAllVpnServers() async {
    List<VpnInfoModel> vpnServersList = [];
    try {
      final response =
          await http.get(Uri.parse("http://www.vpngate.net/api/iphone/"));
      log(' fetchAllVpnServers api response  ====>>>${response.body}');

      print(' ali service  response ===>>>>>${response.body}');
      final commaSeparatedValueString =
          response.body.split("#")[1].replaceAll("*", " ");

      List<List<dynamic>> listData =
          const CsvToListConverter().convert(commaSeparatedValueString);

      final header = listData[0];

      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};

        for (int innercounter = 0;
            innercounter < header.length;
            innercounter++) {
          jsonData.addAll({
            header[innercounter].toString(): listData[counter][innercounter]
          });
        }

        vpnServersList.add(VpnInfoModel.fromJson(jsonData));
      }
    } catch (e) {
      Get.snackbar("Error Ocuree", e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }

    vpnServersList.shuffle();

    if (vpnServersList.isNotEmpty) Storage.vpnList = vpnServersList;

    return vpnServersList;
  }

  //// api  details

  Future<void> fetchIpDetails({required Rx<IpInfoModel> ipInformation}) async {
    try {
      final ipResponse = await http.get(Uri.parse('http//ip-api.com/json/'));

      log(' ip api response  ====>>>${ipResponse.body}');

      final ipData = jsonDecode(ipResponse.body);

      ipInformation.value = IpInfoModel.fromJson(ipData);
    } catch (e) {
      Get.snackbar("ap error Ocuree", e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }
}
