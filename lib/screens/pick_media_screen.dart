import 'dart:io';

import 'package:enloquenutrition/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PickMediaScreen extends StatelessWidget {
  PickMediaScreen({ Key? key }) : super(key: key);

  Future pickVideo(BuildContext context) async
  {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    File? file;
    try
    {
      file = File(video!.path);
      Navigator.of(context).pop(file);
    }catch(e){
      file = null;
    }
  }

  Future pickImage(BuildContext context) async
  {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File? file;
    try
    {
      file = File(image!.path);
      Navigator.of(context).pop(file);
    }catch(e){
      file = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea
    (
      child: Scaffold
      (
        appBar: AppBar
        (
          leading: GoBackIcon(context), 
          title: const Text("Pick media", style: titleBoldTextStyle), 
          centerTitle: true,
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column
          (
            children: 
            [
              ElevatedButton.icon
              (
                onPressed: ()  
                {
                  pickVideo(context);
                },
                icon: const FaIcon(FontAwesomeIcons.film, color: Colors.white),
                label: const Text('Pick Video'), 
                style: ButtonStyle
                (
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF7289DA)),
                  textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
                )
              ), 
              Space(10),
              ElevatedButton.icon
              (
                onPressed: ()  
                {
                  pickImage(context);
                },
                icon: const FaIcon(FontAwesomeIcons.image, color: Colors.white),
                label: const Text('Pick Image'), 
                style: ButtonStyle
                (
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF7289DA)),
                  textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}