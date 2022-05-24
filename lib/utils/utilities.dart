import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFF151515);
const Color primaryColor = Color(0xFFFFFFFF);
const Color accentColor = Color(0xFF7289DA);
const Color errorColor = Color(0xFFDF2935);
const Color notActiveColor = Color(0xB3FFFFFF);

const double padding = 25; 
const double backIconSize = 25;

const TextStyle titleBoldTextStyle = TextStyle
                                 (
                                   color: Colors.white,
                                   fontSize: 22,
                                   fontWeight: FontWeight.w700,
                                 );

const TextStyle titleRegularTextStyle = TextStyle
                                 (
                                   color: Colors.white,
                                   fontSize: 22,
                                   fontWeight: FontWeight.w400,
                                 );

const TextStyle bodyTextStyle = TextStyle
                                 (
                                   color: Colors.white,
                                   fontSize: 15,
                                   fontWeight: FontWeight.w400,
                                 );

const TextStyle dateBoxDayTextStyle = TextStyle
                                 (
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.w400,
                                 );

const TextStyle dateBoxNumberTextStyle = TextStyle
                                 (
                                   color: Colors.white,
                                   fontSize: 20,
                                   fontWeight: FontWeight.w700,
                                 );

Widget Space(double height){return SizedBox(height: height);}

Widget GoBackIcon(BuildContext context)
{
  return IconButton
  (
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
    splashColor: const Color.fromRGBO(0, 0, 0, 0),
    highlightColor: const Color.fromRGBO(0, 0, 0, 0),
    iconSize: backIconSize,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
  );
}

Widget Logo(double width, double height)
{
  return Container
  (
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    height: height,
    width: width,
    //decoration: const BoxDecoration(color: Colors.white)
    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/enloquenutrition_logo.png'), fit: BoxFit.contain))
  );
}

String GenerateRandomID(int length)
{
  Random random = Random();
  String generatedID = String.fromCharCodes(List.generate(length, (index) => random.nextInt(33)+89));
  return generatedID;
}