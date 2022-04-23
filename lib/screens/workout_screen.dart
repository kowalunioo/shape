import 'dart:async';
import 'package:enloquenutrition/utils/safe_out_of_bounds_list.dart';
import 'package:enloquenutrition/models/workout/exercise.dart';
import 'package:enloquenutrition/models/workout/workout.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  final Workout workout;

  const WorkoutPage({ Key? key, required this.workout, }) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> 
{
  late Workout currentWorkout;
  bool isWorkoutStarted = false;

  late List<Exercise?> exercises = currentWorkout.exercises;

  Timer? timer;
  bool isTimerActive = false;

  int remainingSeconds = 30;

  int index = 0;

  void startTimer()
  {
    timer = Timer.periodic(const Duration(seconds: 1), (_) 
    {
      if(remainingSeconds > 0)
      {
        setState(() 
        {
          isTimerActive = true;
          remainingSeconds--;
        });
        switch(remainingSeconds)
        {
          case 3:
            print('beep');   
            break;
          case 2:
            print('beep');   
            break;
          case 1:
            print('beep');   
            break;
        }
      } 
      else
      {
        stopTimer();
      }
    });
  }

  void stopTimer()
  {
    timer?.cancel();
    setState(() 
    {
      isTimerActive = false;  
    });
  }

  void skipForward()
  {
    if(SafeOutOfBounds().safeOutOfBoundsBool(exercises, index+1))
    {
      setState(() 
      {
        index += 1;
        remainingSeconds = exercises[index]!.duration;
      });
    }
  }

  void skipBackwards()
  {
    if(SafeOutOfBounds().safeOutOfBoundsBool(exercises, index-1))
    {
      setState(() 
      {
        index -= 1;
        remainingSeconds = exercises[index]!.duration;
      });
    }
  }

  void startWorkout()
  {
    if(exercises.isNotEmpty)
    {
      setState(() 
      {
        index = 0;
        remainingSeconds = exercises[index]!.duration;
        isWorkoutStarted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container
    (
      
    );
  }
}