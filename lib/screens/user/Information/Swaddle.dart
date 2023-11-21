import 'package:flutter/material.dart';
import 'package:train_food/widgets/Cards.dart';

class Swaddle extends StatelessWidget {
  const Swaddle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Swaddling your Baby",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF204665)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Info_Card(
                content: "How  to wrap your baby?\n\n"
                    "Wrapping provides a secure and comfort environment for your baby to rest.\n"
                    "You will find that your baby will settle much more readily when wrapped, "
                    "as this is the position which is the most familier to when baby wants inside the womb.",
                assetName: "assets/images/Swaddle/step1.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Open Blanket/sheet out flat.",
                assetName: "assets/images/Swaddle/step2.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Fold down the top of the wrap and place baby on the wrap.\n"
                    "Hold the baby's hands up towards their face and bring wrap across baby.",
                assetName: "assets/images/Swaddle/step3.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Truck wrap under baby.",
                assetName: "assets/images/Swaddle/step4.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Bring wrap across baby and tuck other side.",
                assetName: "assets/images/Swaddle/step5.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Baby's arm are wrapped but the hands are still clode to their face.\n"
                    "Hands near the face provides comfort to baby.",
                assetName: "assets/images/Swaddle/step6.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Tuck baby's legs up, spread out bottom of the sheet, pull up the and tuck around the body.",
                assetName: "assets/images/Swaddle/step7.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Wrapping this way keeps baby calm and comfortable.\n\n"
                    "We advise that you keep wrapping your baby for some time after they are discharge from hospital. "
                    "Ideally, you should keep wrapping your baby until they can roll themselves, "
                    "which is around 4-6 months corrected age.\n"
                    "Some parents may be concerned that wrapping their baby may make them too hot during the summers. "
                    "Muslin, cheesecloth, or thin cot sheets are more practical for the summer months.",
                assetName: "assets/images/Swaddle/step8.jpg"
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
