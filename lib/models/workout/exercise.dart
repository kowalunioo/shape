import 'package:firebase_database/firebase_database.dart';

class Exercise
{
  DatabaseReference? _id;
  String name;
  int duration;
  String? videoFileName;
  String? thumbnailFileName;
  
  Exercise(this.name, this.duration);

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