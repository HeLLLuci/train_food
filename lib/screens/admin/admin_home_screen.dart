import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:train_food/auth/splash_services.dart';
import 'package:train_food/screens/admin/update_restaurant.dart';
import '../../utils/decoration.dart';
import '../../utils/toast_msg.dart';
import 'add_item_screen.dart';
import 'all_items_screen.dart';
import 'all_orders_screen.dart';
import 'order_tab_view.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>  with SingleTickerProviderStateMixin {

  late TabController _tabController;
  SplashServices splashServices = SplashServices();
  String restaurantName = '';
  bool restaurantClosed = false;
  bool isRegistering = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void fetchUserData() async {
      final user = FirebaseAuth.instance.currentUser;
        final uid = user!.uid;
        final snapshot = await FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(uid)
            .get();
          final userData = snapshot.data();
          setState(() {
            restaurantName = userData!['Restaurant_Name'].toString();
            restaurantClosed = userData['Closed'];
          });
}

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('Restaurants');

  Future<void> closeOpenRestaurant(bool restaurantClosed) async {
    try {
        setState(() {
          isRegistering = false;
        });
        await firestore.doc(auth.currentUser!.uid).update({
          'Closed': restaurantClosed,
        }).then((value) {
          showSnac();
        }).onError((error, stackTrace) {
          Utils().showSnacBar(context, "Something went wrong");
        });
        setState(() {
          isRegistering = false;
        });
    } catch (e) {
      Utils().showSnacBar(context, "Something went wrong");
      setState(() {
        isRegistering = false;
      });
    }
  }

  showSnac() {
    Navigator.pop(context);
    (restaurantClosed) ? Utils().showSnacBar(context, "Your shop is closed, you never get order by any consumers, "
        "however you will get order when it will open.")
    : Utils().showSnacBar(context, "Your shop is opened, you can start supplying orders.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurantName,
          style: stationTextStyle,
        ),
        centerTitle: true,
        backgroundColor: allBgClr,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
          tabs: const [
            Tab(
              text: 'Orders',
            ),
            Tab(
              text: 'All Items',
            ),
            Tab(
              text: 'Add Item',
            ),
          ],
        ),
      ),
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
                accountName: Text(restaurantName,style: const TextStyle(fontSize: 18,color: Colors.black)),
                accountEmail: const Text(""),
              ),
              const SizedBox(height: 20,),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateRestaurant(),));
                },
                title: const Text("Update Shop",style: TextStyle(fontSize: 16)),
                leading: const Icon(Icons.edit_note,size: 30),
                iconColor: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AllOrdersScreen(),));
                },
                title: const Text("All Orders",style: TextStyle(fontSize: 16)),
                leading: const Icon(Icons.update),
                iconColor: Colors.black,
              ),
              ListTile(
                onTap: () {
                  restaurantClosed = !restaurantClosed;
                  closeOpenRestaurant(restaurantClosed);
                },
                title: (!isRegistering) ? ((!restaurantClosed)
                    ?  const Text("Close Shop",style: TextStyle(fontSize: 16))
                :  const Text("Open Shop",style: TextStyle(fontSize: 16)))
                : const LinearProgressIndicator(),
                leading: const Icon(Icons.shopping_bag,),
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
      body: TabBarView(
        controller: _tabController,
        children: const [
          OrderTabView(),
          AllItemsScreen(),
          AddItemScreen(),
        ],
      ),
    );
  }
}