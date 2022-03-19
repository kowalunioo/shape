import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider 
{
  final FirebaseAuth firebaseAuth;
  AuthenticationProvider(this.firebaseAuth);

  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  Future<User?> registerWithNameEmailAndPassword(String name, String email, String password) async
  {
    try 
    {
      if(name.isNotEmpty)
      {
        await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((newUser) => newUser.user!.updateDisplayName(name));
        User user = firebaseAuth.currentUser!;
        await user.reload();
        return user;
      } else {
        throw Exception("Can't find username.");
      }
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async
  {
    try 
    {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async 
  {
    await firebaseAuth.signOut();
  }
}