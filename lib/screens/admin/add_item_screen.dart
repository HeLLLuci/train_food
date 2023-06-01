import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:train_food/utils/decoration.dart';
import 'package:train_food/widgets/my_card.dart';
import '../../utils/toast_msg.dart';
import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController itemDescriptionController = TextEditingController();
  String itemName = '';
  String itemPrice = '';
  String deliveryTime = '';
  String itemDescription = '';
  bool loading = false;
  bool specialDish = false;
  File? _image;
  final picker = ImagePicker();
  final firestore = FirebaseFirestore.instance.collection('Restaurants');
  final _auth = FirebaseAuth.instance;

  Future getImage() async {
    if (_formKey.currentState!.validate() &&
        (nameController.text.isNotEmpty &&
            RegExp(r'^[a-z A-Z0-9]+$').hasMatch(nameController.text)) &&
        (priceController.text.isNotEmpty &&
            RegExp(r'^[0-9]+$').hasMatch(priceController.text)) &&
        (timeController.text.isNotEmpty &&
            RegExp(r'^[0-9]+$').hasMatch(timeController.text))) {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          null;
        }
      });
    } else {
      Utils().showSnacBar(context, "Enter Correct details");
    }
  }

  void uploadFoodItem() async {
    if(_image != null){
      setState(() {
        loading = true;
      });
      var id = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('/FoodImages/$id');
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

      Future.value(uploadTask).then((value) async {
        var imgUrl = await ref.getDownloadURL();
        firestore.doc(_auth.currentUser!.uid)
            .collection("FoodItems")
            .doc(id)
            .set({
          'itemName': itemName.toString(),
          'itemPrice': itemPrice.toString(),
          'time': deliveryTime.toString(),
          'ItemId': id,
          'available': true,
          'specialDish': specialDish,
          'itemDescription': itemDescription.toString(),
          'url': imgUrl.toString(),
          'restaurantsId': _auth.currentUser!.uid.toString(),
        }).then((value) {
          setState(() {
            loading = false;
            nameController.clear();
            priceController.clear();
            timeController.clear();
            itemDescriptionController.clear();
            _image = null;
          });
          Utils().showSnacBar(context, "Item Uploaded");
        }).onError((error, stackTrace) {
          setState(() {
            loading = false;
            specialDish = false;
          });
          Utils().showSnacBar(context, "Something went wrong");
        });
      }).onError((error, stackTrace) {
        Utils().showSnacBar(context, "Something went wrong");
        setState(() {
          loading = false;
        });
      });
    }else{
      Utils().showSnacBar(context, "Upload image");
    }
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
    return Padding(
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
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              getImage();
                              setState(() {
                                itemName = nameController.text.toString();
                                itemPrice = priceController.text.toString();
                                deliveryTime = timeController.text.toString();
                                itemDescription = itemDescriptionController.text.toString();
                              });
                            },
                            child: const Text(
                              "Select Image",
                              style: TextStyle(fontSize: 18),
                            )),
                        (_image != null)
                            ? SizedBox(
                                width: 200,
                                child: MyCard(
                                  padding: myCardPadding,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: FileImage(
                                          _image!.absolute,
                                        ),
                                      ),
                                      Text(
                                        itemName.toString(),
                                        style: foodNameTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text("Rs ${itemPrice.toString()}",
                                          style: foodPriceTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "Delivered in ${deliveryTime.toString()} Min",
                                        style: foodTimeTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const Icon(Icons.image),
                      ],
                    )
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
                      ? const Text("Add",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600))
                      : CircularProgressIndicator(color: allBgClr),
                  press: () {
                    uploadFoodItem();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
