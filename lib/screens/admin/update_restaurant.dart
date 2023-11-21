import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:train_food/utils/decoration.dart';
import '../../utils/toast_msg.dart';
import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';

class UpdateRestaurant extends StatefulWidget {
  const UpdateRestaurant({Key? key}) : super(key: key);

  @override
  State<UpdateRestaurant> createState() => _UpdateRestaurantState();
}

class _UpdateRestaurantState extends State<UpdateRestaurant> {
  final GlobalKey<FormState> restaurantFormKey = GlobalKey<FormState>();
  final restaurantNameController = TextEditingController();
  final stationNameController = TextEditingController();
  final restaurantAddressController = TextEditingController();
  final listItems = ['No', 'Yes'];
  String defaultRole = 'No';
  bool isRegistering = false;
  bool obscure = false;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('Restaurants');

  Future<void> updateRestaurant() async {
    try {
      if (restaurantFormKey.currentState!.validate() &&
          (restaurantNameController.text.isNotEmpty &&
              RegExp(r'^[a-z A-Z0-9]+$')
                  .hasMatch(restaurantNameController.text)) &&
          (stationNameController.text.isNotEmpty &&
              RegExp(r'^[a-z A-Z0-9]+$')
                  .hasMatch(stationNameController.text)) &&
          (restaurantAddressController.text.isNotEmpty &&
              RegExp(r'^[a-z A-Z0-9]+$')
                  .hasMatch(restaurantAddressController.text))) {
        setState(() {
          isRegistering = true;
        });
        await firestore.doc(auth.currentUser!.uid).update({
          'Restaurant_Name': restaurantNameController.text.toString(),
          'Station_Name': stationNameController.text.toString(),
          'Restaurant_Address': restaurantAddressController.text.toString(),
        }).then((value) {
          restaurantNameController.clear();
          stationNameController.clear();
          restaurantAddressController.clear();
          showSnac();
        }).onError((error, stackTrace) {
          Utils().showSnacBar(context, "Something went wrong");
        });
        setState(() {
          isRegistering = false;
        });
      } else {
        Utils().showSnacBar(context, "Please enter all details");
      }
    } catch (e) {
      Utils().showSnacBar(context, "Something went wrong");
      setState(() {
        isRegistering = false;
      });
    }
  }

  showSnac() {
    Utils().showSnacBar(context, "Successfully Updated");
  }

  @override
  void dispose() {
    super.dispose();
    restaurantNameController.dispose();
    stationNameController.dispose();
    restaurantAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("Update Shop"),
      backgroundColor: allBgClr,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(10),
            decoration: decoration,
            child: Form(
              key: restaurantFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataInputCard(
                    name: "Shop Name",
                    controller: restaurantNameController,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  DataInputCard(
                    name: "City",
                    controller: stationNameController,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  DataInputCard(
                    name: "Address",
                    controller: restaurantAddressController,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  SizedBox(
                    height: 45,
                    width: size.width,
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: MyElevatedButton(
                        btnName: !isRegistering ? Text("Update",style: myElevatedButtonInnerTextStyle,) : const CircularProgressIndicator(color: Colors.white),
                        press: () {
                            updateRestaurant();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}