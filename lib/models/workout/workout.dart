import 'package:enloquenutrition/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'exercise.dart';

class Workout extends StatefulWidget {
    final int id; //#0
    final String name; //Legs
    final String description; //Legs
    final List<Exercise> exercises;
    final bool complete;

  const Workout
  ({ 
    Key? key,
    required this.id, //#0
    required this.name, //Legs
    required this.description, //Legs
    required this.exercises,
    this.complete = false,
  }) : super(key: key);

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector
    (
      child: Container
      (
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration
        (
         color: accentColor, 
         borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              Row
              (
                children: 
                [
                  Text(widget.name,style: titleBoldTextStyle),
                  const Spacer(),
                  if(widget.complete)...[const Icon(CupertinoIcons.check_mark, color: primaryColor)]
                ],
              ),
              Row
              (
                children: 
                [
                  Expanded
                  (
                    child: Column
                    (
                      children:
                      [
                        Text(widget.description,style: bodyTextStyle, overflow: TextOverflow.ellipsis, maxLines: 2,)
                      ]
                    ),
                  ),
                  Expanded
                  (
                    child: Column
                    (
                      
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}