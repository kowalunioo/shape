import 'package:flutter/material.dart';

import '../../utils/utilities.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({ Key? key }) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea
    (
      child: Scaffold
      (
        appBar: AppBar
        (
          title: const Text("Your account", style: titleBoldTextStyle), 
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        body: SingleChildScrollView
        (
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Column
          (
            children: 
            [
              
            ],
          ),
        ),
      ),
    );
  }
}