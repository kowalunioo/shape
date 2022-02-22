import 'package:enloquenutrition/screens/home_screen.dart';
import 'package:enloquenutrition/utils/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enloquenutrition/utils/utilities.dart';
import 'package:provider/src/provider.dart';

TextEditingController emailTextFieldController = TextEditingController();
TextEditingController passwordTextFieldController = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) 
  {
    final availableWidth = MediaQuery.of(context).size.width;
    final availableHeight = MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - backIconSize - MediaQuery.of(context).viewInsets.bottom-(padding*2);
    
    final logoWidth = availableWidth - 150;
    final logoHeight = availableWidth/4.17;

    final emailSignInButton = ElevatedButton.icon(
      onPressed: () async 
      {
        try
        {
          await context.read<AuthenticationProvider>().signInWithEmailAndPassword(emailTextFieldController.text, passwordTextFieldController.text);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => const HomeScreen()), (route) => false);
        }catch(e){
          print(e);
        }
      }, 
      icon: const FaIcon(FontAwesomeIcons.signInAlt, color: Colors.white),
      label: const Text('Log in'), 
      style: ButtonStyle
      (
        minimumSize: MaterialStateProperty.all(Size(availableWidth - (padding * 2), 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(const Color(0xFF7289DA)),
        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
      )
    );

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
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.start,
              children: 
              [
                Row
                (
                  children: [GoBackIcon(context)],
                ),
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    SizedBox
                    (
                      height: availableHeight / 2,
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Logo(logoWidth, logoHeight)],
                      )
                    )
                  ]
                ),
                Row
                (
                  children: 
                  [
                    SizedBox
                    (
                      height: availableHeight / 2,
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          inputField(context, 'Email', emailTextFieldController, false),
                          Space(10),
                          inputField(context, 'Password', passwordTextFieldController, true),
                          Space(10),
                          emailSignInButton,
                          Space(10),
                          Row
                          (
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
                        ]
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      )
    );
  }
}