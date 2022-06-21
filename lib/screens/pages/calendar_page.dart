import 'package:enloquenutrition/models/workout/workout.dart';
import 'package:enloquenutrition/models/workout/exercise.dart';
import 'package:enloquenutrition/utils/services/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enloquenutrition/utils/utilities.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/src/provider.dart';

ScrollController dayBarScrollController = ScrollController();
int selectedIndex = 0;
User? user;

class CalendarPage extends StatefulWidget 
{
  const CalendarPage({ Key? key }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> 
{
  @override
  Widget build(BuildContext context) 
  {
    final auth = Provider.of<AuthenticationProvider>(context, listen: true);
    User? user = auth.firebaseAuth.currentUser;
    final Future<String?> futureUsername = Future.value(user?.displayName);

    return Padding(
      padding: const EdgeInsets.fromLTRB(padding,padding,padding,0),
      child: FutureBuilder
      (
        future: futureUsername,
        builder: (context, AsyncSnapshot<String?> snapshot)
        {
          List<Widget> children;
          if(snapshot.hasData)
          {
            final username = snapshot.data!;
            children = <Widget>
            [
              buildHeader(username),
              datesBar(25),
              Workout(id: 1, name: 'Chest', description: 'Pump your chest with some pushups!', exercises: []),
              ElevatedButton(onPressed: (){auth.signOut();},child: const Text('sign out'))
            ];
          }
          else if(snapshot.hasError)
          {
            children = [];
          }
          else
          {
            children = <Widget>
            [
              const CupertinoActivityIndicator(),
            ];
          }
          return SafeArea
          (
            child: Scaffold
            (
              body: Column
              (
                children: children,
              ),
            )
          );
        },
      ),
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

  Widget datesBar(int numberOfDays)
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
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: numberOfDays,
            itemBuilder:(context,index)
            {
              return GestureDetector
              (
                onTap: () => setState(() 
                {
                  selectedIndex = index;
                }),

                child: Container
                (
                  width: 64,
                  margin: const EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration
                  (
                    color: selectedIndex==index?accentColor:Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column
                  (
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: 
                    [
                      const Text("Day", style: dateBoxDayTextStyle),
                      Text((index+1).toString(), style: dateBoxNumberTextStyle,),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ]
    );
  }
}