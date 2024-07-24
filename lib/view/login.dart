// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/view/homepage.dart';
import 'package:trackmaster/viewmodel/apimodel.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';
import '../utils/styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late BuildContext ctx;
  TextEditingController userCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isHidden = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final usermodel = Provider.of<userViewModel>(context);
    ctx = context;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dim().d160,
                ),
                Text(
                  'Start Your\nDrive',
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 44,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: Dim().d40,
                ),
                TextFormField(
                  controller: userCtrl,
                  cursorColor: Clr().Primarycolor,
                  style: Sty().mediumtext,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  textInputAction: TextInputAction.done,
                  decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                        hintStyle: Sty().smalltext.copyWith(
                              color: Colors.grey,
                            ),
                        hintText: "Enter your mobile number",
                        counterText: "",
                      ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    }
                    if (value.length != 10) {
                      return 'Mobile number must be 10 digits long';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Dim().d20,
                ),
                TextFormField(
                  controller: passwordCtrl,
                  cursorColor: Clr().Primarycolor,
                  style: Sty().mediumtext.copyWith(
                        color: Clr().black1,
                      ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  obscureText: isHidden,
                  decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintStyle: Sty().smalltext.copyWith(
                              color: Colors.grey,
                            ),
                        hintText: 'Enter your password',
                        counterText: '',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: 14, top: 12.0, bottom: 12.0),
                          child: InkWell(
                            child: isHidden
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SvgPicture.asset(
                                      'assets/visibility.svg',
                                      color: Colors.grey,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    'assets/visibility_off.svg',
                                    color: Colors.grey,
                                  ),
                            onTap: () {
                              setState(() {
                                isHidden ^= true;
                              });
                            },
                          ),
                        ),
                      ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                // Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       'Forgot Password?',
                //       style: Sty().microText.copyWith(
                //             fontWeight: FontWeight.w600,
                //             color: Clr().bttnColor,
                //           ),
                //     )),
                SizedBox(
                  height: Dim().d40,
                ),
                usermodel.loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Clr().Primarycolor,
                        ),
                      )
                    : SizedBox(
                        height: 48.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              STM()
                                  .checkInternet(context, widget)
                                  .then((value) {
                                if (value) {
                                  usermodel.signUser(
                                    ctx: ctx,
                                    setState: setState,
                                    data: {
                                      'mobile': userCtrl.text,
                                      'password': passwordCtrl.text,
                                    },
                                  );
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            backgroundColor: Clr().Primarycolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dim().d12),
                              ),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: Sty().smalltext.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
