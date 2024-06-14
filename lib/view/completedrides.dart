import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:trackmaster/utils/dimension.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/utils/styles.dart';
import 'package:trackmaster/view/assigndetailspage.dart';
import 'package:trackmaster/viewmodel/apimodel.dart';

import '../utils/bottomnavigation.dart';
import 'completeddetailspage.dart';

class completedrides extends StatefulWidget {
  const completedrides({super.key});

  @override
  State<completedrides> createState() => _completedridesState();
}

class _completedridesState extends State<completedrides> {
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
  late BuildContext ctx;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      STM().checkInternet(context, widget).then((value) {
        if (value) {
          Provider.of<userViewModel>(context, listen: false)
              .getCompData(ctx: ctx, setState: setState);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final usermodel = Provider.of<userViewModel>(context);
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
          'Completed Rides',
          style: Sty().mediumtext.copyWith(
                fontWeight: FontWeight.w600,
                color: Clr().black1,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            usermodel.completeRidesList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(ctx).size.height / 1.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'No completed rides yet. Please go to the assign page to accept and complete your rides.',
                          textAlign: TextAlign.center,
                          style: Sty().mediumtext.copyWith(color: Clr().black1),
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: usermodel.completeRidesList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    controller: ScrollController(),
                    itemBuilder: (context, index) {
                      var details = usermodel.completeRidesList[index];
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: Dim().d16, bottom: Dim().d12),
                            height: Dim().d44,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Clr().lightgreen,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: Dim().d16),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order ID: ${details['order_id']}',
                                      style: Sty().smalltext.copyWith(
                                            color: Clr().iconcolor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    Text(
                                      '${DateFormat('dd MMM yy').format(DateTime.parse('${details['ride_date']} ${details['ride_time']}'))} / ${DateFormat('hh:mm a').format(DateTime.parse('${details['ride_date']} ${details['ride_time']}'))}',
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              details['customer_name'],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              details['car_model'],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              details['customer_mobile'],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              details['car_plate_number'],
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
                            onTap: () {
                              STM().redirect2page(
                                context,
                                completeddetilspage(
                                  details: details,
                                ),
                              );
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: Dim().d16),
                              height: 48.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Clr().jordyblue, width: 1.0),
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
