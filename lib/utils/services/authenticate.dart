import 'package:enloquenutrition/screens/home_screen.dart';
import 'package:enloquenutrition/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_provider.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    final auth = Provider.of<AuthenticationProvider>(context, listen: false);
    return StreamBuilder<User?>
    (
      stream: auth.authState,
      builder: (context, snapshot)
      {
        if(snapshot.connectionState == ConnectionState.active)
        {
          final user = snapshot.data;
          return user != null ? const HomeScreen() : const WelcomeScreen();
        }
        return const Scaffold
        (
          body: Center(child: CircularProgressIndicator())
        );
      }
    );
  }
}