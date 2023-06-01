import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/decoration.dart';
import '../../widgets/my_card.dart';

class AllImgCard extends StatefulWidget {
  final String imageUrl;
  final String itemName;
  final String itemPrice;
  final String time;
  final bool available;
  const AllImgCard({Key? key, required this.imageUrl, required this.itemName, required this.itemPrice, required this.time, required this.available}) : super(key: key);

  @override
  State<AllImgCard> createState() => _AllImgCardState();
}

class _AllImgCardState extends State<AllImgCard> {

  late ImageProvider imageProvider;
  bool isImageLoaded = false;

  @override
  void initState()  {
    super.initState();
    loadImage();
  }

  void loadImage() {
    imageProvider = NetworkImage(widget.imageUrl);
    ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
    stream.addListener(ImageStreamListener((_, __) {
      if(mounted){
      setState(() {
        isImageLoaded = true;
      });
      }
    }, onError: (_, __) {
      if(mounted){
      setState(() {
        isImageLoaded = false;
      });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MyCard(
        padding: myCardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (!widget.available) ? Text(
               "Currently Unavailable",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: itemAvailableTextStyle,
            ) : Container(),
            !isImageLoaded ? Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white38,
              child: CircleAvatar(
                radius: 60.0,
                backgroundColor: allBgClr,
              ),
            ) : CircleAvatar(
                radius: 60,
                backgroundColor: allBgClr,
                backgroundImage:  imageProvider
            ),
            Text(
              widget.itemName,
              style: foodNameTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "Rs ${widget.itemPrice}",
              style: foodPriceTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "Deliver in ${widget.time} min",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: foodTimeTextStyle,
            ),
          ],
        ));
  }
}
