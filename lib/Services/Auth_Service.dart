import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  AuthService._();
  static AuthService authService=AuthService._();

  FirebaseAuth auth=FirebaseAuth.instance;
  Future<void> createAccount(String email,String password)
  async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> loginAccount(String email,String password)
  async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOutAccount()
  async {
    await auth.signOut();
  }

  User? getCurrentUser()
  {
    User? user=auth.currentUser;
    return user;
  }
}