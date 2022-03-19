import 'package:enloquenutrition/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:enloquenutrition/utils/utilities.dart';

import 'sign_up_email_screen.dart';
    
TextEditingController emailTextFieldController = TextEditingController();
TextEditingController passwordTextFieldController = TextEditingController();

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) 
  {
    final availableWidth = MediaQuery.of(context).size.width;
    final availableHeight = MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom- (padding*2);
    
    final logoWidth = availableWidth - 150;
    final logoHeight = availableWidth/4.17;

    final emailSignInButton = ElevatedButton.icon(
      onPressed: () 
      {
        try
        {
          Navigator.push
          (
            context, 
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }catch(e){
          print(e);
        }
      }, 
      icon: const Icon(CupertinoIcons.arrow_right_square_fill, color: Colors.white),
      label: const Text('Log in'), 
      style: ButtonStyle
      (
        minimumSize: MaterialStateProperty.all(Size(availableWidth - (padding * 2), 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(accentColor),
        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
      )
    );

    final googleSignInButton = ElevatedButton.icon(
      onPressed: () {}, 
      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white),
      label: const Text('Continue with Google'), 
      style: ButtonStyle
      (
        minimumSize: MaterialStateProperty.all(Size(availableWidth - (padding * 2), 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: MaterialStateProperty.all(accentColor),
        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700))
      ),
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
              image: AssetImage('assets/images/man-bg.jpg'),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(Color.fromRGBO(21, 21, 21, 0.1), BlendMode.dstATop)
            )
          ),
          child: Padding
          (
            padding: const EdgeInsets.all(padding),
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.end,
              children: 
              [
                Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    SizedBox
                    (
                      height: availableHeight/2,
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      height: availableHeight/2,
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          const Text('Change your body with one click!', style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                          Space(10),
                          emailSignInButton,
                          Space(10),
                          googleSignInButton,
                          Space(10),
                          Row
                          (
                            children: 
                            [
                              const Text("Don't have an account?", style: TextStyle(color: Colors.white, fontFamily: "Poppins"),),
                              TextButton
                              (
                                onPressed: ()
                                {
                                  Navigator.push
                                  (
                                    context, 
                                    MaterialPageRoute(builder: (context) => const SignUpWithEmailScreen()),
                                  );
                                }, 
                                child: const Text("Sign up!", style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontWeight: FontWeight.w700)),
                                style: TextButton.styleFrom
                                (
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                                ),
                              )
                            ],
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