import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/custom_widgets/custom_round_shap.dart';
import 'package:vpn_basic_project/db_storage/storage.dart';
import 'package:vpn_basic_project/home_screens/home_controller.dart';
import 'package:vpn_basic_project/home_screens/location_screen/vpn_location_screens.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn_status_model.dart';
import 'package:vpn_basic_project/vpn_engine/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homecontroller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    VpnEngine().snapshortVpnStage().listen((event) {
      homecontroller.vpnConeectionState.value = event;
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          leading: Icon(Icons.perm_device_info),
          title: Text(
            ' Home screen ',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Get.changeThemeMode(
                      Storage.isModeDark ? ThemeMode.light : ThemeMode.dark);

                  Storage.isModeDark = !Storage.isModeDark;
                },
                child: Icon(Icons.brightness_2_outlined))
          ],
        ),
        bottomNavigationBar: locationButtonBar(context),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRoundShap(
                    iconFile: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: homecontroller
                                .vpnInfoModel.value.countryLongName.isEmpty
                            ? Icon(
                                Icons.flag_circle,
                                color: Colors.white,
                                size: 30,
                              )
                            : null,
                        backgroundImage: homecontroller
                                .vpnInfoModel.value.countryLongName.isEmpty
                            ? null
                            : AssetImage(
                                "assets/icons/${homecontroller.vpnInfoModel.value.countryShortName.toUpperCase()}.png  ")),
                    titleText: homecontroller
                            .vpnInfoModel.value.countryLongName.isEmpty
                        ? "Location "
                        : homecontroller.vpnInfoModel.value.countryLongName,
                    subTitleText: "Free"),
                CustomRoundShap(
                    iconFile: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.graphic_eq,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    titleText: homecontroller.vpnInfoModel.value.ping.isEmpty
                        ? "60 ms "
                        : homecontroller.vpnInfoModel.value.ping + " ms",
                    subTitleText: "Free"),
              ],
            ),
          ),
          Obx(() => vpnRoundButton()),
          StreamBuilder<VpnStatusModel?>(
            initialData: VpnStatusModel(),
            stream: VpnEngine.snapshortVpnStatus(),
            builder: (context, snapshort) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRoundShap(
                      iconFile: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.arrow_circle_down,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      titleText: "DOWNLAOD",
                      subTitleText: "${snapshort.data?.byteIn ?? " 0 kbps"}"),
                  CustomRoundShap(
                      iconFile: CircleAvatar(
                        backgroundColor: Colors.deepPurpleAccent,
                        child: Icon(
                          Icons.arrow_circle_up_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      titleText: "UPLOAD ",
                      subTitleText: "${snapshort.data?.byteOut ?? " 0 kbps"}")
                ],
              );
            },
          )
        ]));
  }

  locationButtonBar(BuildContext context) {
    return SafeArea(
        child: Semantics(
      button: true,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VpnLocationScreens()));
        },
        child: Container(
          color: Colors.redAccent,
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * .041),
          height: 62,
          child: Row(
            children: [
              Icon(
                Icons.flag_circle,
                color: Colors.white,
                size: 36,
              ),
              SizedBox(
                width: 12,
              ),
              Text('Select Country / Location'),
              Spacer(),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.redAccent,
                size: 26,
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {
              homecontroller.connectToVpnNow();
            },
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: homecontroller.getRoundButtonColor.withOpacity(0.1),
              ),
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homecontroller.getRoundButtonColor.withOpacity(0.3),
                ),
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: homecontroller.getRoundButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        homecontroller.getRoundVpnButtonText,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
