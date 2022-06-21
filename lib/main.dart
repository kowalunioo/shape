import 'package:enloquenutrition/screens/add_new_exercise_screen.dart';
import 'package:enloquenutrition/screens/home_screen.dart';
import 'package:enloquenutrition/screens/welcome_screen.dart';
import 'package:enloquenutrition/utils/services/authenticate.dart';
import 'package:enloquenutrition/utils/services/authentication_provider.dart';
import 'package:enloquenutrition/utils/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const EnloqueNutritionApp());
}

class EnloqueNutritionApp extends StatelessWidget {
  const EnloqueNutritionApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthenticationProvider>
    (
      create: (_) => AuthenticationProvider(FirebaseAuth.instance),
      child: MaterialApp
      (
        title: 'SHAPE BY ENLOQUE.',
        theme: ThemeData
        (
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: backgroundColor,
          primaryColor: backgroundColor,
          pageTransitionsTheme: const PageTransitionsTheme(builders: { TargetPlatform.android: CupertinoPageTransitionsBuilder(), TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),})
        ),
        home: const Authenticate(),
      )
    ); 
  }
}