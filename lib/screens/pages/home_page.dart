import 'package:enloquenutrition/utils/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:enloquenutrition/utils/utilities.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    return Column
    (
      children:
      [
        buildHeader(user?.displayName ?? 'User'),
        DatesBar(25),
        ElevatedButton(onPressed: (){context.read<AuthenticationProvider>().signOut();},child: Text('sign out'),)
      ]
    );
  }

  Widget buildHeader(String username)
  {
    return Row //Header
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: 
      [
        Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            const Text("Hello,", style: titleRegularTextStyle),
            Text(username, style: titleBoldTextStyle),
          ],
        )
      ]
    );
  }

  Widget DatesBar(int numberOfDays)
  {
    return Row
    (
      children: 
      [
        DateBox(),
        DateBox(),
        DateBox(),
        DateBox(),
        DateBox(),
        DateBox(),
      ]
    );
  }
}

class DateBox extends StatelessWidget {
  const DateBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container
    (
      width: 50,
      height: 70,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration
      (
        border: Border.all( color: primaryColor ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column
      (
        children: 
        [
          Text("Day", style: dateBoxDayTextStyle),
          Text("1", style: dateBoxNumberTextStyle,),
        ],
      ),
    );
  }
}