import 'package:enloquenutrition/models/workout/exercise.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.ref();

DatabaseReference AddNewExercise(Exercise exercise) 
{
  var id = databaseReference.child('exercises').push();
  id.set(exercise.toJson());
  return id;
}