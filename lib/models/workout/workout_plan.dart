import 'workout_day.dart';

class WorkoutPlan
{
  String name;
  List<WorkoutDay> days;

  WorkoutPlan
  ({
    required this.name,
    required this.days,
  });
}