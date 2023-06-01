import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:train_food/widgets/button.dart';
import 'package:train_food/widgets/my_card.dart';
import '../../utils/decoration.dart';
import '../../utils/toast_msg.dart';

class ReviewScreen extends StatefulWidget {
  final String imgUrl;
  final String itemName;
  final String totalPrice;
  final String itemPrice;
  final String quantity;
  final String restaurantsUid;
  final String userName;
  final String trainName;
  final String compartment;
  final String seatNo;
  final String itemTime;
  final String userPhone;
  const ReviewScreen({
    Key? key,
    required this.imgUrl,
    required this.itemName,
    required this.totalPrice,
    required this.quantity,
    required this.itemPrice,
    required this.restaurantsUid,
    required this.userName,
    required this.trainName,
    required this.compartment,
    required this.seatNo,
    required this.userPhone, required this.itemTime,
  }) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _auth = FirebaseAuth.instance;
  final firestoreRestaurants = FirebaseFirestore.instance.collection('Restaurants');
  final firestoreUsers = FirebaseFirestore.instance.collection('users');
  DateTime now = DateTime.now();
  bool isLoading = false;

  void sendOrder() async {
    setState(() {
      isLoading = true;
    });
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await firestoreRestaurants
          .doc(widget.restaurantsUid)
          .collection('Orders')
          .doc(id)
          .set({
        'timestamp': now,
        'itemTime': widget.itemTime,
        'userName': widget.userName.toString(),
        'trainName': widget.trainName.toString(),
        'compartment': widget.compartment.toString(),
        'seatNo': widget.seatNo.toString(),
        'userPhone': widget.userPhone.toString(),
        'itemName': widget.itemName.toString(),
        'itemPrice': widget.itemPrice.toString(),
        'totalPrice': widget.totalPrice.toString(),
        'quantity': widget.quantity.toString(),
      }).then((value) async {
        await firestoreUsers
            .doc(_auth.currentUser!.uid)
            .collection('Orders')
            .doc(id)
            .set({
          'timestamp': now,
          'itemTime': widget.itemTime,
          'itemName': widget.itemName.toString(),
          'itemPrice': widget.itemPrice.toString(),
          'totalPrice': widget.totalPrice.toString(),
          'imgUrl': widget.imgUrl.toString(),
          'quantity': widget.quantity.toString(),
        }).then((value) {
           showDialog();
          setState(() {
            isLoading = false;
          });
        },).onError((error, stackTrace){
          Utils().showSnacBar(context, "Something went wrong");
          setState(() {
            isLoading = false;
          });
        });
        setState(() {
          isLoading = false;
        });
      }).onError((error, stackTrace) {
        Utils().showSnacBar(context, "Something went wrong");
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      Utils().showSnacBar(context, "Something went wrong\ntry again");
      setState(() {
        isLoading = false;
      });
    }
  }

  void showDialog(){
    Utils().dialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("Your order"),
      backgroundColor: allBgClr,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            MyCard(
                padding: myCardPadding,
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.imgUrl),
                    backgroundColor: allBgClr,
                  ),
                  Text(widget.itemName, style: foodNameTextStyle),
                  Text("Rs ${widget.itemPrice}"),
                ],
              ),
            )),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Quantity: ${widget.quantity}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text("Total Amount: Rs ${widget.totalPrice}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
                width: double.maxFinite,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: MyElevatedButton(
                    btnName: (!isLoading) ? const Text("Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600))
                    : const CircularProgressIndicator(color: Colors.white),
                    press: () {
                      sendOrder();
                    }))
          ],
        ),
      ),
    );
  }
}
