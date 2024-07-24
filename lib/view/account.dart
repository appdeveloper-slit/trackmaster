// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:trackmaster/utils/dimension.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/utils/styles.dart';
import 'package:trackmaster/view/homepage.dart';
import 'package:trackmaster/view/kycPage.dart';
import 'package:trackmaster/view/login.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/bottomnavigation.dart';
import '../viewmodel/apimodel.dart';
import 'aboutus.dart';
import 'contactus.dart';

class accountPage extends StatefulWidget {
  const accountPage({super.key});

  @override
  State<accountPage> createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  late BuildContext ctx;
  var profiledetails;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<userViewModel>(context, listen: false)
          .getProfileData(ctx: ctx, setState: setState);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final usermodel = Provider.of<userViewModel>(context);
    profiledetails =
        usermodel.profileDetails.isEmpty ? null : usermodel.profileDetails;
    return Scaffold(
      bottomNavigationBar: bottomLayout(3, context),
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
          'My Profile',
          style: Sty().mediumtext.copyWith(
                fontWeight: FontWeight.w600,
                color: Clr().black1,
              ),
        ),
      ),
      body: profiledetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: Dim().d20, vertical: Dim().d12),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dim().d12)),
                      border: Border.all(color: Clr().black1, width: 0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: Clr().slategrey,
                                size: Dim().d20,
                              ),
                              SizedBox(
                                width: Dim().d12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: Sty().smalltext,
                                  ),
                                  SizedBox(
                                    height: Dim().d2,
                                  ),
                                  Text(
                                    '${profiledetails['name']}',
                                    style: Sty()
                                        .microText
                                        .copyWith(color: Clr().slategrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Clr().slategrey,
                                size: Dim().d20,
                              ),
                              SizedBox(
                                width: Dim().d12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mobile Number',
                                    style: Sty().smalltext,
                                  ),
                                  SizedBox(
                                    height: Dim().d2,
                                  ),
                                  Text(
                                    '${profiledetails['mobile']}',
                                    style: Sty()
                                        .microText
                                        .copyWith(color: Clr().slategrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.car_repair_rounded,
                                color: Clr().slategrey,
                                size: Dim().d20,
                              ),
                              SizedBox(
                                width: Dim().d12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'License Number',
                                    style: Sty().smalltext,
                                  ),
                                  SizedBox(
                                    height: Dim().d2,
                                  ),
                                  Text(
                                    '${profiledetails['license_number']}',
                                    style: Sty()
                                        .microText
                                        .copyWith(color: Clr().slategrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.assignment_ind,
                                color: Clr().slategrey,
                                size: Dim().d20,
                              ),
                              SizedBox(
                                width: Dim().d12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Aadhaar Card Number',
                                    style: Sty().smalltext,
                                  ),
                                  SizedBox(
                                    height: Dim().d2,
                                  ),
                                  Text(
                                    '${profiledetails['aadhar_card_number']}',
                                    style: Sty()
                                        .microText
                                        .copyWith(color: Clr().slategrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.source,
                                color: Clr().slategrey,
                                size: Dim().d20,
                              ),
                              SizedBox(
                                width: Dim().d12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pan Card Number',
                                    style: Sty().smalltext,
                                  ),
                                  SizedBox(
                                    height: Dim().d2,
                                  ),
                                  Text(
                                    '${profiledetails['pan_card_number']}',
                                    style: Sty()
                                        .microText
                                        .copyWith(color: Clr().slategrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dim().d28,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: Dim().d200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Clr().Primarycolor,
                                ),
                                onPressed: () {
                                  STM().redirect2page(
                                    ctx,
                                    kycpage(
                                      data: profiledetails,
                                      type: 'edit',
                                    ),
                                  );
                                  print(profiledetails);
                                },
                                child: Center(
                                  child: Text(
                                    'Update KYC',
                                    style: Sty().smalltext.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: Dim().d20),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dim().d12)),
                      border: Border.all(color: Clr().black1, width: 0.2),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              STM().redirect2page(ctx, const aboutUs());
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dim().d8),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'About Us',
                                  style: Sty().microText,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: Dim().d12,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                          child: ElevatedButton(
                            onPressed: () {
                              STM().redirect2page(ctx, const contactUs());
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dim().d8),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Contact Us',
                                  style: Sty().microText,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: Dim().d12,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await launch(
                                  'https://lawmakers.co.in/track_master/public/privacy_policy',
                                );
                              } catch (_) {
                                Fluttertoast.showToast(msg: "Can't open link");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dim().d8),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Privacy Policy',
                                  style: Sty().microText,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: Dim().d12,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await launch(
                                  'https://lawmakers.co.in/track_master/public/terms_condition',
                                );
                              } catch (_) {
                                Fluttertoast.showToast(msg: "Can't open link");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dim().d8),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Terms & Condition',
                                  style: Sty().microText,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: Dim().d12,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dim().d12,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Clr().Primarycolor,
                          padding: EdgeInsets.symmetric(vertical: Dim().d12)),
                      onPressed: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        setState(() {
                          sp.clear();
                          STM().finishAffinity(context, const Login());
                        });
                      },
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: Sty().mediumtext.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                title: Text('Delete Account',
                                    style: Sty().mediumtext),
                                content: Text(
                                    'Are you sure want to delete account?',
                                    style: Sty().smalltext),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        // prfileApis().deleteacc(ctx, setState);
                                        setState(() {
                                          service.invoke('stopService');
                                        });
                                        usermodel.accountdelete(
                                            ctx: ctx, setState: setState);
                                      },
                                      child: Text('Yes',
                                          style: Sty().smalltext.copyWith(
                                              fontWeight: FontWeight.w600))),
                                  TextButton(
                                      onPressed: () {
                                        STM().back2Previous(ctx);
                                      },
                                      child: Text('No',
                                          style: Sty().smalltext.copyWith(
                                              fontWeight: FontWeight.w600))),
                                ],
                              );
                            });
                      },
                      child: Text('Delete My Account',
                          style: Sty().mediumtext.copyWith(
                                color: Colors.red,
                              )),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
