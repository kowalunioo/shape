import 'package:enloquenutrition/utils/authentication_provider.dart';
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

  @override
  Widget build(BuildContext context) 
  {
    final availableWidth = MediaQuery.of(context).size.width - (padding * 2);
    final availableHeight = MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - backIconSize - MediaQuery.of(context).viewInsets.bottom;
    
    final logoWidth = availableWidth-150;
    final logoHeight = (availableWidth-150)/4.17;

    final isUsernameError;
    final isEmailError;
    final isPasswordError;

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
                  buildBody(availableWidth)
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
      //crossAxisAlignment: CrossAxisAlignment.center,
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
      onPressed: () 
      {
        try
        {
          context.read<AuthenticationProvider>().registerWithNameEmailAndPassword(nameTextFieldController.text, emailTextFieldController.text, passwordTextFieldController.text);  
        } catch(e) {
          print(e);
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
          controller: nameTextFieldController,
          width: width,
        ),
        InputField
        (
          title: 'Email', 
          placeHolder: 'example@mail.com', 
          errorText: 'This mail is not correct!', 
          controller: emailTextFieldController,
          width: width,
        ),
        InputField
        (
          title: 'Password', 
          placeHolder: 'Password', 
          errorText: 'This password is not correct!', 
          controller: passwordTextFieldController,
          width: width,
        ),
        Space(10),
        emailSignUpButton,
      ]
    );
  }
}