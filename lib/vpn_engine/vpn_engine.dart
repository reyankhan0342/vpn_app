import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vpn_basic_project/models/vpn_configration_model.dart';
import 'package:vpn_basic_project/models/vpn_status_model.dart';

class VpnEngine {
  static final String eventChannelVpnStage = "vpnStage";
  static final String eventChannelVpnStatus = "vpnStatus";
  static final String eventChannelVpnControl = "vpnControl";

  /// vpn connection stage snapshort
  Stream<String> snapshortVpnStage() =>
      EventChannel(eventChannelVpnStage).receiveBroadcastStream().cast();

  /// vpn connection status snapshort

  static Stream<VpnStatusModel?> snapshortVpnStatus() =>
      EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map(
              (eventStatus) => VpnStatusModel.fromjson(jsonDecode(eventStatus)))
          .cast();

  ////  start  vpn now

  static Future<void> startVpnNow(VpnConfigrationModel vpnconfigration) {
    return MethodChannel(eventChannelVpnControl).invokeMethod("start", {
      "config": vpnconfigration.config,
      "country": vpnconfigration.countryname,
      "username": vpnconfigration.username,
      "password": vpnconfigration.password,
    });
  }

  static Future<void> stopVpnNow() {
    return MethodChannel(eventChannelVpnControl).invokeMethod('stop');
  }

  static Future<void> killSwitchOpenNow() {
    return MethodChannel(eventChannelVpnControl).invokeMethod('kill_switch');
  }

  static Future<void> refreshStageNow() {
    return MethodChannel(eventChannelVpnControl).invokeMethod('refresh');
  }

  static Future<String?> getStageNow() {
    return MethodChannel(eventChannelVpnControl).invokeMethod('stage');
  }

  static Future<bool> isConnectedNow() {
    return getStageNow()
        .then((valueStage) => valueStage!.toLowerCase() == 'connected');
  }

  /// stage of  vpn connection

  static const String vpnConnectedNow = "connected";
  static const String vpnDisConnectedNow = "disconnected";
  static const String vpnWaitConnectionNow = "wait_connection";
  static const String vpnAuthenticationNow = "authenticating";
  static const String vpnReconnectNow = "reconnect";
  static const String vpnNotConnectedNow = "no_connection";
  static const String vpnConnectingNow = "connecting";
  static const String vpnPrepareNow = "prepare";
  static const String vpnDeniedNow = "denied";
}
