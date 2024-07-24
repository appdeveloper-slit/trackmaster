// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/viewmodel/apimodel.dart';
import 'view/assignedpage.dart';
import 'view/completedrides.dart';
import 'view/homepage.dart';
import 'view/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();

  //Remove this method to stop OneSignal Debugging
  OneSignal.logout();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('4e19a011-2033-443c-9501-4386959503f7');
  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt.
  // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  await Future.delayed(const Duration(seconds: 3));
  runApp(
    ChangeNotifierProvider(
      create: (_) => userViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: sp.getBool('login') == true ? Homeview() : Login(),
      ),
    ),
  );
}
