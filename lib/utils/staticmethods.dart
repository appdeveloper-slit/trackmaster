import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackmaster/utils/colors.dart';

import 'dimension.dart';

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
        icon:  index == 0
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


}