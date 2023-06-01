import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:train_food/utils/decoration.dart';
import '../../utils/toast_msg.dart';
import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';

class UpdateItemScreen extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final String deliveryTime;
  final String itemDescription;
  final String itemId;
  final bool available;
  final bool specialDish;
  const UpdateItemScreen({Key? key, required this.itemName, required this.itemPrice, required this.deliveryTime, required this.itemDescription, required this.itemId, required this.available, required this.specialDish}) : super(key: key);

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {

  @override
  void initState() {
    super.initState();
    nameController.text = widget.itemName;
    priceController.text = widget.itemPrice;
    timeController.text = widget.deliveryTime;
    itemDescriptionController.text = widget.itemDescription;
    available = widget.available;
    specialDish = widget.specialDish;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController itemDescriptionController = TextEditingController();
  bool loading = false;
  bool specialDish = false;
  bool available = false;
  final firestore = FirebaseFirestore.instance.collection('Restaurants');
  final _auth = FirebaseAuth.instance;

  void updateFoodItem() async {
    setState(() {
      loading = true;
    });
      firestore
          .doc(_auth.currentUser!.uid)
          .collection("FoodItems")
          .doc(widget.itemId)
          .update({
        'itemName': nameController.text.toString(),
        'itemPrice': priceController.text.toString(),
        'time': timeController.text.toString(),
        'specialDish': specialDish,
        'available': available,
        'itemDescription': itemDescriptionController.text.toString(),
      }).then((value) {
        setState(() {
          loading = false;
        });
        Utils().showSnacBar(context, "Item Updated");
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utils().showSnacBar(context, "Something went wrong");
      });

  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    priceController.dispose();
    timeController.dispose();
    itemDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("Update Item"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(10),
                decoration: decoration,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataInputCard(
                        name: "Item Name",
                        controller: nameController,
                        keyBoardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      DataInputCard(
                        name: "Item Price",
                        controller: priceController,
                        keyBoardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      DataInputCard(
                        name: "Delivery Time",
                        controller: timeController,
                        keyBoardType: TextInputType.number,
                        helperText: "In minutes",
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      DataInputCard(
                        name: "Description",
                        controller: itemDescriptionController,
                        keyBoardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          const Text("Is this your special item",
                              style: TextStyle(fontSize: 16)),
                          Checkbox(
                            value: specialDish,
                            onChanged: (value) {
                              setState(() {
                                specialDish = !specialDish;
                              });
                            },
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          (available) ? const Text("Currently available",
                              style: TextStyle(fontSize: 16))
                          : const Text("Currently not available",
                              style: TextStyle(fontSize: 16)),
                          Checkbox(
                            value: available,
                            onChanged: (value) {
                              setState(() {
                                available = !available;
                              });
                            },
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                width: double.maxFinite,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: MyElevatedButton(
                    btnName: (!loading)
                        ? const Text("Update",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600))
                        : CircularProgressIndicator(color: allBgClr),
                    press: () {
                      updateFoodItem();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
