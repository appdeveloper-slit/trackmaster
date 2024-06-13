// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackmaster/services/apifile.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/view/homepage.dart';

class userViewModel extends ChangeNotifier {
  final apiServices ser = apiServices();
  bool loading = false;
  bool homeLoading = false;
  Map rideDetails = {};
  List assignRidesList = [];
  List completeRidesList = [];

  Future<dynamic> signUser({data, ctx, setState}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'login',
      body: {
        'mobile': data['mobile'],
        'password': data['password'],
      },
      ctx: ctx,
      type: 'post',
    );
    if (result['success'] == true) {
      setState(() {
        loading = false;
        notifyListeners();
        sp.setString('token', result['data']['token']);
        sp.setBool('login', true);
        Fluttertoast.showToast(msg: result['message']);
        STM().finishAffinity(ctx, Homeview());
      });
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }

  Future<dynamic> getData({ctx, setState}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'ongoing_ride',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'get',
    );
    if (result['success'] == true) {
      setState(() {
        loading = false;
        result['data'] == null ? homeLoading = true : homeLoading = false;
        notifyListeners();
        rideDetails = result['data'];
        notifyListeners();
      });
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }

  Future<dynamic> getAssData({ctx, setState}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'assigned_rides',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'get',
    );
    if (result['success'] == true) {
      setState(() {
        loading = false;
        notifyListeners();
        assignRidesList = result['data'];
        notifyListeners();
      });
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }

  Future<dynamic> getCompData({ctx, setState}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'completed_rides',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'get',
    );
    if (result['success'] == true) {
      setState(() {
        loading = false;
        notifyListeners();
        completeRidesList = result['data'];
        notifyListeners();
      });
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }

  Future<dynamic> updateStatus(ctx, setState, body, {type}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'status_update',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'post',
      body: body,
    );
    print(body);
    if (result['success'] == true) {
      loading = false;
      getData(ctx: ctx, setState: setState);
      type == 'assign' ? STM().finishAffinity(ctx, Homeview()) : null;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }
}
