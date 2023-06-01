import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:train_food/screens/admin/update_item_screen.dart';
import '../../utils/decoration.dart';
import '../../utils/toast_msg.dart';
import '../../widgets/my_card.dart';
import 'all_img_card.dart';

class AllItemsScreen extends StatefulWidget {
  const AllItemsScreen({Key? key}) : super(key: key);

  @override
  State<AllItemsScreen> createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  final firestore = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('FoodItems')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    "No Items Found",
                    style: stationTextStyle,
                  ),
            );
          } else {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 2.7),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                      builder: (context) => UpdateItemScreen(
                        itemName: snapshot.data!.docs[index]['itemName'].toString(),
                        itemPrice: snapshot.data!.docs[index]['itemPrice'].toString(),
                        deliveryTime: snapshot.data!.docs[index]['time'].toString(),
                        itemDescription: snapshot.data!.docs[index]['itemDescription'].toString(),
                        itemId: snapshot.data!.docs[index]['ItemId'].toString(),
                        available: snapshot.data!.docs[index]['available'],
                        specialDish: snapshot.data!.docs[index]['specialDish'],
                      ),));
                  },
                  child: AllImgCard(
                    imageUrl: snapshot.data!.docs[index]['url'].toString(),
                    itemName: snapshot.data!.docs[index]['itemName'].toString(),
                    itemPrice: snapshot.data!.docs[index]['itemPrice'].toString(),
                    time: snapshot.data!.docs[index]['time'].toString(),
                    available: snapshot.data!.docs[index]['available'],
                  ),
                );
              },
            );
          }
        });
  }
}
