import 'package:flutter/material.dart';
import 'package:apps/pages/loading.dart';
import 'package:apps/pages/automatic_control.dart';
import 'package:apps/pages/home.dart';
import 'package:apps/pages/menu.dart';
import 'package:apps/pages/manual_control.dart';
import 'package:flutter/services.dart';
import 'package:apps/pages/bt_connection.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
    routes: {
    '/': (context) => Loading_screen(),
    '/home': (context) {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
          .then((_) {});
      return Home();
      },
   // '/menu': (context) => Menu(),
    '/automatic': (context) {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
          .then((_) {});
      return Automatic_Control();
      },
    '/manual': (context) {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
          .then((_) {});
        return manual_Control();
      },
      '/BT_Connection': (context) {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
        .then((_) {});
      return MyApp();
      }
  }
));




