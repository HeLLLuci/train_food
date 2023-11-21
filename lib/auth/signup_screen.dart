import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/decoration.dart';
import '../utils/toast_msg.dart';
import '../widgets/button.dart';
import '../widgets/data_input_card.dart';
import '../widgets/data_input_field.dart';

class SignUpScreen extends StatefulWidget {
   const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final GlobalKey<FormState> restaurantFormKey = GlobalKey<FormState>();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final restaurantNameController = TextEditingController();
   final stationNameController = TextEditingController();
   final restaurantAddressController = TextEditingController();
   final roleItems = ['No','Yes'];
   String defaultRole = 'No';
   bool isRegistering = false;
   bool obscure = false;
   final restaurantsCollection = FirebaseFirestore.instance.collection('Restaurants');
   final usersCollection =FirebaseFirestore.instance.collection('users');

   Future<void> registerUser() async {
     try{
       if(_formKey.currentState!.validate() && defaultRole == 'No'){
         setState(() {
           isRegistering = true;
         });
         UserCredential userCredential =
         await FirebaseAuth.instance
             .createUserWithEmailAndPassword(
           email: emailController.text,
           password: passwordController.text,
         );
         User? user = userCredential.user;
         await usersCollection
             .doc(user!.uid)
             .set({
           'uid': user.uid.toString(),
           'role': defaultRole.toString(),
         }).then((value) async {
           setState(() {
             isRegistering = false;
           });
           successSnac();
           await Future.delayed(const Duration(seconds: 1), () {
             Navigator.pop(context);
           });
         },).onError((error, stackTrace) {
           Utils().showSnacBar(context,"Something went wrong");
           setState(() {
             isRegistering = false;
           });
         });
       }

       if(_formKey.currentState!.validate()
            && restaurantFormKey.currentState!.validate()
           &&  (defaultRole == 'Yes')
           && (restaurantNameController.text.isNotEmpty
               && RegExp(r'^[a-z A-Z0-9]+$').hasMatch(restaurantNameController.text))
           && (stationNameController.text.isNotEmpty
               && RegExp(r'^[a-z A-Z0-9]+$').hasMatch(stationNameController.text))
           && (restaurantAddressController.text.isNotEmpty
               && RegExp(r'^[a-z A-Z0-9]+$').hasMatch(restaurantAddressController.text)))
       {
         setState(() {
           isRegistering = true;
         });
         UserCredential userCredential =
         await FirebaseAuth.instance
             .createUserWithEmailAndPassword(
           email: emailController.text,
           password: passwordController.text,
         );
         User? user = userCredential.user;
         await usersCollection
             .doc(user!.uid)
             .set({
           'uid': user.uid.toString(),
           'role': defaultRole.toString(),
         }).then((value) async {
           await restaurantsCollection.doc(user.uid.toString()).set({
             'Restaurant_Name': restaurantNameController.text.toString(),
             'Station_Name': stationNameController.text.toString(),
             'Restaurant_Address': restaurantAddressController.text.toString(),
             'Closed': false,
             'Restaurant_uid': user.uid.toString(),
           }).then((value) async {
             setState(() {
               restaurantNameController.clear();
               stationNameController.clear();
               restaurantAddressController.clear();
               isRegistering = false;
             });
             successSnac();
             await Future.delayed(const Duration(seconds: 1), () {
               Navigator.pop(context);
             });
           }).onError((error, stackTrace) {
             Utils().showSnacBar(context,"Something went wrong");
             setState(() {
               isRegistering = false;
             });
           });
         },);
       }else{
         enterDetailSnac();
       }
     }catch(e){
       if (e is FirebaseAuthException) {
         if (e.code == 'user-not-found') {
           Utils().showSnacBar(context,"User not found");
         } else if (e.code == 'wrong-password') {
           Utils().showSnacBar(context,"Incorrect password");
         }else if (e.code == 'invalid-email') {
           Utils().showSnacBar(context,"Please check your email");
         } else if (e.code == 'email-already-in-use') {
           Utils().showSnacBar(context,"User already exists, try with another email");
         }else if (e.code == 'weak-password') {
           Utils().showSnacBar(context,"Please enter more than 6 character password");
         }
         else {
           Utils().showSnacBar(context,"Something went wrong\nTry again");
         }
       }
       setState(() {
         isRegistering = false;
       });
     }
   }
   successSnac(){
     Utils().showSnacBar(context,"Registration successful");
   }
   enterDetailSnac(){
     Utils().showSnacBar(context,"Please enter all fields");
   }

   @override
   void dispose() {
     super.dispose();
     emailController.dispose();
     passwordController.dispose();
     restaurantNameController.dispose();
     stationNameController.dispose();
     restaurantAddressController.dispose();
   }

   DropdownMenuItem<String> buildItem(String item) => DropdownMenuItem(
     value: item,
       child: Text(item,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.orange),)
   );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: size.height*0.2,),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataInput( labelText: "Enter email address", controller: emailController, obscureText: false,),
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
                    ),
                  ],
                ),
              )),
          SizedBox(height: size.height*0.01,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                const Text("Want to register shop?  ",style: TextStyle(fontSize: 16)),
                DropdownButton(
                  value: defaultRole,
                  items: roleItems.map(buildItem).toList(),
                  onChanged: (value) => setState(() {
                    defaultRole = value!;
                  }),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height*0.03,),
          (defaultRole == 'Yes')
              ? Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(10),
            decoration: decoration,
            child: Form(
              key: restaurantFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataInputCard(
                    name: "Shop Name",
                    controller: restaurantNameController,
                  ),
                  SizedBox(height: size.height*0.02,),
                  DataInputCard(
                    name: "City",
                    controller: stationNameController,
                  ),
                  SizedBox(height: size.height*0.02,),
                  DataInputCard(
                    name: "Address",
                    controller: restaurantAddressController,
                  ),
                  SizedBox(height: size.height*0.02,),
                ],
              ),
            ),
          )
              :Container(),
          SizedBox(height: size.height*0.05,),
          Container(
            height: 45,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: MyElevatedButton(
                btnName: !isRegistering ? Text("Register",style: myElevatedButtonInnerTextStyle,) : const CircularProgressIndicator(color: Colors.white),
                press: () {
                  if (_formKey.currentState!.validate()) {
                    registerUser();
                  }
                }),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account ?"),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Login")),
            ],
          ),
        ]),
      ),
    );
  }
}