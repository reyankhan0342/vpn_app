import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/db_storage/storage.dart';
import 'package:vpn_basic_project/home_screens/home_screen.dart';

late Size screenSize;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Storage.initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Free Vpn',
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 3),
      ),
      themeMode: Storage.isModeDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 3),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

extension AppThem on ThemeData {
  Color get lightTextColor =>
      Storage.isModeDark ? Colors.white70 : Colors.black54;
  Color get buttomNavigationColor =>
      Storage.isModeDark ? Colors.white12 : Colors.redAccent;
}
