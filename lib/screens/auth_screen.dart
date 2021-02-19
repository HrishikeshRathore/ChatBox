import 'package:chatbox/widgets/auth/auth_form.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String username, bool isLogin, BuildContext ctx) async{

    UserCredential authResult;

    try{
      setState(() {
        _isLoading = true;
      });
      if(isLogin){
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else{
        authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set(
            {
              'username': username,
              'email': email
            });
      }
    }
    on PlatformException catch(err){
      var message = 'An error occured, please check your credentials!';

      if(err.message != null){
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
          SnackBar(content: Text(message),
            backgroundColor: Theme.of(ctx).errorColor,)
      );
      setState(() {
        _isLoading = false;
      });
    }
    catch(err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
