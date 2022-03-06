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
        DatesBar(1),
        ElevatedButton(onPressed: (){context.read<AuthenticationProvider>().signOut();},child: Text('sign out'),)
      ]
    );
  }

  Widget buildHeader(String username)
  {
    return Row
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
        ListView.builder
        (
          shrinkWrap: true,
          itemCount: numberOfDays,
          itemBuilder: (context, index)
          {
            return Column
            (
              children: 
              [
                DateBox(dayNumber: index),
              ],
            );
          },
        )
      ]
    );
  }
}

class DateBox extends StatefulWidget {
  final int dayNumber;

  const DateBox
  ({ 
    Key? key,
    required this.dayNumber,
  }) : super(key: key);

  @override
  _DateBoxState createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox > {
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
          Text(widget.dayNumber.toString(), style: dateBoxNumberTextStyle,),
        ],
      ),
    );
  }
}