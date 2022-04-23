import 'dart:io';
import 'package:enloquenutrition/models/workout/exercise.dart';
import 'package:enloquenutrition/screens/pick_media_screen.dart';
import 'package:enloquenutrition/utils/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:enloquenutrition/utils/utilities.dart';
import 'package:enloquenutrition/utils/widgets/input_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

TextEditingController exerciseNameTextController = TextEditingController();
TextEditingController durationTextController = TextEditingController();

class AddNewExerciseScreen extends StatefulWidget {
  const AddNewExerciseScreen({ Key? key }) : super(key: key);

  @override
  State<AddNewExerciseScreen> createState() => _AddNewExerciseScreenState();
}

class _AddNewExerciseScreenState extends State<AddNewExerciseScreen> {

  bool _nameError = false;
  bool _durationError = false;

  File? media;

  @override
  Widget build(BuildContext context) 
  {
    final availableWidth = MediaQuery.of(context).size.width - (padding * 2);
    final addNewExerciseButton = ElevatedButton
    (
      onPressed: ()  
      {
        try
        {
          setState(() 
          {
            if(durationTextController.text.isEmpty){_durationError = true;}else{_durationError = false;}
            if(exerciseNameTextController.text.isEmpty){_nameError = true;}else{_nameError = false;}
          });
          if(_nameError || _durationError) return;
          var newExercise = Exercise(exerciseNameTextController.text, int.parse(durationTextController.text));
          newExercise.setID(AddNewExercise(newExercise));
        }catch(e){
          print(e.toString());
        }
      }, 
      child: const Text('Add new exercise'), 
      style: ButtonStyle
      (
        minimumSize: MaterialStateProperty.all(Size(availableWidth, 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(const Color(0xFF7289DA)),
        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
      )
    );

    return SafeArea
    (
      child: Scaffold
      (
        appBar: AppBar
        (
          leading: GoBackIcon(context), 
          title: const Text("Add New Exercise", style: titleBoldTextStyle), 
          centerTitle: true,
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        body: Padding
        (
          padding: const EdgeInsets.all(padding),
          child: Column
          (
            children: 
            [
              GestureDetector
              (
                onTap: () 
                async
                {
                  final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PickMediaScreen()));
                  setState(()  
                  {
                    media = result;
                  });
                },
                child: Container
                (
                  height: 200,
                  width: availableWidth,
                  child: const Icon(FontAwesomeIcons.plus,color: Colors.white,),
                  decoration:  BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white.withOpacity(0.7),),
                ),
              ),
              if(media != null)...
              [
                TextButton
                (
                  onPressed: ()
                  {
                    setState(() 
                    {
                      media = null;  
                    });
                  }, 
                  child: const Text("Remove media", style: TextStyle(color: primaryColor, fontFamily: "Poppins", fontWeight: FontWeight.w700)),
                )
              ],
              InputField
              (
                title: "Name", 
                placeHolder: "Push ups", 
                errorText: "This Name is not valid!", 
                isError: _nameError,
                controller: exerciseNameTextController, 
                width: availableWidth
              ),
              InputField
              (
                title: "Duration (seconds)", 
                placeHolder: "30", 
                errorText: "Duration is not valid!", 
                isError: _durationError,
                controller: durationTextController, 
                keyboardType: TextInputType.number,
                width: availableWidth
              ),
              Space(10),
              addNewExerciseButton
            ],
          ),
        ),
      ),  
    );
  }
}