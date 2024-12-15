import 'package:get/get.dart';
import 'package:vpn_basic_project/db_storage/storage.dart';
import 'package:vpn_basic_project/models/vpn_info_model.dart';
import 'package:vpn_basic_project/services/vpn_apis.dart';

class VpnLocationsController extends GetxController {
  List<VpnInfoModel> vpnFreeServiceAvilableList = Storage.vpnList;

  final RxBool isLoadingNewLocation = false.obs;

  Future<void> fetchVpnInformation() async {
    isLoadingNewLocation.value = true;

    vpnFreeServiceAvilableList.clear();

    vpnFreeServiceAvilableList = await VpnApis().fetchAllVpnServers();

    isLoadingNewLocation.value = false;
  }
}
