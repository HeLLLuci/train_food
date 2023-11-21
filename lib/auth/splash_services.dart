import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:train_food/screens/admin/admin_home_screen.dart';
import 'package:train_food/screens/user/Home_Screen.dart';
import 'package:train_food/screens/user/user_home_screen.dart';
import '../utils/toast_msg.dart';
import 'login_page.dart';

class SplashServices {
  final auth = FirebaseAuth.instance;

  Future<String> isLogin(BuildContext context) async {
    final user = auth.currentUser;
    String res = "Success";
    if (user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        if (data['role'] == 'Yes') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminHomeScreen(),
              ));
        } else if(data['role'] == 'No'){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen_(),
              ));
        }
        else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LoginPage()));
        }
    } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    return res;
  }

  void logOut(BuildContext context) {
    auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const LoginPage()),(route) => false,);
    }).onError((error, stackTrace) {
      Utils().showSnacBar(context,"Something went wrong");
    });
  }
}
