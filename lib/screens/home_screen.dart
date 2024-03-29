import 'package:enloquenutrition/screens/pages/account_page.dart';
import 'package:enloquenutrition/screens/pages/calendar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enloquenutrition/utils/utilities.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  int currentIndex = 0;
  
  List pages =
  [
    const CalendarPage(),
    const CalendarPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) 
  {
    final availableHeight = MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    final availableWidth = MediaQuery.of(context).size.width;

    return SafeArea
    (
      child: Scaffold
      (
        bottomNavigationBar: BottomNavigationBar
        (
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor.withOpacity(1),
          unselectedItemColor: primaryColor.withOpacity(0.5),
          backgroundColor: backgroundColor,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: 
          const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar_today), label: "Calendar"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill), label: "Home"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_fill), label: "Account"),
          ],
        ),
        body: pages[currentIndex],
      ), 
    );
  }
}