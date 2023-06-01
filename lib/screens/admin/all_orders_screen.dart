import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:train_food/utils/decoration.dart';

import '../../utils/toast_msg.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {

  final firebaseStream = FirebaseFirestore.instance
      .collection('Restaurants')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Orders')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: allBgClr,
        elevation: 0,
      ),
      backgroundColor: allBgClr,
      body: Container(
        height: size.height,
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: firebaseStream,
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
                      "No Orders Found",
                      style: stationTextStyle,
                    ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: cardBgClr,
                      elevation: 0,
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: orangeSurfaceClr.withOpacity(0.3),
                          border: Border.all(
                              color: Colors.black12
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.docs[index]['userName'].toString(),
                              style: cardNameTextStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: orderCardClr,
                                  border: const Border(
                                    top: BorderSide(color: Colors.black12),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: size.width * 0.45,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black12),
                                        )
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Item ${snapshot.data!.docs[index]['itemName'].toString()}",
                                          style: orderCardItemNameTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "Rs ${snapshot.data!.docs[index]['itemPrice'].toString()}",
                                          style: cardInfoTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Quantity ${snapshot.data!.docs[index]['quantity'].toString()}",
                                          style: cardInfoTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "Total Price Rs ${snapshot.data!.docs[index]['totalPrice'].toString()}",
                                          style: orderCardTotalPriceTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: orderCardClr,
                                  border: const Border(
                                    top: BorderSide(color: Colors.black12),
                                    bottom: BorderSide(color: Colors.black12),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: size.width * 0.45,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(color: Colors.black12),
                                        )
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Train Name ${snapshot.data!.docs[index]['trainName'].toString()}",
                                          style: cardInfoTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                        Text(
                                          "Seat No ${snapshot.data!.docs[index]['seatNo'].toString()}",
                                          style: cardInfoTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Compartment ${snapshot.data!.docs[index]['compartment'].toString()}",
                                          style: cardInfoTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "Contact ${snapshot.data!.docs[index]['userPhone'].toString()}",
                                          style: cardInfoTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(color: orderCardClr),
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(color: orderCardClr),
                                      child: Row(
                                        children: [
                                          Text(
                                            DateFormat.yMMMd().format(
                                              snapshot.data!.docs[index]['timestamp']
                                                  .toDate(),
                                            ),
                                            style: cardDateTimeTextStyle,
                                          ),
                                          Text(
                                            ", ",
                                            style: cardDateTimeTextStyle,
                                          ),
                                          Text(
                                            DateFormat.jmv().format(
                                              snapshot.data!.docs[index]['timestamp']
                                                  .toDate(),
                                            ),
                                            style: cardDateTimeTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      // width: size.width * 0.45,
                                      decoration: BoxDecoration(color: orderCardClr),
                                      child: Text(
                                        "Delivery time ${snapshot.data!.docs[index]['itemTime'].toString()} min",
                                        style: orderCardItemNameTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
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
