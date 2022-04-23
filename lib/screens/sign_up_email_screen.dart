import 'package:enloquenutrition/main.dart';
import 'package:enloquenutrition/utils/services/authentication_provider.dart';
import 'package:enloquenutrition/utils/services/validation_service.dart';
import 'package:enloquenutrition/utils/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:enloquenutrition/utils/utilities.dart';
import 'package:provider/src/provider.dart';

TextEditingController nameTextFieldController = TextEditingController();
TextEditingController emailTextFieldController = TextEditingController();
TextEditingController passwordTextFieldController = TextEditingController();

class SignUpWithEmailScreen extends StatefulWidget {
  const SignUpWithEmailScreen({ Key? key }) : super(key: key);

  @override
  _SignUpWithEmailScreenState createState() => _SignUpWithEmailScreenState();
}

class _SignUpWithEmailScreenState extends State<SignUpWithEmailScreen> {

  bool isUsernameValidated = true;
  bool isPasswordValidated = true;
  bool isEmailValidated = true;
  
  void Validate()
  {
    setState(() 
    {
      isUsernameValidated = ValidationService().validateUsername(nameTextFieldController.text);
      isEmailValidated = ValidationService().validateEmail(emailTextFieldController.text);
      isPasswordValidated = ValidationService().validatePassword(passwordTextFieldController.text);
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    final availableWidth = MediaQuery.of(context).size.width - (padding * 2);
    final availableHeight = MediaQuery.of(context).size.height - backIconSize - MediaQuery.of(context).viewInsets.bottom;
    
    final logoWidth = availableWidth-150;
    final logoHeight = (availableWidth-150)/4.17;

    return SafeArea
    (
      child: Scaffold
      ( 
        resizeToAvoidBottomInset: false,
        body: Container
        (
          decoration: const BoxDecoration
          (
            image: DecorationImage
            (
              image: AssetImage('assets/images/man-bg-2.jpg'),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(Color.fromRGBO(21, 21, 21, 0.1), BlendMode.dstATop)
            )
          ),
          child: Padding
          (
            padding: const EdgeInsets.all(padding),
            child: SizedBox
            (
              height: availableHeight,
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: 
                [
                  buildHeader(logoWidth, logoHeight),
                  buildBody(availableWidth),
                ],
              ),
            ),
          ),
        )
      )
    );
  }

  Widget buildHeader(double width, double height)
  {
    return Column
    (
      children: 
      [
        Row
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [GoBackIcon(context)],
        ),
        Logo(width, height),
      ],
    );
  }

  Widget buildBody(double width)
  {
    final emailSignUpButton = ElevatedButton.icon(
      onPressed: () async
      {
        try
        {
          Validate();
          if(isUsernameValidated && isEmailValidated && isPasswordValidated)
          {
            final auth = Provider.of<AuthenticationProvider>(context, listen: false);
            await auth.registerWithNameEmailAndPassword(nameTextFieldController.text, emailTextFieldController.text, passwordTextFieldController.text).then
            ((_) 
            {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const EnloqueNutritionApp()), (route) => false);
            });
          }
        } catch(e) {
          if(e.toString().contains("wrong-password"))
          {
            isPasswordValidated = false;
          }
        }
      }, 
      icon: const FaIcon(FontAwesomeIcons.signInAlt, color: Colors.white),
      label: const Text('Sign Up'), 
      style: ButtonStyle
      (
        minimumSize: MaterialStateProperty.all(Size(width, 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(const Color(0xFF7289DA)),
        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
      )
    );

    return Column
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        InputField
        (
          title: 'Name', 
          placeHolder: 'John', 
          errorText: 'Your name is not correct!', 
          isError: !isUsernameValidated,
          controller: nameTextFieldController,
          width: width,
        ),
        InputField
        (
          title: 'Email', 
          placeHolder: 'example@mail.com', 
          errorText: 'This mail is not correct!', 
          isError: !isEmailValidated,
          controller: emailTextFieldController,
          width: width,
        ),
        InputField
        (
          title: 'Password', 
          placeHolder: 'Password', 
          errorText: 'This password is not correct!', 
          isError: !isPasswordValidated,
          obescureText: true,
          controller: passwordTextFieldController,
          width: width,
        ),
        Space(10),
        emailSignUpButton,
      ]
    );
  }
}