import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider 
{
  final FirebaseAuth firebaseAuth;
  AuthenticationProvider(this.firebaseAuth);

  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  Future registerWithNameEmailAndPassword(String name, String email, String password) async
  {
    try 
    {
      if(name != "")
      {
        UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        User user = result.user!;
        user.updateDisplayName(name);
      } else {
        throw Exception("Can't find username.");
      }
    } catch(e) {
      print(e.toString());
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async
  {
    try 
    {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
    } catch(e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async 
  {
    await firebaseAuth.signOut();
  }
}