import 'package:flutter/material.dart';

import '../../../widgets/Cards.dart';

class Bath extends StatelessWidget {
  const Bath({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Wrapped Bathing in the NICU and SCN",
          style: TextStyle(
              fontSize: 18,
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
                content: "Bathing can be stressful for your baby\n"
                    "Wrapping your baby with a light wrap during "
                    "the bath is the most effective strategy for "
                    "decreasing stress\nEnsure you have someone "
                    "available to help with your baby'swrapped "
                    "bath.\nHandle your baby slowly and gently "
                    "Make sure the bath water is warm and that "
                    "you have everything prepared before you begin"
                    ".\nWash and dry your baby's head first with "
                    "plain water (out of the bath) and then place "
                    "your wrapped baby into the bath. During the "
                    "bath, watch for your baby's stress cues. "
                    "Like with all cares, it is important to take "
                    "your time and go\nslowly when bathing your "
                    "baby in the nursery",
                assetName: "assets/images/Bath/step1.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "So your baby is ready to have a bath...\n"
                    "Is your baby warm enough?\nIt should be "
                    "36.6-37.2 degrees before the bath Gather "
                    "equipment before you start\nFull bath Liquid"
                    " Soap and wash clothes\nWarm towels x2\n"
                    "Muslin wrap/sheet Clean linen, nappy and "
                    "clothes\n\n"
                    "Is your baby ready?\n"
                    "Settled, not hungry\n\n"
                    "Always have one person"
                    " holding baby And a second "
                    "person to wash baby",
                assetName: "assets/images/Bath/step2.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "The aim of a wrapped bath is to decrease stress for the baby\n\n"
                    "Signs of stress are:\n\nCrying/unsettled\n"
                    "Facial grimacing\nFinger/ toe splaying or "
                    "clenching Limb extension/jerky movements\n"
                    "Arching\nSneezing/yawning/startles/tremors\n"
                    "If needed a dummy will help keep baby calm and "
                    "stress free during the bath\n\n"
                    "Wrap baby in muslin wrap and warm towel.\n\n"
                    "Holding baby in 'football hold', wash eyes, then face with clean water.",
                assetName: "assets/images/Bath/step3.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Return baby to prepared surface (bed) and dry face and head.",
                assetName: "assets/images/Bath/step4.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Leaving wrapped in muslin wrap.\n"
                    "Remove towel and nappy.",
                assetName: "assets/images/Bath/step5.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Maintain flexed/curled position, transfer baby to bath.",
                assetName: "assets/images/Bath/step6.jpg"
            ),
            SizedBox(
              height: 15,
            ),
            Info_Card(
                content: "Slowly lower baby into bath feet first, to prepare baby.",
                assetName: "assets/images/Bath/step7.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Use sides of bath for 'bracing' to provide containment.",
                assetName: "assets/images/Bath/step8.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Ensure baby's bottom is against base of bath.",
                assetName: "assets/images/Bath/step9.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Unwrapping one limb at a time, gently wash. "
                    "Watch for signs of stress.",
                assetName: "assets/images/Bath/step10.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Rewrap each limb before moving to the next.",
                assetName: "assets/images/Bath/step11.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Move to other side of bath to allow better access.",
                assetName: "assets/images/Bath/step12.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Wash back through the wrap, to maintain wrapping",
                assetName: "assets/images/Bath/step13.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Remove wrap. "
                    "Use dummy is unsettled.",
                assetName: "assets/images/Bath/step14.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "After Bath\n\n"
                    "Lifting out of the bath.\n"
                    "Roll baby on the side and curl into flexed position.",
                assetName: "assets/images/Bath/step15.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Alternative Position:\n"
                    "Maintain flexed/curled positioning.",
                assetName: "assets/images/Bath/step16.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Return baby to prepared surface (bed), Maintaining side flexed position.",
                assetName: "assets/images/Bath/step17.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Wrap baby in warm towel.\n"
                    "Use dummy for comfort if needed.",
                assetName: "assets/images/Bath/step18.jpg"
            ),
            SizedBox(
              height: 15,
            ),Info_Card(
                content: "Dry one area at a time, maintaining wrapping to keep baby warm and settled.",
                assetName: "assets/images/Bath/step19.jpg"
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
