import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:train_food/screens/admin/all_img_card.dart';
import 'package:train_food/widgets/button.dart';
import '../../utils/decoration.dart';
import '../../utils/toast_msg.dart';
import '../../widgets/my_card.dart';
import 'food_order_screen.dart';

class FoodDescriptionScreen extends StatefulWidget {
  final String itemName;
  final String itemRate;
  final String itemDescription;
  final String imgUrl;
  final String itemTime;
  final String restaurantsUid;
  final bool available;
  final bool restaurantClosed;
  const FoodDescriptionScreen({
    Key? key,
    required this.itemName,
    required this.itemRate,
    required this.itemDescription,
    required this.imgUrl,
    required this.itemTime,
    required this.restaurantsUid,
    required this.available,
    required this.restaurantClosed,
  }) : super(key: key);

  @override
  State<FoodDescriptionScreen> createState() => _FoodDescriptionScreenState();
}

class _FoodDescriptionScreenState extends State<FoodDescriptionScreen> {
  int quantity = 1;
  int? totalPrice;

  void _increaseQuantity() {
    totalPrice = int.parse(widget.itemRate);
    setState(() {
      quantity++;
      totalPrice = totalPrice! * quantity;
    });
  }

  void _decreaseQuantity() {
    totalPrice = int.parse(widget.itemRate);
    setState(() {
      if (quantity > 1) {
        quantity--;
        totalPrice = totalPrice! * quantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9E8E8),
        elevation: 0,
      ),
      backgroundColor: allBgClr,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              decoration: const BoxDecoration(color: Color(0xFFE9E8E8)),
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 150,
                backgroundColor: allBgClr,
                backgroundImage: NetworkImage(widget.imgUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.itemName,
                    style: TextStyle(
                        color: orangeTextClr,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  (!widget.available)
                      ? Text(
                          "Currently Unavailable",
                          style: itemAvailableTextStyle,
                        )
                      : Container(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs ${widget.itemRate}",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: orangeBtnClr,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                _decreaseQuantity();
                              },
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 20.0),
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 1.0,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                _increaseQuantity();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "This dish will be dilevered in ${widget.itemTime} minuts",
                    style: const TextStyle(
                        color: Color(0xFF474E68),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.itemDescription,
                    style: const TextStyle(
                        color: Color(0xFF474E68),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(color: Colors.black, thickness: 1),
                  const Text(
                    "Recommended dishes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: 250,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Restaurants')
                    .doc(widget.restaurantsUid)
                    .collection('FoodItems')
                    .where('specialDish', isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 140,
                          height: 250,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(),
                          ),
                        );
                      },
                    ));
                  }
                  if (snapshot.hasError) {
                    Utils().showSnacBar(context, "Something went wrong");
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        // Image.asset("assets/images/doctor.png"),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Center(
                          child: Text(
                            "No Data Found",
                            style: stationTextStyle,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodDescriptionScreen(
                                        itemName: snapshot.data!.docs[index]['itemName'].toString(),
                                        itemRate: snapshot.data!.docs[index]['itemPrice'].toString(),
                                        itemDescription: snapshot.data!.docs[index]['itemDescription'].toString(),
                                        imgUrl: snapshot.data!.docs[index]['url'].toString(),
                                        itemTime: snapshot.data!.docs[index]['time'].toString(),
                                        restaurantsUid: snapshot.data!.docs[index]['restaurantsId'].toString(),
                                        available: snapshot.data!.docs[index]['available'],
                                        restaurantClosed: widget.restaurantClosed,
                                      )));
                        },
                        child: AllImgCard(
                          imageUrl: snapshot.data!.docs[index]['url'].toString(),
                          itemName: snapshot.data!.docs[index]['itemName'].toString(),
                          itemPrice: snapshot.data!.docs[index]['itemPrice'].toString(),
                          time: snapshot.data!.docs[index]['time'].toString(),
                          available: snapshot.data!.docs[index]['available'],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(width: size.width, height: 100, child: Container()),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            color: const Color(0xFFE9E8E8),
            border: Border.all(color: Colors.black12),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              (totalPrice == null)
                  ? "Total Rs ${widget.itemRate} "
                  : "Total Rs $totalPrice ",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: size.width * 0.4,
              height: 50,
              child: MyElevatedButton(
                  btnName: const Text("Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  press: () {
                    (!widget.available)
                        ? Utils().showSnacBar(context, "Currently this item is not available")
                        : (widget.restaurantClosed)
                            ? Utils().showSnacBar(context, "Restaurant tempararly closed")
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodOrderScreen(
                                    imgUrl: widget.imgUrl,
                                    itemName: widget.itemName,
                                      itemTime : widget.itemTime,
                                    totalPrice: (totalPrice == null)
                                        ? widget.itemRate
                                        : totalPrice.toString(),
                                    quantity: quantity.toString(),
                                    itemPrice: widget.itemRate,
                                    restaurantsUid: widget.restaurantsUid,
                                  ),
                                ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
