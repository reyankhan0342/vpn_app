import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/custom_widgets/vpn_locations_custom_card.dart';
import 'package:vpn_basic_project/home_screens/location_screen/vpn_locations_controller.dart';

class VpnLocationScreens extends StatelessWidget {
  VpnLocationScreens({super.key});

  final vpnLOcationController = VpnLocationsController();

  @override
  Widget build(BuildContext context) {
    if (vpnLOcationController.vpnFreeServiceAvilableList.isEmpty) {
      vpnLOcationController.fetchVpnInformation();
    }

    return Obx(() {
      return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 10, right: 10),
          child: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            onPressed: () {
              vpnLOcationController.fetchVpnInformation();
            },
            child: Icon(
              CupertinoIcons.refresh_circled,
              size: 48,
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
              'Vpn Locations (${vpnLOcationController.vpnFreeServiceAvilableList.length.toString() + ")"}'),
        ),
        body: vpnLOcationController.isLoadingNewLocation.value
            ? lodingUiWidget()
            : vpnLOcationController.vpnFreeServiceAvilableList.isEmpty
                ? noVpnServicesUiWidget()
                : vpnAbaliableServicesData(),
      );
    });
  }

  Widget lodingUiWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Gethering Free Vpn Locations ....',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget noVpnServicesUiWidget() {
    return Center(
      child: Text(
        'No Vpm Found , Try Agin ',
        style: TextStyle(
            fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget vpnAbaliableServicesData() {
    print(' vpnAbaliableServicesData calling ');
    return ListView.builder(
      itemCount: vpnLOcationController.vpnFreeServiceAvilableList.length,
      padding: EdgeInsets.all(0),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final data = vpnLOcationController.vpnFreeServiceAvilableList[index];

        debugPrint('data of the vpn is ${data.vpnSessionNum}');
        debugPrint('data of the vpn is ${data.countryShortName}');

        return VpnLocationsCustomCard(vpnInfoModel: data);
      },
    );
  }
}
