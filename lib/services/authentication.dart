import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //method to sign up user
  Future<String> userSignup({
    required String email,
    required String password,
    required String username,
  }) async {
    String message = "Some error ocurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty|| username.isNotEmpty){
        UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );
        await _firestore.collection('users').doc(user.user!.uid).set({
          'username': username,
          'email': email,
          "uid": user.user!.uid,
        });
        message = "Successful";
      }
    } catch(e){
      return e.toString();
    }
    return message;
  }

  //method to sign in user
  Future<String> userLogin({
    required String email,
    required String password,
  }) async {
    String message = "Some error occured";
    try{
      if(email.isNotEmpty||password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(
          email: email, 
          password: password
        );
        message = "Succesful";  
      } else {
        message = "Please enter email and password";
      }
    } catch(e) {
      return e.toString();
    }
    return message;
  }

  //method to sign out user
  Future<void> signOut() async{
    await _auth.signOut();
  }

}
