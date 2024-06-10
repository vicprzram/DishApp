
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dishapp/utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/MainMenu.dart';

void addUser(){

}

class Authentication {
  Future<String> registration({
    required Usuario user
  }) async {
    try {
      List<String> listaVacia = [];
      Map<String, dynamic> mapaVacio = {"recipes": listaVacia};
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password);
      User? u = result.user;
      u?.updateDisplayName(user.username.toString());
      await FirebaseDatabase.instance.ref('users').update({
        user.username : {
          "email" : user.email
        }
      });
      await FirebaseFirestore.instance.collection("favourites").doc(user.username).set({"recipes":FieldValue.arrayUnion([])});
      return 'Success';
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message!;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String emailOrPassword,
    required String password,
  }) async {
    try {
      if(emailOrPassword.contains('@')){
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailOrPassword,
          password: password,
        );
      }else{
        DatabaseReference databaseReference = FirebaseDatabase.instance.ref('users/$emailOrPassword').child('email');
        var snapshot = await databaseReference.get();
        final String email = snapshot.value.toString();
        if(email.isEmpty == false){
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        }else{
          return 'No user found for that username';
        }
      }

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
        if(result.user != null){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
        }

        print("no fufa");
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
