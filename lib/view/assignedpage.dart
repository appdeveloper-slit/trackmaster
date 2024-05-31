import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:trackmaster/utils/dimension.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/utils/styles.dart';
import 'package:trackmaster/view/assigndetailspage.dart';

import '../utils/bottomnavigation.dart';

class assignpage extends StatefulWidget {
  const assignpage({super.key});

  @override
  State<assignpage> createState() => _assignpageState();
}

class _assignpageState extends State<assignpage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomLayout(1, context),
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
          'Assigned Rides',
          style: Sty().mediumtext.copyWith(
                fontWeight: FontWeight.w600,
                color: Clr().black1,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              controller: ScrollController(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: Dim().d16, bottom: Dim().d12),
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
                                    svgList[0],
                                    height: 18.0,
                                    width: 18.0,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: Dim().d6,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    InkWell(
                      onTap: (){
                        STM().redirect2page(context, const assigndetailspage());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: Dim().d16),
                        height: 48.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Clr().jordyblue, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dim().d12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'View Details',
                            style: Sty().smalltext.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Clr().royalblue,
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dim().d12,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
