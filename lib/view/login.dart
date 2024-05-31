import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/view/homepage.dart';

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

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                // controller: userCtrl,
                cursorColor: Clr().Primarycolor,
                style: Sty().mediumtext,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                      hintStyle: Sty().smalltext.copyWith(
                            color: Colors.grey,
                          ),
                      hintText: "Username",
                      counterText: "",
                      // prefixIcon: Icon(
                      //   Icons.call,
                      //   color: Clr().lightGrey,
                      // ),
                    ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This filed is required';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              TextFormField(
                // controller: passwordCtrl,
                cursorColor: Clr().Primarycolor,
                maxLength: 10,
                style: Sty().mediumtext.copyWith(
                      color: Clr().black1,
                    ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                obscureText: isHidden,
                decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintStyle: Sty().smalltext.copyWith(
                            color: Colors.grey,
                          ),
                      hintText: 'Enter your Password',
                      counterText: '',
                      // prefixIcon: Icon(
                      //   Icons.lock,
                      //   color: Clr().lightGrey,
                      // ),
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
                  if (value!.isEmpty || !RegExp(r'(.{10,})').hasMatch(value)) {
                    return 'invalid password';
                  } else {
                    return null;
                  }
                },
              ),
               SizedBox(
                height: Dim().d12,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: Sty().microText.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Clr().bttnColor,
                        ),
                  )),
              SizedBox(
                height: Dim().d40,
              ),
              SizedBox(
                height: 48.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    STM().finishAffinity(ctx, const Homeview());
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
    );
  }
}
