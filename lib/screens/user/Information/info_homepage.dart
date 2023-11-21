import 'package:flutter/material.dart';
import 'package:train_food/screens/user/Information/Swaddle.dart';
import 'package:train_food/screens/user/Information/oral.dart';
import 'package:train_food/screens/user/Information/vaccine.dart';
import 'package:train_food/widgets/Cards.dart';

import 'Bath.dart';

class Info_Home extends StatelessWidget {
  const Info_Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Information",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF204665)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Row_Card(
                        title: "Oral",
                        subtitle: 'Resource for Optimal Hygiene and Protection',
                        ontap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Oral()));
                        }, assetName: 'assets/images/oral.jpeg',
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row_Card(
                        title: "Bath",
                        subtitle: "Complete hygiene and protection guide",
                        ontap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Bath()));
                        }, assetName: 'assets/images/bath.jpg',
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row_Card(
                        title: "Swaddle",
                        subtitle: "Comfortable Wrapping for infants",
                        ontap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Swaddle()));
                        }, assetName: 'assets/images/swaddle.jpg',
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Explore",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF204665)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column_Card(
                  assetName: "assets/images/oral.jpeg",
                    title: "Oral",
                    subtitle: "ISOC Oral care",
                    ontap: () {}
                ),
                SizedBox(
                  height: 10,
                ),
                Column_Card(
                  assetName: "assets/images/bath.jpg",
                    title: "Bath",
                    subtitle: "Resource for Optimal Hygiene and Protection",
                    ontap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Bath()));
                    }
                ),
                SizedBox(
                  height: 10,
                ),
                Column_Card(
                  assetName: "assets/images/swaddle.jpg",
                    title: "Swaddle",
                    subtitle: "How to swaddle your baby",
                    ontap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Swaddle()));
                    }
                ),
                SizedBox(
                  height: 10,
                ),
                Column_Card(
                  assetName: "assets/images/vaccine.jpg",
                    title: "Vaccines",
                    subtitle: "Names, Age limit and Reasons",
                    ontap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Vaccine()));
                    }
                ),
                SizedBox(
                  height: 10,
                ),
                Column_Card(
                  assetName: "assets/images/medical.jpg",
                    title: "Treatments",
                    subtitle: "Various Medical treatments",
                    ontap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Swaddle()));
                    }
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
