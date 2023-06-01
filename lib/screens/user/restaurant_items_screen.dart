import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:train_food/screens/admin/all_img_card.dart';
import 'package:train_food/utils/toast_msg.dart';
import 'package:train_food/widgets/search_bar.dart';

import '../../utils/decoration.dart';
import 'food_description_screen.dart';

class RestaurantInfoScreen extends StatefulWidget {
  final String restaurantsUid;
  final String restaurantName;
  final bool restaurantClosed;
  const RestaurantInfoScreen(
      {Key? key, required this.restaurantsUid, required this.restaurantClosed, required this.restaurantName})
      : super(key: key);

  @override
  State<RestaurantInfoScreen> createState() => _RestaurantInfoScreenState();
}

class _RestaurantInfoScreenState extends State<RestaurantInfoScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.restaurantName),
      backgroundColor: allBgClr,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MySearchBar(
            searchController: searchController,
            hintText: "Search food",
            onChanged: (p0) {
              setState(() {
                searchQuery = searchController.text.toLowerCase().toString();
              });
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Our menu",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 260.0, left: 10),
            child: Divider(
              color: Colors.black,
              thickness: 3,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Restaurants')
                      .doc(widget.restaurantsUid)
                      .collection('FoodItems')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(color: orangeBtnClr));
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
                    }
                    else {
                      var filteredDocuments = snapshot.data!.docs.where((doc) {
                        final itemName = doc['itemName'].toString().toLowerCase().contains(searchQuery);
                        return itemName;
                      }).toList();
                      return GridView.builder(
                        itemCount: filteredDocuments.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 2 / 2.7),
                        itemBuilder: (context, index) {
                          var data = filteredDocuments[index].data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FoodDescriptionScreen(
                                        itemName: data['itemName'].toString(),
                                        itemRate: data['itemPrice'].toString(),
                                        itemDescription: data['itemDescription'].toString(),
                                        imgUrl: data['url'].toString(),
                                        itemTime: data['time'].toString(),
                                        restaurantsUid: data['restaurantsId'].toString(),
                                        available: data['available'],
                                        restaurantClosed: widget.restaurantClosed,
                                      ),
                                    ));
                              },
                              child: AllImgCard(
                                imageUrl: data['url'].toString(),
                                itemName: data['itemName'].toString(),
                                itemPrice: data['itemPrice'].toString(),
                                time: data['time'].toString(),
                                available: data['available'],
                              ),
                            );
                        },
                      );
                    }
                  })),
        ],
      ),
    );
  }
}
