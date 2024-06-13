// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timelines/timelines.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:trackmaster/utils/dimension.dart';
import 'package:trackmaster/utils/styles.dart';

import '../utils/bottomnavigation.dart';
import '../utils/staticmethods.dart';

class completeddetilspage extends StatefulWidget {
  const completeddetilspage({super.key});

  @override
  State<completeddetilspage> createState() => _completeddetilspageState();
}

class _completeddetilspageState extends State<completeddetilspage> {
  List nameFiled = [
    'Customer Name:',
    'Mobile Number:',
    'Car Model:',
    'Car Plate No.:'
  ];

  List svgList = [
    'assets/person.svg',
    'assets/call.svg',
    'assets/car.svg',
    'assets/plate.svg',
  ];

  List ansfiled = [
    'Shahrukh More',
    '+91 9893983832',
    'Maruti Suzuki Ertiga',
    'MH04 JM6272',
  ];

  List namelist = [
    'Parking Lot Location:',
    'Pickup Location:',
    'Drop Location:',
    'Drop Location:',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomLayout(2, context),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              STM().back2Previous(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/arrow_left.svg',
                height: Dim().d24,
                width: Dim().d24,
                fit: BoxFit.cover,
              ),
            )),
        title: Text(
          'Order ID: 2823',
          style: Sty().mediumtext.copyWith(
                fontWeight: FontWeight.w600,
                color: Clr().black1,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: Dim().d16, bottom: Dim().d12),
              height: Dim().d44,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Clr().lightgreen,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID: 2823',
                        style: Sty().smalltext.copyWith(
                              color: Clr().iconcolor,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        '24th May 24 / 2:04 PM',
                        style: Sty().microText.copyWith(
                              color: Clr().iconcolor,
                              fontWeight: FontWeight.w400,
                            ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dim().d16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            svgList[0],
                            height: 18.0,
                            width: 18.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: Dim().d6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nameFiled[0],
                                style: Sty().microText.copyWith(
                                    color: Clr().slategrey,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: Dim().d2,
                              ),
                              Text(
                                ansfiled[0],
                                style: Sty().microText.copyWith(
                                      color: Clr().charcole,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            svgList[2],
                            height: 18.0,
                            width: 18.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: Dim().d6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nameFiled[2],
                                style: Sty().microText.copyWith(
                                    color: Clr().slategrey,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: Dim().d2,
                              ),
                              Text(
                                ansfiled[2],
                                style: Sty().microText.copyWith(
                                      color: Clr().charcole,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            svgList[1],
                            height: 18.0,
                            width: 18.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: Dim().d6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nameFiled[1],
                                style: Sty().microText.copyWith(
                                    color: Clr().slategrey,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: Dim().d2,
                              ),
                              Text(
                                ansfiled[1],
                                style: Sty().microText.copyWith(
                                      color: Clr().charcole,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            svgList[3],
                            height: 18.0,
                            width: 18.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: Dim().d6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                nameFiled[3],
                                style: Sty().microText.copyWith(
                                    color: Clr().slategrey,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: Dim().d2,
                              ),
                              Text(
                                ansfiled[3],
                                style: Sty().microText.copyWith(
                                      color: Clr().charcole,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d16),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Ride Status',
                      style: Sty().mediumtext.copyWith(
                            color: Clr().royalblue,
                            fontWeight: FontWeight.w600,
                          ),
                      children: [
                        TextSpan(
                          text: ' (One-way)',
                          style: Sty().mediumtext.copyWith(
                                color: Clr().royalblue,
                                fontWeight: FontWeight.w400,
                              ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dim().d12,
                  ),
                  Expanded(
                    child: Divider(
                      color: Clr().bordercolor,
                      thickness: 1,
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
              itemCount: namelist.length,
              shrinkWrap: true,
              controller: ScrollController(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/location.svg',
                            color: Clr().iconcolor,
                            height: Dim().d20,
                          ),
                        ),
                        index == namelist.length - 1
                            ? Container()
                            : Dash(
                                direction: Axis.vertical,
                                dashLength: 8.0,
                                dashGap: 2.0,
                                length: 120,
                                dashColor: Clr().iconcolor,
                              ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Dim().d8,
                          ),
                          Text(
                            namelist[index],
                            style: Sty().smalltext.copyWith(
                                  color: Clr().slategrey,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          SizedBox(
                            height: Dim().d8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Parking Lot Location: 1234, Shivaji Marg, Andheri West, Mumbai, Maharashtra, 400053, India',
                                  style: Sty().smalltext.copyWith(
                                        color: Clr().charcole,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              // SizedBox(
                              //   width: Dim().d16,
                              // ),
                              // SvgPicture.asset('assets/share.svg'),
                              // SizedBox(
                              //   width: Dim().d16,
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: Dim().d16),
                                child: Container(
                                  margin: EdgeInsets.only(right: Dim().d16),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dim().d20, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Clr().ConborderClr, width: 1.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Dim().d12),
                                    ),
                                  ),
                                  child: Text(
                                    '24th May 24 / 2:04 PM',
                                    style: Sty().smalltext.copyWith(
                                          color: Clr().textClr,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          index == namelist.length - 1
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(right: Dim().d16),
                                  child: Divider(
                                    color: Clr().borderClr,
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: Dim().d20,
            ),
            // _buildTimelineTile(
            //   icon: Icons.local_parking,
            //   iconColor: Colors.green,
            //   title: 'Parking Lot Location:',
            //   address:
            //       '1234, Shivaji Marg, Andheri West, Mumbai, Maharashtra, 400053, India',
            //   dateTime: '24th May 24 / 2:04 PM',
            //   buttonText: '',
            // ),
            // _buildTimelineTile(
            //   icon: Icons.location_on,
            //   iconColor: Colors.orange,
            //   title: 'Pickup Location:',
            //   address:
            //       '1234, Shivaji Marg, Andheri West, Mumbai, Maharashtra, 400053, India',
            //   buttonText: 'Start Ride',
            // ),
            // _buildTimelineTile(
            //   icon: Icons.location_on,
            //   iconColor: Colors.blueGrey,
            //   title: 'Drop Location:',
            //   address:
            //       '1234, Shivaji Marg, Andheri West, Mumbai, Maharashtra, 400053, India',
            //   buttonText: 'End Ride',
            // ),
            // // _buildTimelineTile(
            //   icon: Icons.location_on,
            //   iconColor: Colors.grey,
            //   title: 'Drop Location:',
            //   address:
            //       '1234, Shivaji Marg, Andheri West, Mumbai, Maharashtra, 400053, India',
            //   buttonText: 'Parked Vehicle',
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String address,
    String? dateTime,
    required String buttonText,
  }) {
    return TimelineTile(
      nodePosition: 0,
      // alignment: TimelineAlign.manual,
      // lineXY: 0.1,
      // isFirst: false,
      // isLast: false,
      // beforeLineStyle: LineStyle(
      //   color: iconColor,
      //   thickness: 2,
      // ),
      // indicatorStyle: IndicatorStyle(
      //   width: 20,
      //   height: 20,
      //   indicator: Icon(icon, color: Colors.white),
      //   color: iconColor,
      // ),
      contents: Container(
        constraints: BoxConstraints(
          minHeight: 70,
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              address,
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            if (dateTime != null) ...[
              SizedBox(height: 16),
              Text(
                dateTime,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
            if (buttonText.isNotEmpty) ...[
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconColor, // Background color
                ),
                onPressed: () {},
                child: Text(buttonText),
              ),
            ],
          ],
        ),
      ),
      node: Container(
        margin: EdgeInsets.only(right: 8),
        width: 30,
        height: buttonText.isNotEmpty ? 100 : 70,
        child: Center(
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
