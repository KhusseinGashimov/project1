import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project1/auth/main_page.dart';
import 'package:project1/pages/home_page.dart';
import 'package:project1/pages/login_page.dart';

class AuthService{

  handleAuthState(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          return HomePage();
        }else{
          return const MainPage();
        }
      },
    );
  }
  signInWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut(){
    FirebaseAuth.instance.signOut();
  }
}