import 'package:enloquenutrition/main.dart';
import 'package:enloquenutrition/screens/home_screen.dart';
import 'package:enloquenutrition/utils/services/authentication_provider.dart';
import 'package:enloquenutrition/utils/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enloquenutrition/utils/utilities.dart';
import 'package:provider/src/provider.dart';

TextEditingController emailTextFieldController = TextEditingController();
TextEditingController passwordTextFieldController = TextEditingController();
bool _passwordError = false;
bool _emailError = false;


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) 
  {
    final availableWidth = MediaQuery.of(context).size.width - (padding * 2);
    final availableHeight = MediaQuery.of(context).size.height - backIconSize - MediaQuery.of(context).viewInsets.bottom;
    
    final logoWidth = availableWidth - 150;
    final logoHeight = availableWidth/4.17;

    return SafeArea
    (
      child: GestureDetector
      (
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
        ),
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
    final emailSignInButton = ElevatedButton.icon(
      onPressed: () async 
      {
        try
        {
          final auth = Provider.of<AuthenticationProvider>(context, listen: false);
          await auth.signInWithEmailAndPassword(emailTextFieldController.text, passwordTextFieldController.text).then
          ((_){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => const EnloqueNutritionApp()), (route) => false);
          });
        } catch(e) {
          if(e.toString().contains("wrong-password"))
          {
            _passwordError = true;
          }
          else
          {
            _emailError = true;
            _passwordError = true;
            print(e.toString());
          }
        }
      }, 
      icon: const FaIcon(FontAwesomeIcons.signInAlt, color: Colors.white),
      label: const Text('Log in'), 
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
      children: 
      [
        InputField
        (
          title: 'Email', 
          placeHolder: 'example@mail.com', 
          errorText: 'There is no such email singed up in enloque nutrition!', 
          controller: emailTextFieldController,
          isError: _emailError,
          width: width,
        ),
        Space(10),
        InputField
        (
          title: 'Password', 
          placeHolder: 'Password', 
          errorText: 'This password is not correct!', 
          controller: passwordTextFieldController,
          isError: _passwordError,
          obescureText: true,
          width: width,
        ),
        Space(10),
        emailSignInButton,
        Space(10),
        Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            TextButton
            (
              onPressed: (){}, 
              child: const Text("Forgot password?", style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w700)),
              style: TextButton.styleFrom
              (
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
            )
          ]
        )
      ],
    );
  }
}