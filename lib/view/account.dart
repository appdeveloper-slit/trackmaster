import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackmaster/utils/staticmethods.dart';
import 'package:trackmaster/utils/styles.dart';
import 'package:trackmaster/view/login.dart';

import '../utils/bottomnavigation.dart';

class accountPage extends StatefulWidget {
  const accountPage({super.key});

  @override
  State<accountPage> createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomLayout(3, context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  setState(() {
                    sp.clear();
                    STM().finishAffinity(context, const Login());
                  });
                },
                child: Center(
                  child: Text(
                    'Log Out',
                    style: Sty().mediumtext,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
