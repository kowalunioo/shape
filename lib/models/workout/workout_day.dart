import 'workout.dart';

class WorkoutDay
{
  int dayNumber;
  bool isComplete;
  List<Workout> workouts;

  WorkoutDay
  ({
    required this.dayNumber,
    required this.isComplete,
    required this.workouts,
  });
}