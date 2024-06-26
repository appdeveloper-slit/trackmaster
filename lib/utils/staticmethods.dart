import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dimension.dart';
import 'styles.dart';

class STM {
  void redirect2page(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  void replacePage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
    );
  }

  Future<bool> checkInternet(context, widget) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      internetAlert(context, widget);
      return false;
    }
  }

  internetAlert(context, widget) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Padding(
        padding: EdgeInsets.all(Dim().d20),
        child: Column(
          children: [
            // SizedBox(child: Lottie.asset('assets/no_internet_alert.json')),
            Text(
              'Connection Error',
              style: Sty().largetext.copyWith(
                    color: Clr().Primarycolor,
                    fontSize: 18.0,
                  ),
            ),
            SizedBox(
              height: Dim().d8,
            ),
            Text(
              'No Internet connection found.',
              style: Sty().smalltext,
            ),
            SizedBox(
              height: Dim().d32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Clr().Primarycolor,
                ),
                onPressed: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult.contains(ConnectivityResult.mobile) ||
                      connectivityResult.contains(ConnectivityResult.wifi)) {
                    Navigator.pop(context);
                    STM().replacePage(context, widget);
                  }
                },
                child: Text(
                  "Try Again",
                  style: Sty().largetext.copyWith(
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ).show();
  }

  void back2Previous(BuildContext context) {
    Navigator.pop(context);
  }

  void finishAffinity(final BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
  }

  List<BottomNavigationBarItem> getBottomList(index) {
    return [
      BottomNavigationBarItem(
        icon: index == 0
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: Dim().d4),
                child: SvgPicture.asset(
                  "assets/ongoing.svg",
                  color: Clr().Primarycolor,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: Dim().d4),
                child: SvgPicture.asset(
                  "assets/ongoing.svg",
                ),
              ),
        label: 'Ongoing',
      ),
      BottomNavigationBarItem(
        icon: index == 1
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: Dim().d4),
                child: SvgPicture.asset(
                  "assets/assigned.svg",
                  color: Clr().Primarycolor,
                  // color: index == 0 ? Clr().primaryColor : Clr().white,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: Dim().d4),
                child: SvgPicture.asset(
                  "assets/assigned.svg",
                ),
              ),
        label: 'Assigned',
      ),
      BottomNavigationBarItem(
        icon: index == 2
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: Dim().d4),
                child: SvgPicture.asset(
                  "assets/completed.svg",
                  color: Clr().Primarycolor,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: Dim().d4),
                child: SvgPicture.asset(
                  "assets/completed.svg",
                ),
              ),
        label: 'Completed',
      ),
      BottomNavigationBarItem(
        icon: index == 3
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: Dim().d4),
                child: SvgPicture.asset(
                  "assets/account.svg",
                  color: Clr().Primarycolor,
                  // "assets/persionfillbn.svg",
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: Dim().d4),
                child: SvgPicture.asset(
                  "assets/account.svg",
                ),
              ),
        label: 'Account',
      ),
      // BottomNavigationBarItem(
      //   icon: SvgPicture.asset(
      //     "assets/cartbn.svg",
      //     color: index == 1 ? Clr().primaryColor : Clr().grey,
      //   ),
      //   label: 'Daily letters',
      // ),
      // BottomNavigationBarItem(
      //   icon: SvgPicture.asset(
      //     "assets/notificationbn.svg",
      //     color: index == 2 ? Clr().primaryColor : Clr().grey,
      //   ),
      //   label: 'Profile',
      // ),
      // BottomNavigationBarItem(
      //   icon: SvgPicture.asset(
      //     "assets/profilebn.svg",
      //     color: index == 3 ? Clr().primaryColor : Clr().grey,
      //   ),
      //   label: 'Profile',
      // ),
    ];
  }

  void errorDialog(BuildContext context, String message) {
    AwesomeDialog(
            context: context,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {},
            btnOkColor: Colors.red)
        .show();
  }

  void errorDialogWithReplace(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
              );
            },
            btnOkColor: Colors.red)
        .show();
  }

  //Dialer
  Future<void> openDialer(String phoneNumber) async {
    Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(Uri.parse(launchUri.toString()));
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launch(googleUrl);
  }

  void errorDialogWithinffinity(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      widget,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.fastOutSlowIn;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
            btnOkColor: Clr().steelblue)
        .show();
  }
}
