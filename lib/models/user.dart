import 'workout/workout_plan.dart';

class User
{
  bool isAdmin = false;
  //WorkoutPlan workoutPlan = null ;

  User();

  Map<String, dynamic> toJson() =>
  {
    'isAdmin' : isAdmin,
  };
}