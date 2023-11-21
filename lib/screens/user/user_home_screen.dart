import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:train_food/auth/splash_services.dart';
import 'package:train_food/screens/user/restaurant_items_screen.dart';
import 'package:train_food/screens/user/user_order_history_screen.dart';
import 'package:train_food/utils/decoration.dart';
import 'package:train_food/widgets/my_card.dart';
import 'package:train_food/widgets/search_bar.dart';
import '../../utils/toast_msg.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  final firestore = FirebaseFirestore.instance.collection('Restaurants').snapshots();

  SplashServices splashServices = SplashServices();
  TextEditingController searchController = TextEditingController();
  final List<String> imageUrls = [
    'assets/images/burger.png',
    'assets/images/Noodles.png',
    'assets/images/all.png',
    'assets/images/Spicy 1.png',
    'assets/images/pizza.png',
  ];

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Infa-Care"),
        drawer: SafeArea(
          child: Drawer(
            backgroundColor: allBgClr,
            width: 270,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(20)
                )
            ),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                      color: orangeBtnClr
                  ),
                  margin: EdgeInsets.zero,
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/Infa-Care logo.png"),
                    backgroundColor: Colors.white,
                  ),
                  accountName: const Text("Happy Shopping",style: TextStyle(fontSize: 18,color: Colors.black)),
                  accountEmail: const Text(""),
                ),
                const SizedBox(height: 20,),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserOrderHistoryScreen(),));
                  },
                  title: const Text("My Orders",style: TextStyle(fontSize: 16)),
                  leading: const Icon(Icons.brunch_dining_sharp),
                  iconColor: Colors.black,
                ),
                ListTile(
                  onTap: () {
                    splashServices.logOut(context);
                  },
                  title: const Text("Logout",style: TextStyle(fontSize: 16)),
                  leading: const Icon(Icons.logout),
                  iconColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: allBgClr,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySearchBar(searchController: searchController, hintText: "Search shops",onChanged: (p0) {setState(() {});},),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                },
                scrollDirection: Axis.horizontal,
              ),
              items: imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 200,
                      height: 100,
                      margin: const EdgeInsets.all(10),
                      color: Colors.transparent,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Explore Essentials",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.black),),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 200.0,left: 10),
              child: Divider(
                color: Colors.black,
                thickness: 3,
              ),
            ),
            const SizedBox(height: 5,),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: orangeBtnClr));
                  }
                  if (snapshot.hasError) {
                    Utils().showSnacBar(context, "Something went wrong");
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return
                        Center(
                          child: Text(
                            "No Shop Found",
                            style: stationTextStyle,
                          ),
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final stationName = snapshot.data!.docs[index]['Station_Name'].toString();
                        final restaurantName = snapshot.data!.docs[index]['Restaurant_Name'].toString();
                        if(searchController.text.toString().isEmpty){
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ShopInfoScreen(
                                        restaurantsUid: snapshot.data!.docs[index]['Restaurant_uid'].toString(),
                                        restaurantClosed : snapshot.data!.docs[index]['Closed'],
                                          restaurantName: snapshot.data!.docs[index]['Restaurant_Name'].toString(),
                                      ),
                                  )
                              );
                            },
                            child: MyCard(
                                padding: myCardPadding,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data!.docs[index]['Restaurant_Name'].toString(),
                                    style: stationTextStyle,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.docs[index]['Restaurant_Address'].toString(),),
                                      (snapshot.data!.docs[index]['Closed'] == true)
                                          ? Text("Restaurant temporary closed",style: restaurantAvailableTextStyle,)
                                          : Container(),
                                    ],
                                  ),
                                  trailing: const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage("assets/images/Infa-Care logo.png") //change trainling image after getting new image
                                  ),
                                )
                            ),
                          );
                        }else if(
                        (stationName.toLowerCase().contains(searchController.text.toLowerCase()))
                        || (restaurantName.toLowerCase().contains(searchController.text.toLowerCase()))
                        ){
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      ShopInfoScreen(
                                        restaurantsUid: snapshot.data!.docs[index]['Restaurant_uid'].toString(),
                                        restaurantClosed : snapshot.data!.docs[index]['Closed'],
                                        restaurantName: snapshot.data!.docs[index]['Restaurant_Name'].toString(),
                                      ),
                                  )
                              );
                            },
                            child: MyCard(
                                padding: myCardPadding,
                                child: ListTile(
                                  title: Text(
                                    snapshot.data!.docs[index]['Restaurant_Name'].toString(),
                                    style: stationTextStyle,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.docs[index]['Restaurant_Address'].toString(),),
                                      (snapshot.data!.docs[index]['Closed'] == true)
                                          ? Text("Restaurant temporary closed",style: restaurantAvailableTextStyle,)
                                          : Container(),
                                    ],
                                  ),
                                  trailing: const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage("assets/images/restaurant.png")
                                  ),
                                )
                            ),
                          );
                        }else{
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            )
          ],
        )
    );
  }
}