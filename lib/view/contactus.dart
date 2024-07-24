import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';
import '../utils/staticmethods.dart';
import '../utils/styles.dart';
import '../viewmodel/apimodel.dart';

class contactUs extends StatefulWidget {
  const contactUs({super.key});

  @override
  State<contactUs> createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<userViewModel>(context, listen: false)
          .getContactUsData(ctx: context, setState: setState);
    });
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
          ),
        ),
        title: Text(
          'Contact Us',
          style: Sty().mediumtext.copyWith(
                fontWeight: FontWeight.w600,
                color: Clr().black1,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: Dim().d40, vertical: Dim().d20),
        child: Column(
          children: [
            SizedBox(
              height: Dim().d28,
            ),
            Image.asset('assets/contactus.jpg'),
            SizedBox(
              height: Dim().d20,
            ),
            Text("Contact Information",
                textAlign: TextAlign.center, style: Sty().mediumtext),
            Text("Have any questions? contact us",
                textAlign: TextAlign.center, style: Sty().smalltext),
            SizedBox(
              height: Dim().d28,
            ),
            Icon(
              Icons.mail,
              color: Clr().Primarycolor,
            ),
            InkWell(
              onTap: () async {
                await launch('mailto:${usermodel.contactdetails['email']}');
              },
              child: Text("Email id: ${usermodel.contactdetails['email']}",
                  textAlign: TextAlign.center, style: Sty().mediumtext),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Icon(
              Icons.call,
              color: Clr().Primarycolor,
            ),
            InkWell(
              onTap: () async {
                await launch('tel:${usermodel.contactdetails['mobile']}');
              },
              child: Text(
                  "Mobile number: ${usermodel.contactdetails['mobile']}",
                  textAlign: TextAlign.center,
                  style: Sty().mediumtext),
            ),
            usermodel.contactdetails['address'] == null
                ? Container()
                : SizedBox(
                    height: Dim().d20,
                  ),
            usermodel.contactdetails['address'] == null
                ? Container()
                : Icon(
                    Icons.home,
                    color: Clr().Primarycolor,
                  ),
            usermodel.contactdetails['address'] == null
                ? Container()
                : Text("Address: ${usermodel.contactdetails['address']}",
                    textAlign: TextAlign.center, style: Sty().mediumtext),
          ],
        ),
      ),
    );
  }
}
