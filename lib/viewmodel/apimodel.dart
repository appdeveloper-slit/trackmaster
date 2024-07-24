// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackmaster/services/apifile.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/view/homepage.dart';
import 'package:trackmaster/view/kycPage.dart';
import 'package:trackmaster/view/login.dart';

import '../view/completedrides.dart';

class userViewModel extends ChangeNotifier {
  final apiServices ser = apiServices();
  bool loading = false;
  bool homeLoading = false;
  Map rideDetails = {};
  var aboutUsContent;
  Map contactdetails = {};

  bool profileLoading = false;
  Map profileDetails = {};

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
        if (result['data']['user']['is_kyc'] == true) {
          setState(() {
            sp.setString('token', result['data']['token']);
            sp.setString('name', result['data']['user']['name']);
            sp.setString('driverId', result['data']['user']['id'].toString());
            sp.setBool('login', true);
          });
          Fluttertoast.showToast(msg: result['message']);
          STM().finishAffinity(ctx, Homeview());
        } else {
          setState(() {
            sp.setString('token', result['data']['token']);
            sp.setString('name', result['data']['user']['name']);
            sp.setString('driverId', result['data']['user']['id'].toString());
          });
          STM().redirect2page(ctx, kycpage());
        }

        // result['data']['user']['is_kyc'] == true
        //     ? STM().finishAffinity(ctx, Homeview())
        //     : STM().redirect2page(ctx, kycpage());
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
        type: 'post',
        body: {
          'uuid': OneSignal.User.pushSubscription.id,
        });
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

  Future<dynamic> getAboutUsData({ctx, setState}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'about_us',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'get',
    );
    if (result['success'] == true) {
      setState(() {
        loading = false;
        print(result);
        aboutUsContent = result['about_us'];
        notifyListeners();
      });
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }

  Future<dynamic> getContactUsData({ctx, setState}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'contact_us',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'get',
    );
    if (result['success'] == true) {
      setState(() {
        loading = false;
        print(result);
        contactdetails = result;
        // aboutUsContent = result['about_us'];
        notifyListeners();
      });
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }

  Future<dynamic> accountdelete({ctx, setState}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'delete_account',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'get',
    );
    if (result['success'] == true) {
      setState(() {
        loading = false;
        sp.clear();
        Fluttertoast.showToast(msg: result['message']);
        STM().finishAffinity(ctx, Login());
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
      type == 'assign'
          ? STM().finishAffinity(ctx, Homeview())
          : type == 'last'
              ? STM().redirect2page(ctx, completedrides())
              : null;
      type == 'last' ? Fluttertoast.showToast(msg: 'Ride Completed') : null;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }

  Future<dynamic> uploadDocumnets({
    ctx,
    setState,
    body,
  }) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'update_document',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'post',
      body: body,
    );
    print(body);
    if (result['success'] == true) {
      setState(() {
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

  Future<dynamic> getProfileData({ctx, setState}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loading = true;
    notifyListeners();
    var result = await ser.allApi(
      apiname: 'my_profile',
      ctx: ctx,
      token: sp.getString('token'),
      type: 'get',
    );
    if (result['success'] == true) {
      setState(() {
        loading = false;
        result['data'] == null ? profileLoading = true : profileLoading = false;
        notifyListeners();
        profileDetails = result['data'];
        notifyListeners();
      });
    } else {
      loading = false;
      notifyListeners();
      STM().errorDialog(ctx, result['message']);
    }
  }
}
