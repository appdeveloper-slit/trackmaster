// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:trackmaster/utils/dimension.dart';
import 'package:trackmaster/utils/styles.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  List nameFiled = [
    'Customer Name:',
    'Mobile Number:',
    'Car Model:',
    'Car Plate No.:'
  ];
  List ansfiled = [
    'Shahrukh More',
    '+91 9893983832',
    'Maruti Suzuki Ertiga',
    'MH04 JM6272',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dim().d16,
              ),
              child: RichText(
                text: TextSpan(
                  text: 'Hi,',
                  style: Sty().mediumtext.copyWith(
                        color: Clr().black1,
                        fontWeight: FontWeight.w400,
                      ),
                  children: [
                    TextSpan(
                      text: ' Diptej Kumar',
                      style: Sty().mediumtext.copyWith(
                            color: Clr().Primarycolor,
                            fontWeight: FontWeight.w600,
                          ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Dim().d16, bottom: Dim().d12),
              height: Dim().d44,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Clr().lightblue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID: 2823',
                        style: Sty().smalltext.copyWith(
                              color: Clr().royalblue,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        '24th May 24 / 2:04 PM',
                        style: Sty().microText.copyWith(
                              color: Clr().steelblue,
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
                            'assets/task.svg',
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
                            'assets/task.svg',
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
                            'assets/task.svg',
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
                            'assets/task.svg',
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
          ],
        ),
      ),
    );
  }
}
