import 'dart:io';

import 'package:enloquenutrition/screens/add_new_exercise_screen.dart';
import 'package:enloquenutrition/utils/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../utils/utilities.dart';

class Exercise
{
  DatabaseReference? _id;
  String name;
  int duration;
  String videoFileName;
  String thumbnailFileName;
  
  Exercise(this.name, this.duration, this.thumbnailFileName, this.videoFileName);

  void setID(DatabaseReference id)
  {
    _id = id;
  }

  Map<String, dynamic> toJson()
  {
    return 
    {
      'name': name,
      'duration': duration,
      'videoFileName': videoFileName,
      'thumbnailFileName': thumbnailFileName
    };
  }
}

class ExerciseUI extends StatefulWidget {
  String title;
  int duration;
  bool asPreview;
  Exercise? exercise;

  ExerciseUI
  ({
     Key? key ,
     this.exercise,
     this.title = 'null',
     this.duration = 0,
     this.asPreview = false,
  }) : super(key: key);

  @override
  _ExerciseUIState createState() => _ExerciseUIState();
}

class _ExerciseUIState extends State<ExerciseUI> 
{
  @override
  Widget build(BuildContext context) 
  {
    final Storage storage = Storage();

    if(!widget.asPreview && widget.exercise != null)
    {
      setState(() 
      {
        widget.title = widget.exercise!.name;
        widget.duration = widget.exercise!.duration;
      });
    }
    
    return GestureDetector
    (
      onTap: (){},
      child: Container
      (
        width: double.infinity,
        height: 85,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration
        (
          border: Border.merge(Border(top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1)), Border(top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1)))
        ),
        child: Row
        (
          children: 
          [
            Container
            (
              height: 65,
              width: 116,
              margin: const EdgeInsets.only(right: 5),
              child: (widget.exercise!=null) ? FutureBuilder
              (
                future: storage.retriveThumbnail(widget.exercise!.thumbnailFileName),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot)
                {
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)
                  {
                    return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage(snapshot.data!))));
                  }
                  if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData)
                  {
                    return const CircularProgressIndicator(color: primaryColor, strokeWidth: 1.0);
                  }
                  return const CircularProgressIndicator(color: primaryColor, strokeWidth: 1.0);
                },
              ) : null,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            ),
            Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                Text
                (
                  widget.title, 
                  style: const TextStyle
                  (
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  )
                ),
                Text
                (
                  'Duration: ${widget.duration}s',
                  style: const TextStyle
                  (
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  )
                ),
              ],
            )
          ]
        ),
      ),
    );
  }
}