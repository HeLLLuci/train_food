import 'package:flutter/material.dart';
import 'package:train_food/screens/user/review_screen.dart';
import 'package:train_food/utils/toast_msg.dart';
import '../../utils/decoration.dart';
import '../../widgets/button.dart';
import '../../widgets/data_input_card.dart';

class FoodOrderScreen extends StatefulWidget {
  final String imgUrl;
  final String itemName;
  final String totalPrice;
  final String itemPrice;
  final String quantity;
  final String restaurantsUid;
  final String itemTime;
  const FoodOrderScreen({Key? key, required this.imgUrl, required this.itemName, required this.totalPrice, required this.quantity, required this.itemPrice, required this.restaurantsUid, required this.itemTime}) : super(key: key);

  @override
  State<FoodOrderScreen> createState() => _FoodOrderScreenState();
}

class _FoodOrderScreenState extends State<FoodOrderScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final trainController = TextEditingController();
  final compartmentController = TextEditingController();
  final seatController = TextEditingController();
  final phoneController = TextEditingController();
   final double textAndTextFieldHeight = 45;

  void proceedOrder(){
    if(_formKey.currentState!.validate()
        && (userNameController.text.isNotEmpty
            && RegExp(r'^[a-z A-Z0-9]+$').hasMatch(userNameController.text))
        && (trainController.text.isNotEmpty
            && RegExp(r'^[a-z A-Z0-9]+$').hasMatch(trainController.text))
        && (compartmentController.text.isNotEmpty
            && RegExp(r'^[a-z A-Z0-9]+$').hasMatch(compartmentController.text))
        && (seatController.text.isNotEmpty
            && RegExp(r'^[0-9]+$').hasMatch(seatController.text))
        && (phoneController.text.isNotEmpty
            && RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(phoneController.text))
    ){
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewScreen(
              imgUrl: widget.imgUrl,
              itemName: widget.itemName,
              totalPrice: widget.totalPrice,
              itemTime : widget.itemTime,
              quantity: widget.quantity,
              itemPrice: widget.itemPrice,
              restaurantsUid: widget.restaurantsUid,
              userName: userNameController.text.toString(),
              compartment: compartmentController.text.toString(),
              seatNo: seatController.text.toString(),
              trainName: trainController.text.toString(),
              userPhone: phoneController.text.toString(),
            ),
          ));
    }else{
      Utils().showSnacBar(context, "Enter all correct details");
    }

  }

   @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    trainController.dispose();
    compartmentController.dispose();
    phoneController.dispose();
    seatController.dispose();
   }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("Location Information"),
      backgroundColor: allBgClr,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.1,),
                DataInputCard(
                  height: textAndTextFieldHeight,
                  name: "Name:",
                  controller: userNameController,
                ),
                SizedBox(height: size.height*0.02,),
                DataInputCard(
                  height: textAndTextFieldHeight,
                  name: "Your Train:",
                  controller: trainController,
                ),
                SizedBox(height: size.height*0.02,),
                DataInputCard(
                  height: textAndTextFieldHeight,
                  name: "Your Compartment:",
                  controller: compartmentController,
                ),
                SizedBox(height: size.height*0.02,),
                DataInputCard(
                  name: "Your seat no:",
                  height: textAndTextFieldHeight,
                  keyBoardType: TextInputType.number,
                  controller: seatController,
                ),
                SizedBox(height: size.height*0.02,),
                DataInputCard(
                  name: "Phone Number:",
                  height: 60,
                  controller: phoneController,
                  helperText: "Enter 10 digit number",
                  keyBoardType: TextInputType.number,
                ),
                SizedBox(height: size.height*0.1,),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: MyElevatedButton(
                      btnName: const Text("Proceed",style:TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600)),
                      press: (){
                        proceedOrder();
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
