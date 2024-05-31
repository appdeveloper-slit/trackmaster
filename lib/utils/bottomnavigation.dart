import 'package:flutter/material.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:trackmaster/view/assignedpage.dart';
import 'package:trackmaster/view/homepage.dart';

import '../view/account.dart';
import '../view/completedrides.dart';
import 'staticmethods.dart';

Widget bottomLayout(index,ctx){
  return   BottomNavigationBar(
    elevation: 10,
    backgroundColor: Colors.white,
    // unselectedItemColor: Clr().black,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Clr().Primarycolor,
    unselectedItemColor: Clr().bttmTextClr,
    showSelectedLabels: true,
    selectedFontSize: 14,
    selectedLabelStyle: TextStyle(color: Clr().Primarycolor),
    currentIndex: index,
    onTap: (i) async {
      switch (i) {
        case 0:
          STM().finishAffinity(ctx, Homeview());
          break;
        case 1:
          index == 1
              ? STM().replacePage(ctx, assignpage())
              : STM().redirect2page(ctx, assignpage());
          break;
        case 2:
          index == 2
              ? STM().replacePage(ctx, completedrides())
              : STM().redirect2page(ctx, completedrides());
          break;

        case 3:
          index == 3
              ? STM().replacePage(ctx, accountPage())
              : STM().redirect2page(ctx, accountPage());
          break;
      }
    },
    items: STM().getBottomList(index)
  );
}