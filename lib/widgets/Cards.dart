import 'package:flutter/material.dart';

class Row_Card extends StatelessWidget {
  const Row_Card({super.key, required this.title, required this.subtitle, required this.ontap, required this.assetName});
  final String title;
  final String subtitle;
  final VoidCallback ontap;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        height: 200,
        width: 150,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
               blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(2, 3)
            )
          ],
          gradient: LinearGradient(
              colors: [
                Color(0xFF0BABAA),
                Color(0xFF1EB9BB),
              ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
                child: Image.asset(assetName, width: 70,)),
            SizedBox(
              height: 10,
            ),
            Text(
                title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                subtitle,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Column_Card extends StatelessWidget {
  const Column_Card({super.key, required this.title, required this.subtitle, required this.ontap, required this.assetName});
  final String title;
  final String subtitle;
  final VoidCallback ontap;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset(2, 3)
                )
              ],
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF0BABAA),
                    Color(0xFF1EB9BB),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.9]
              ),
            ),
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width-60,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  shape: BoxShape.circle
                ),
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(assetName),
                ),
              ),
              SizedBox(
                width: 251,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.teal,size: 30,)
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class Info_Card extends StatelessWidget {
  const Info_Card({super.key, required this.content, required this.assetName});
  final String content;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: [
              Color(0xFF0BABAA),
              Color(0xFF1EB9BB),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9]
        ),
      ),
      child: Column(
        children: [
          Image.asset(assetName),
          SizedBox(
            height: 10,
          ),
          Text(
              content,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
          )
        ],
      ),
    );
  }
}

class Alt_Info_Card extends StatelessWidget {
  const Alt_Info_Card({super.key, required this.content, required this.imageUrl});
  final String content;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: [
              Color(0xFF0BABAA),
              Color(0xFF1EB9BB),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9]
        ),
      ),
      child: Column(
        children: [
          Image.network(imageUrl),
          SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
          )
        ],
      ),
    );
  }
}



