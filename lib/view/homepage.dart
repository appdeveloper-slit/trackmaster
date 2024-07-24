// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';
import 'package:trackmaster/utils/bottomnavigation.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:trackmaster/utils/dimension.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/utils/styles.dart';
import 'package:trackmaster/viewmodel/apimodel.dart';

import '../services/apifile.dart';

final service = FlutterBackgroundService();

checkPermission() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool check = await Permission.location.isGranted;
  bool checkDeviceLoc = await Geolocator.isLocationServiceEnabled();

  if (checkDeviceLoc) {
    if (check) {
      Position? position = await Geolocator.getCurrentPosition();
      final apiServices ser = apiServices();

      List<Placemark> list =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      var result = await ser.allApi(
        apiname: 'update_location',
        token: sp.getString('token'),
        type: 'post',
        body: {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
      );
      print(result);
    } else {
      service.invoke('stopService');
    }
  } else {
    service.invoke('stopService');
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    checkPermission();
    service.invoke('setAsBackground');
    service.invoke('update');
  });
}

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  late BuildContext ctx;
  var CustomerDetails;
  List ongoingRideList = [];
  var name;
  bool checkLoc = false;
  bool checkDeLoc = false;
  var lat, lng;

  initializeService() async {
    await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
        autoStartOnBoot: true,
        initialNotificationTitle: 'TrackMaster',
        initialNotificationContent: 'Current Location Fetching...',
      ),
    );
  }

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString('name') ?? '';
    });
    bool check = await Permission.location.isGranted;
    bool checkDeviceLoc = await Geolocator.isLocationServiceEnabled();
    if (checkDeviceLoc) {
      if (check) {
        Position? position = await Geolocator.getCurrentPosition();
        initializeService();
      } else {
        setState(() {
          service.invoke('stopService');
        });
        locationDialog(
          img: 'assets/loc.png',
          title: 'Location permission is required',
          des:
              'Fetching your location to update your current position and check task status',
        );
      }
    } else {
      setState(() {
        service.invoke('stopService');
      });
      AwesomeDialog(
          context: context,
          dialogType: DialogType.noHeader,
          dialogBackgroundColor: Colors.white,
          animType: AnimType.scale,
          width: double.infinity,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Device Location',
                    style: Sty().mediumtext.copyWith(
                        color: Clr().Primarycolor,
                        fontSize: Dim().d16,
                        fontWeight: FontWeight.w700)),
                Text('Please allow device location access',
                    textAlign: TextAlign.center,
                    style: Sty().mediumtext.copyWith(
                        color: Clr().textClr,
                        fontSize: Dim().d14,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: Dim().d20),
                ElevatedButton(
                    onPressed: () async {
                      if (checkDeLoc == true) {
                        STM().back2Previous(ctx);
                        checkDeLoc = false;
                        getSession();
                      } else {
                        AppSettings.openAppSettings(
                                type: AppSettingsType.location)
                            .then((value) {
                          setState(() {
                            checkDeLoc = true;
                          });
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Clr().Primarycolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dim().d16),
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Dim().d12),
                      child: Center(
                        child: Text('Continue',
                            style: Sty().mediumtext.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: Dim().d16)),
                      ),
                    )),
                SizedBox(height: Dim().d20),
              ],
            ),
          )).show();
    }
  }

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<userViewModel>(context as BuildContext, listen: false)
          .getData(ctx: ctx, setState: setState);
      getSession();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final usermodel = Provider.of<userViewModel>(context);
    CustomerDetails =
        usermodel.rideDetails.isEmpty ? null : usermodel.rideDetails;
    ongoingRideList = usermodel.rideDetails.isEmpty
        ? []
        : usermodel.rideDetails['ride_locations'];
    return Scaffold(
      bottomNavigationBar: bottomLayout(0, context),
      appBar: AppBar(
        leading: Container(),
        toolbarHeight: 30.0,
        surfaceTintColor: Colors.transparent,
      ),
      body: usermodel.homeLoading
          ? SizedBox(
              height: MediaQuery.of(ctx).size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/group.png',
                      fit: BoxFit.cover,
                      width: Dim().d300,
                    ),
                    Text(
                      "It looks like you don't have any ongoing rides at the moment. Please head to the 'Assigned Rides' page to start your next journey.",
                      textAlign: TextAlign.center,
                      style: Sty().mediumtext,
                    )
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
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
                            text: ' $name',
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
                              'Order ID: ${CustomerDetails['order_id']}',
                              style: Sty().smalltext.copyWith(
                                    color: Clr().royalblue,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            Text(
                              '${DateFormat('dd MMM yy').format(DateTime.parse('${CustomerDetails['ride_date']} ${CustomerDetails['ride_time']}'))} / ${DateFormat('hh:mm a').format(DateTime.parse('${CustomerDetails['ride_date']} ${CustomerDetails['ride_time']}'))}',
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
                                      CustomerDetails['customer_name'],
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
                                      CustomerDetails['car_model'],
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
                                      CustomerDetails['customer_mobile'],
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
                                      CustomerDetails['car_plate_number'],
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Dim().d16),
                    height: 48.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Clr().jordyblue, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dim().d12),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dim().d14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer No.: ${CustomerDetails['customer_mobile']}',
                            style: Sty().smalltext.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Clr().royalblue,
                                ),
                          ),
                          InkWell(
                            onTap: () {
                              STM().openDialer(
                                  CustomerDetails['customer_mobile']);
                            },
                            child: SvgPicture.asset(
                              'assets/bluecall.svg',
                              height: Dim().d32,
                              width: Dim().d32,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
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
                                text: ' (${CustomerDetails['ride_type']})',
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
                    itemCount: ongoingRideList.length,
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
                                  color: index == 0
                                      ? ongoingRideList[0]['date'] != null
                                          ? Clr().iconcolor
                                          : Clr().bttnColor
                                      : ongoingRideList[index - 1]['date'] !=
                                              null
                                          ? Clr().iconcolor
                                          : Clr().iconClr,
                                  height: Dim().d20,
                                ),
                              ),
                              index == ongoingRideList.length - 1
                                  ? Container()
                                  : Dash(
                                      direction: Axis.vertical,
                                      dashLength: 8.0,
                                      dashGap: 2.0,
                                      length: 160,
                                      dashColor:
                                          ongoingRideList[index]['date'] != null
                                              ? Clr().iconcolor
                                              : Clr().dashedclr,
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
                                  ongoingRideList[index]['location_type'],
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
                                        ongoingRideList[index]['address'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Sty().smalltext.copyWith(
                                              color: Clr().charcole,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dim().d16,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          STM().openMap(
                                            double.parse(ongoingRideList[index]
                                                ['latitude']),
                                            double.parse(ongoingRideList[index]
                                                ['longitude']),
                                          );
                                        },
                                        child: SvgPicture.asset(
                                            'assets/share.svg')),
                                    SizedBox(
                                      width: Dim().d16,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dim().d12,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ongoingRideList[index]['date'] != null
                                      ? Container(
                                          margin:
                                              EdgeInsets.only(right: Dim().d16),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dim().d20,
                                              vertical: 10.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Clr().ConborderClr,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(Dim().d12),
                                            ),
                                          ),
                                          child: Text(
                                            '${DateFormat('dd MMM yy').format(DateTime.parse('${ongoingRideList[index]['date']} ${ongoingRideList[index]['time']}'))} / ${DateFormat('hh:mm a').format(DateTime.parse('${ongoingRideList[index]['date']} ${ongoingRideList[index]['time']}'))}',
                                            style: Sty().smalltext.copyWith(
                                                  color: Clr().textClr,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        )
                                      : usermodel.loading
                                          ? ongoingRideList[index - 1]
                                                      ['date'] !=
                                                  null
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Container()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  right: Dim().d16),
                                              child: SizedBox(
                                                width: Dim().d200,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    STM()
                                                        .checkInternet(
                                                            context, widget)
                                                        .then((value) {
                                                      if (value) {
                                                        index == 0
                                                            ? usermodel
                                                                .updateStatus(
                                                                ctx,
                                                                setState,
                                                                {
                                                                  "ride_location_id":
                                                                      ongoingRideList[
                                                                              index]
                                                                          [
                                                                          'id'],
                                                                  "latitude": ongoingRideList[
                                                                          index]
                                                                      [
                                                                      'latitude'],
                                                                  "longitude":
                                                                      ongoingRideList[
                                                                              index]
                                                                          [
                                                                          'longitude']
                                                                },
                                                              )
                                                            : ongoingRideList[index -
                                                                            1][
                                                                        'date'] !=
                                                                    null
                                                                ? usermodel
                                                                    .updateStatus(
                                                                    type: (ongoingRideList.length -
                                                                                1) ==
                                                                            index
                                                                        ? 'last'
                                                                        : null,
                                                                    ctx,
                                                                    setState,
                                                                    {
                                                                      "ride_location_id":
                                                                          ongoingRideList[index]
                                                                              [
                                                                              'id'],
                                                                      "latitude":
                                                                          ongoingRideList[index]
                                                                              [
                                                                              'latitude'],
                                                                      "longitude":
                                                                          ongoingRideList[index]
                                                                              [
                                                                              'longitude']
                                                                    },
                                                                  )
                                                                : null;
                                                      }
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0),
                                                    backgroundColor: index == 0
                                                        ? Clr().bttnColor
                                                        : ongoingRideList[
                                                                        index -
                                                                            1]
                                                                    ['date'] !=
                                                                null
                                                            ? Clr().bttnColor
                                                            : Clr()
                                                                .bttnColor
                                                                .withOpacity(
                                                                    0.3),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                            Dim().d12),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    ongoingRideList[index]
                                                        ['ride_status'],
                                                    style: Sty()
                                                        .smalltext
                                                        .copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                ),
                                SizedBox(
                                  height: Dim().d12,
                                ),
                                index == ongoingRideList.length - 1
                                    ? Container()
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(right: Dim().d16),
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

  ///location dialog
  locationDialog({title, des, img, type}) {
    return AwesomeDialog(
        context: context as BuildContext,
        dialogType: DialogType.noHeader,
        dialogBackgroundColor: Colors.white,
        animType: AnimType.scale,
        width: double.infinity,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(img, fit: BoxFit.fitWidth),
              Text(title,
                  style: Sty().mediumtext.copyWith(
                      color: Clr().Primarycolor,
                      fontSize: Dim().d16,
                      fontWeight: FontWeight.w700)),
              Text(des,
                  textAlign: TextAlign.center,
                  style: Sty().mediumtext.copyWith(
                      color: Clr().textClr,
                      fontSize: Dim().d14,
                      fontWeight: FontWeight.w400)),
              SizedBox(height: Dim().d20),
              ElevatedButton(
                  onPressed: () async {
                    STM().back2Previous(ctx);
                    getCurrentLct();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Clr().Primarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dim().d16),
                      )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dim().d12),
                    child: Center(
                      child: Text('Continue',
                          style: Sty().mediumtext.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: Dim().d16)),
                    ),
                  )),
              SizedBox(height: Dim().d20),
            ],
          ),
        )).show();
  }

  /// currentLocation
  getCurrentLct() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position? position = await Geolocator.getCurrentPosition();
      initializeService();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        service.invoke('stopService');
      });
      // ignore: use_build_context_synchronously
      AwesomeDialog(
          context: ctx,
          width: double.infinity,
          dialogBackgroundColor: Colors.white,
          dialogType: DialogType.noHeader,
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          body: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Kindly grant location permission through your device settings.',
                        style: Sty().mediumtext.copyWith(
                            color: Clr().Primarycolor,
                            fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: Dim().d12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (checkLoc == true) {
                                  setState(() {
                                    STM().back2Previous(ctx);
                                    checkLoc = false;
                                    getCurrentLct();
                                  });
                                } else {
                                  await Geolocator.openAppSettings()
                                      .then((value) {
                                    setState(() {
                                      checkLoc = true;
                                    });
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Clr().Primarycolor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(Dim().d8),
                                child: Text(
                                  checkLoc == true ? 'Continue' : 'Go Settings',
                                  style: Sty()
                                      .smalltext
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                        ),
                        SizedBox(
                          width: Dim().d12,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  sp.clear();
                                  SystemNavigator.pop();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Clr().Primarycolor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(Dim().d8),
                                child: Text(
                                  'Close App',
                                  style: Sty()
                                      .smalltext
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dim().d12,
                    ),
                  ],
                ),
              );
            },
          )).show();
    }
  }
}
