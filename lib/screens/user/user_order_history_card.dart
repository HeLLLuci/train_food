import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/decoration.dart';

class UserOrderHistoryCard extends StatefulWidget {
  final String imgUrl;
  final String itemName;
  final String itemPrice;
  final String quantity;
  final Timestamp timestamp;
  final String itemTime;
  final String totalPrice;
  const UserOrderHistoryCard({Key? key, required this.imgUrl, required this.itemName, required this.itemPrice, required this.quantity, required this.timestamp, required this.itemTime, required this.totalPrice}) : super(key: key);

  @override
  State<UserOrderHistoryCard> createState() => _UserOrderHistoryCardState();
}

class _UserOrderHistoryCardState extends State<UserOrderHistoryCard> {
  DateTime? firestoreDateTime;
  Timer? timer;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    fetchFirestoreDateTime();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchFirestoreDateTime() {
        setState(() {
          firestoreDateTime = (widget.timestamp).toDate();
        });
        startTimer();
  }
  void startTimer() {
    final int itemTime = int.parse(widget.itemTime);
    const interval = Duration(seconds: 1);
    var limit = Duration(minutes: itemTime);

    timer = Timer.periodic(interval, (t) {
      final currentTime = DateTime.now();
      final timeDifference = currentTime.difference(firestoreDateTime!);

      if (timeDifference >= limit) {
        if(mounted){
        timer!.cancel();
        }
        setState(() {
          progress = 1.0;
        });
      } else {
        setState(() {
          progress = timeDifference.inMilliseconds / limit.inMilliseconds;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(3),
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(widget.imgUrl.toString()),
              backgroundColor: allBgClr,
            ),
            const SizedBox(width: 20,),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      widget.itemName.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: foodNameTextStyle
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Rs ${widget.itemPrice.toString()}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Quantity ${widget.quantity.toString()}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMd().format(
                          widget.timestamp.toDate(),
                        ),
                        style: const TextStyle(
                            fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        DateFormat.jmv().format(
                          widget.timestamp.toDate(),
                        ),
                        style: const TextStyle(
                            fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Delivery time ${widget.itemTime.toString()} min",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total Price Rs ${widget.totalPrice.toString()}",
                    style: const TextStyle(color: Colors.green),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,),
                  const SizedBox(
                    height: 10,
                  ),
                  (progress == 1.0) ? Row(
                    children: [
                      const Text("Delivered",style: TextStyle(
                        color: Colors.green,),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,),
                      const SizedBox(width: 3,),
                      Icon(Icons.check_circle_outline_sharp,size: 16,color: orangeTextClr,)
                    ],
                  ) :LinearProgressIndicator(
                      minHeight: 7,
                      backgroundColor:(progress==1.0) ? Colors.green :allBgClr,
                      value: progress
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
