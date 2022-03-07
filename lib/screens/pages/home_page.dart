//ignore_for_file: non_constant_identifier_names

import 'package:enloquenutrition/utils/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:enloquenutrition/utils/utilities.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/src/provider.dart';

ScrollController dayBarScrollController = ScrollController();

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
    return Column
    (
      mainAxisSize: MainAxisSize.min,
      children: 
      [
        SizedBox
        (
          height: 70,
          width: double.infinity,
          child: ListView.builder
          (
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: dayBarScrollController,
            itemCount: numberOfDays,
            itemBuilder: (context, index) => DateBox(dayNumber: index+1, )
          ),
        ),
      ]
    );
  }
}

class DateBox extends StatefulWidget {
  final int dayNumber;
  bool isSelected;

  DateBox
  ({ 
    Key? key,
    required this.dayNumber,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _DateBoxState createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox > {
  @override
  Widget build(BuildContext context) {
    return GestureDetector
    (
      onTap: ()
      {
        setState(() 
        {
          widget.isSelected = !widget.isSelected;  
        });
      },
      child: Container
      (
        width: 64,
        margin: const EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration
        (
          color: widget.isSelected ? accentColor : Colors.white.withOpacity(0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            const Text("Day", style: dateBoxDayTextStyle),
            Text(widget.dayNumber.toString(), style: dateBoxNumberTextStyle,),
          ],
        ),
      ),
    );
  }
}