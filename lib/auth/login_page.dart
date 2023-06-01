import 'dart:async';
import 'package:flutter/material.dart';
import 'package:train_food/auth/signup_screen.dart';
import 'package:train_food/auth/splash_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/decoration.dart';
import '../utils/toast_msg.dart';
import '../widgets/button.dart';
import '../widgets/data_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = false;
  bool obscure = false;
  final _auth = FirebaseAuth.instance;
  SplashServices splashServices = SplashServices();

  void loginWithRole() async {
    setState(() {
      isLogin = true;
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      String res = await checkLogin();
      if(res == "success"){
        setState(() {
          isLogin = false;
        });
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          Utils().showSnacBar(context,"User not found");
        } else if (e.code == 'wrong-password') {
          Utils().showSnacBar(context,"Incorrect password");
        } else if (e.code == 'invalid-email') {
          Utils().showSnacBar(context,"Please check your email");
        } else {
          Utils().showSnacBar(context,"Something went wrong");
        }
      }
      setState(() {
        isLogin = false;
      });
    }
  }

  checkLogin() async {
    String res = await SplashServices().isLogin(context);
    return res;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
          SizedBox(height: size.height*0.3,),
          Form(
              key: _formKey,
              child: Padding(
                padding: btnTextFieldPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataInput(labelText:  "Enter email", controller: emailController, obscureText: false,),
                    SizedBox(height: size.height*0.06,),
                    DataInput(labelText: "Enter password", controller: passwordController,obscureText: !obscure),
                    SizedBox(height: size.height*0.001,),
                    TextButton(
                        onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                        child: const Text("Show password")
                    )
                  ],
                ),
              )),
              SizedBox(height: size.height*0.06,),
          Container(
            height: 45,
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: MyElevatedButton(
                btnName: !isLogin
                    ? Text(
                        "Login",
                        style: myElevatedButtonInnerTextStyle,
                      )
                    : const CircularProgressIndicator(color: Colors.white),
                press: () {
                  if (_formKey.currentState!.validate()) {
                    loginWithRole();
                  }
                }),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account ?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: const Text("SignUp")),
            ],
          ),
        ]),
      ),
    );
  }
}
