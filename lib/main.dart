// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
