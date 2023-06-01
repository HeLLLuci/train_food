import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:train_food/screens/user/user_order_history_card.dart';
import 'package:train_food/utils/decoration.dart';
import '../../utils/toast_msg.dart';

class UserOrderHistoryScreen extends StatefulWidget {
  const UserOrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<UserOrderHistoryScreen> createState() => _UserOrderHistoryScreenState();
}

class _UserOrderHistoryScreenState extends State<UserOrderHistoryScreen> {
  final firebaseStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Orders')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("My Orders"),
      backgroundColor: allBgClr,
      body: Container(
        height: size.height,
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: firebaseStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: orangeBtnClr));
            }
            if (snapshot.hasError) {
              Utils().showSnacBar(context, "Something went wrong");
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No Orders Found",
                  style: stationTextStyle,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return UserOrderHistoryCard(
                    imgUrl: snapshot.data!.docs[index]['imgUrl'].toString(),
                    itemName: snapshot.data!.docs[index]['itemName'].toString(),
                    itemPrice: snapshot.data!.docs[index]['itemPrice'].toString(),
                    itemTime: snapshot.data!.docs[index]['itemTime'].toString(),
                    quantity: snapshot.data!.docs[index]['quantity'].toString(),
                    timestamp: snapshot.data!.docs[index]['timestamp'],
                    totalPrice: snapshot.data!.docs[index]['totalPrice'].toString(),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
