import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import '../utils/dimension.dart';
import '../utils/staticmethods.dart';
import '../utils/styles.dart';
import '../viewmodel/apimodel.dart';

class aboutUs extends StatefulWidget {
  const aboutUs({super.key});

  @override
  State<aboutUs> createState() => _aboutUsState();
}

class _aboutUsState extends State<aboutUs> {
  late BuildContext ctx;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<userViewModel>(context, listen: false)
          .getAboutUsData(ctx: context, setState: setState);
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
          'About Us',
          style: Sty().mediumtext.copyWith(
                fontWeight: FontWeight.w600,
                color: Clr().black1,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Text(
                usermodel.aboutUsContent,
                style: Sty().mediumtext,
              ),
            )
          ],
        ),
      ),
    );
  }
}
