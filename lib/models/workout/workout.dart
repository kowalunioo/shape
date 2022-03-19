import 'workout_exercise.dart';

class Workout
{
  int id; //#0
  String name; //Legs
  String description; //Legs
  List<WorkoutExercise> exercises;

  Workout
  ({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
  });
}