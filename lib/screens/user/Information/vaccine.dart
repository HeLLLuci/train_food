import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../widgets/Cards.dart';

class Vaccine extends StatelessWidget {
  final pdfUrl = Uri.parse("https://drive.google.com/file/d/1WwgYP7Rih_R2YlySU-JkxbCl1rVMq__B/view?usp=sharing");

  @override
  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Vaccinations/Immunization",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF204665)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "At Birth",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF204665)),
              ),
              SizedBox(
                height: 10,
              ),
              Alt_Info_Card(
                  content: "BCG Vaccine: Bacille Calmette Guerin (Tuberculosis)"
                      "\n\n"
                      "Dose 1: At Birth",
                  imageUrl: "https://ihatepsm.com/sites/default/files/BCG%20as%20on%20blog.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "OPV: Oral Polio Vaccine"
                      "\n\n"
                      "Dose 0: At Birth",
                  imageUrl: "https://imgk.timesnownews.com/story/iStock-1158911609.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "Hep B: hepatitis B Vaccine"
                      "\n\n"
                      "Dose 1: At Birth",
                  imageUrl: "https://cdn.aarp.net/content/dam/aarp/health/conditions_treatments/2020/10/1140-hepatitis-b.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "6-8 Weeks",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF204665)),
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "	DTaP/DTwP: Diphtheria, Tetanus and Pertussis"
                      "\n\n"
                      "Dose 1: 6-8 Weeks",
                  imageUrl: "https://www.bumrungrad.com/getattachment/38aa1a1a-8f36-4cde-a9cd-c92138bc02d5/image.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "Hib: Haemophilus influenzae type B vaccine"
                      "\n\n"
                      "Dose 1: 6-8 Weeks",
                  imageUrl: "https://upload.wikimedia.org/wikipedia/commons/3/35/Hib_for_infanrix_hexa.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "Rotavirus Vaccine"
                      "\n\n"
                      "Dose 1: 6-8 Weeks",
                  imageUrl: "https://sciencenews.org/wp-content/uploads/2019/06/061719_ac_rotavirus_feat_free.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "IPV: Injectable Polio Vaccine"
                      "\n\n"
                      "Dose 1: 6-8 Weeks",
                  imageUrl: "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2021/10/shutterstock_1761404999.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "Hep B: Hepatitis B Vaccine"
                      "\n\n"
                      "Dose 2: 6-8 Weeks",
                  imageUrl: "https://cdn.aarp.net/content/dam/aarp/health/conditions_treatments/2020/10/1140-hepatitis-b.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "10-16 Weeks",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF204665)),
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "DTaP/DTwP: Diphtheria, Tetanus and Pertussis"
                      "\n\n"
                      "Dose 2: 10-16 Weeks",
                  imageUrl: "https://www.bumrungrad.com/getattachment/38aa1a1a-8f36-4cde-a9cd-c92138bc02d5/image.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "Hib: Haemophilus influenzae type B vaccine"
                      "\n\n"
                      "Dose 2: 10-16 Weeks",
                  imageUrl: "https://upload.wikimedia.org/wikipedia/commons/3/35/Hib_for_infanrix_hexa.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "Rotavirus vaccine"
                      "\n\n"
                      "Dose 2: 10-16 Weeks",
                  imageUrl: "https://sciencenews.org/wp-content/uploads/2019/06/061719_ac_rotavirus_feat_free.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "IPV: Injectable Polio Vaccine"
                      "\n\n"
                      "Dose 2: 10-16 Weeks",
                  imageUrl: "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2021/10/shutterstock_1761404999.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Alt_Info_Card(
                  content: "Hep B: Hepatitis B Vaccine"
                      "\n\n"
                      "Dose 2: 10-16 Weeks",
                  imageUrl: "https://cdn.aarp.net/content/dam/aarp/health/conditions_treatments/2020/10/1140-hepatitis-b.jpg"
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "You can see more vaccine details by clicking on button below",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF204665)),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(
                    pdfUrl,
                  mode: LaunchMode.externalApplication,
                  );
                },
                child: Container(
                  height: 50,
                  width: 150,
                  alignment: Alignment.center,
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
                      stops: [0.1, 0.9],
                    ),
                  ),
                  child: Text(
                    "Download Form",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
