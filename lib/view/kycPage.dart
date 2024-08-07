// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trackmaster/utils/colors.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/viewmodel/apimodel.dart';
import '../utils/dimension.dart';
import '../utils/styles.dart';
import 'viewImage.dart';

class kycpage extends StatefulWidget {
  final type, data;
  const kycpage({super.key, this.data, this.type});

  @override
  State<kycpage> createState() => _kycpageState();
}

class _kycpageState extends State<kycpage> {
  TextEditingController aadharCtrl = TextEditingController();
  TextEditingController panCtrl = TextEditingController();
  File? imageFile, aadharBckFile, aadharFrtFile;
  final _formKey = GlobalKey<FormState>();

  var profile,
      aadharFrt,
      aadharBck,
      shiphide,
      panUrl,
      aadharFrtUrl,
      aadharBckUrl;

  getSession() async {
    if (widget.data != null) {
      setState(() {
        print(widget.data);
        aadharCtrl = TextEditingController(
            text: widget.data['aadhar_card_number'].toString());
        panCtrl = TextEditingController(
            text: widget.data['pan_card_number'].toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usermodel = Provider.of<userViewModel>(context);
    return Scaffold(
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
          'Identity Details',
          style: Sty().mediumtext.copyWith(
                fontWeight: FontWeight.w600,
                color: Clr().black1,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: Dim().d12, vertical: Dim().d12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: aadharCtrl,
                cursorColor: Clr().Primarycolor,
                style: Sty().mediumtext,
                keyboardType: TextInputType.number,
                maxLength: 12,
                textInputAction: TextInputAction.done,
                decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                      hintStyle: Sty().smalltext.copyWith(
                            color: Colors.grey,
                          ),
                      hintText: "Enter Aadhar Card Number",
                      counterText: "",
                    ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Aadhaar card is required';
                  }
                  if (!RegExp(r'^[2-9]\d{11}').hasMatch(value)) {
                    return "Please enter a valid aadhaar card number";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Dim().d12,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dim().d14),
                              topRight: Radius.circular(Dim().d14))),
                      builder: (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dim().d12, vertical: Dim().d20),
                              child: Text('Aadhaar Front Photo',
                                  style: Sty().mediumtext),
                            ),
                            SizedBox(height: Dim().d28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _getProfile(
                                        ImageSource.camera, 'aadhar front');
                                  },
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Clr().Primarycolor,
                                    size: Dim().d32,
                                  ),
                                ),
                                InkWell(
                                    onTap: () async {
                                      _getProfile(
                                          ImageSource.gallery, 'aadhar front');
                                    },
                                    child: Icon(
                                      Icons.yard_outlined,
                                      size: Dim().d32,
                                      color: Clr().Primarycolor,
                                    )),
                              ],
                            ),
                            SizedBox(height: Dim().d40),
                          ],
                        );
                      });
                },
                child: DottedBorder(
                  color: Clr().dottedcolor,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(Dim().d12),
                  //color of dotted/dash line
                  strokeWidth: 1,
                  //thickness of dash/dots
                  dashPattern: [6, 4],
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            aadharFrt != null
                                ? 'Aadhaar front card Image selected'
                                : 'Upload Aadhaar Front Card',
                            style: Sty().smalltext.copyWith(
                                  color: aadharFrt != null
                                      ? Clr().black1
                                      : Clr().slategrey,
                                ),
                          ),
                          SvgPicture.asset(
                            'assets/upload.svg',
                            color: Clr().slategrey,
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: Dim().d12,
              ),
              imageLayout(
                  'Front Side',
                  widget.data != null
                      ? aadharFrtFile ?? widget.data['aadhar_card_front']
                      : aadharFrtFile),
              SizedBox(
                height: Dim().d12,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dim().d14),
                              topRight: Radius.circular(Dim().d14))),
                      builder: (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dim().d12, vertical: Dim().d20),
                              child: Text('Aadhaar Back Photo',
                                  style: Sty().mediumtext),
                            ),
                            SizedBox(height: Dim().d28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _getProfile(
                                        ImageSource.camera, 'aadhar back');
                                  },
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Clr().Primarycolor,
                                    size: Dim().d32,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      _getProfile(
                                          ImageSource.gallery, 'aadhar back');
                                    },
                                    child: Icon(
                                      Icons.yard_outlined,
                                      size: Dim().d32,
                                      color: Clr().Primarycolor,
                                    )),
                              ],
                            ),
                            SizedBox(height: Dim().d40),
                          ],
                        );
                      });
                },
                child: DottedBorder(
                  color: Clr().dottedcolor,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(Dim().d12),
                  //color of dotted/dash line
                  strokeWidth: 1,
                  //thickness of dash/dots
                  dashPattern: [6, 4],
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            aadharBck != null
                                ? 'Aadhaar back card Image selected'
                                : 'Upload Aadhaar Back Card',
                            style: Sty().smalltext.copyWith(
                                  color: aadharBck != null
                                      ? Clr().black1
                                      : Clr().slategrey,
                                ),
                          ),
                          SvgPicture.asset(
                            'assets/upload.svg',
                            color: Clr().slategrey,
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: Dim().d12,
              ),
              imageLayout(
                  'Back Side',
                  widget.data != null
                      ? aadharBckFile ?? widget.data['aadhar_card_back']
                      : aadharBckFile),
              SizedBox(
                height: Dim().d12,
              ),
              TextFormField(
                controller: panCtrl,
                cursorColor: Clr().Primarycolor,
                style: Sty().mediumtext,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                      hintStyle: Sty().smalltext.copyWith(
                            color: Colors.grey,
                          ),
                      hintText: "Enter Pan Card Number",
                      counterText: "",
                    ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Pan card number is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Dim().d12,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dim().d14),
                              topRight: Radius.circular(Dim().d14))),
                      builder: (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dim().d12, vertical: Dim().d20),
                              child: Text('Profile Photo',
                                  style: Sty().mediumtext),
                            ),
                            SizedBox(height: Dim().d28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _getProfile(ImageSource.camera, 'kyc');
                                  },
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Clr().Primarycolor,
                                    size: Dim().d32,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      _getProfile(ImageSource.gallery, 'kyc');
                                    },
                                    child: Icon(
                                      Icons.yard_outlined,
                                      size: Dim().d32,
                                      color: Clr().Primarycolor,
                                    )),
                              ],
                            ),
                            SizedBox(height: Dim().d40),
                          ],
                        );
                      });
                },
                child: DottedBorder(
                  color: Clr().dottedcolor, //color of dotted/dash line
                  borderType: BorderType.RRect,
                  radius: Radius.circular(Dim().d12),
                  strokeWidth: 1, //thickness of dash/dots
                  dashPattern: [6, 4],
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            profile != null
                                ? 'Pan card Image selected'
                                : 'Upload PAN Card',
                            style: Sty().smalltext.copyWith(
                                  color: profile != null
                                      ? Clr().black1
                                      : Clr().slategrey,
                                ),
                          ),
                          SvgPicture.asset(
                            'assets/upload.svg',
                            color: Clr().slategrey,
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: Dim().d12,
              ),
              imageLayout(
                  'Pan Card',
                  widget.data != null
                      ? imageFile ?? widget.data['pan_card']
                      : imageFile),
              SizedBox(
                height: Dim().d20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.data != null) {
                    usermodel.uploadDocumnets(
                      ctx: context,
                      setState: setState,
                      body: {
                        "aadhar_card_front": aadharFrt,
                        "aadhar_card_back": aadharBck,
                        "pan_card": profile,
                        "aadhar_card_number": aadharCtrl.text,
                        "pan_card_number": panCtrl.text,
                      },
                    );
                  } else {
                    if (_formKey.currentState!.validate()) {
                      if (aadharBck == null ||
                          aadharFrt == null ||
                          profile == null) {
                        Fluttertoast.showToast(
                            msg: aadharFrt == null
                                ? 'Please select a aadhaar front image'
                                : aadharBck == null
                                    ? 'Please select a aadhaar back image'
                                    : 'Please select a pan card image');
                      } else {
                        usermodel.uploadDocumnets(
                          ctx: context,
                          setState: setState,
                          body: {
                            "aadhar_card_front": aadharFrt,
                            "aadhar_card_back": aadharBck,
                            "pan_card": profile,
                            "aadhar_card_number": aadharCtrl.text,
                            "pan_card_number": panCtrl.text,
                          },
                        );
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2269D1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dim().d12),
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: Sty().mediumtext.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  imageLayout(side, data) {
    print(data);
    return InkWell(
      onTap: () {
        if (data != null) STM().redirect2page(context, viewImage(img: data));
      },
      child: Container(
        height: Dim().d160,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Color(0xff6C6C6C))),
        child: data != null
            ? data.toString().contains('https://')
                ? Image.network(
                    data.toString(),
                    fit: BoxFit.fitWidth,
                    scale: 1,
                    height: 100,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(data, fit: BoxFit.fitWidth),
                      // Positioned(
                      //   top: 0,
                      //   right: 2,
                      //   child: InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         data = null;
                      //       });
                      //     },
                      //     child: Icon(
                      //       Icons.dangerous,
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      // )
                    ],
                  )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: Dim().d4),
                  SvgPicture.asset('assets/home.svg'),
                  Text(side,
                      style: Sty().mediumtext.copyWith(
                            color: Color(0xff6C6C6C),
                            fontSize: Dim().d14,
                            fontWeight: FontWeight.w600,
                          )),
                  SizedBox(height: Dim().d4),
                  Text('You will see uploaded image of your card.',
                      style: Sty().mediumtext.copyWith(
                          color: Color(0xff6C6C6C),
                          fontWeight: FontWeight.w400,
                          fontSize: Dim().d12)),
                  SizedBox(height: Dim().d4),
                ],
              ),
      ),
    );
  }

  _getProfile(source, type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        STM().back2Previous(context);
        switch (type) {
          case 'kyc':
            {
              panUrl = pickedFile.path.toString();
              imageFile = File(pickedFile.path.toString());
              var image = imageFile!.readAsBytesSync();
              profile = base64Encode(image);
            }
            break;
          case 'aadhar front':
            {
              aadharFrtUrl = pickedFile.path.toString();
              aadharFrtFile = File(pickedFile.path.toString());
              var image = aadharFrtFile!.readAsBytesSync();
              aadharFrt = base64Encode(image);
            }
            break;
          case 'aadhar back':
            {
              aadharBckUrl = pickedFile.path.toString();
              aadharBckFile = File(pickedFile.path.toString());
              print('okoko${aadharBckFile}');
              var image = aadharBckFile!.readAsBytesSync();
              aadharBck = base64Encode(image);
            }
            break;
        }
      });
    }
  }
}
