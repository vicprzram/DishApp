import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:dishapp/utilities/Utilities.dart';

class Authentication {
  Future<String> registration({
    required Usuario user
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password);
      await FirebaseDatabase.instance.ref('users').set({
        user.username : {
          "email" : user.email
        }
      });
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
        print("Entre");
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
          print("Esta correcto");
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

}
