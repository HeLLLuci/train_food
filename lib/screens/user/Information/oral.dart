import 'package:flutter/material.dart';
import 'package:train_food/widgets/Cards.dart';

class Oral extends StatelessWidget {
  const Oral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Oral Health",
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
                content: "Babies mouths are incredibly sensitive. As they grow, babies use their mouths to explore thier "
                    "environment. \n\n Particularly when baby is not feeding orally"
                    ", procedures around your baby's mouth can be "
                    "stressful. It can also lead to your baby"
                    " becoming sensitive around their mouth which "
                    "may have a negative impact on feeding.You can "
                    "help your baby cope with touch to the mouth"
                    " through positive experiences of taste and "
                    "touch. Your fresh expressed breast milk is the "
                    "best thing to use. It's sweet and contains lots "
                    "of properties to protect your baby.",
                assetName: "assets/images/Oral/step1.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Before you start wash your hands.\n"
                    "\n"
                    "You will need:\n"
                    "1.Fresh breastmilk\n"
                    "2.Cotton swabs 4-5",
                assetName: "assets/images/Oral/step2.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Moisten the swab stick with fresh breastmilk.",
                assetName: "assets/images/Oral/step3.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Place the swab stick against babies lips with firm but gentle pressure and "
                    "wait for baby to respond.",
                assetName: "assets/images/Oral/step4.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Baby will respond by moving their lips.\n\nThis means its Ok to continue and move the tip of the swab into babies mouth.",
                assetName: "assets/images/Oral/step5.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Gently coat their mouth with the breast-milk.\n\n"
                    "Fresh breast-milk has live cells that will help clean and protect baby's mouth and it is sweet to taste.",
                assetName: "assets/images/Oral/step6.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Your baby may even suck on the swab stick. Ensure you are gentle when slowly removing it from mouth.",
                assetName: "assets/images/Oral/step7.jpg"
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
