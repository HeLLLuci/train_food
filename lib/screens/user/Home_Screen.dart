import 'package:flutter/material.dart';
import 'package:train_food/screens/user/Information/info_homepage.dart';
import 'package:train_food/screens/user/user_home_screen.dart';

import 'Detection/Detections_Section.dart';

class HomeScreen_ extends StatefulWidget {
  const HomeScreen_({super.key});

  @override
  State<HomeScreen_> createState() => _HomeScreen_State();
}

class _HomeScreen_State extends State<HomeScreen_> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Background.png"),opacity: 0.5,fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Detections()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width-30,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xFFD1F0E8),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListTile(
                            title: Text("Detection Area",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Itim",
                              ),
                            ),
                            subtitle: Text("Detection of sign language and audio",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Itim"
                              ),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Info_Home()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width-30,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xFFe6e3ff),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListTile(
                            title: Text("Information Area",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Itim",
                              ),
                            ),
                            subtitle: Text(
                              "Gather the information about your baby",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Itim"
                              ),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHomeScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width-30,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xFFD1F0E8),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListTile(
                            title: Text("Shopping Area",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Itim",
                              ),
                            ),
                            subtitle: Text("Wanna buy something?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Itim"
                              ),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
