import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';

class Detections extends StatefulWidget {
  const Detections({Key? key});

  @override
  State<Detections> createState() => _DetectionsState();
}

class _DetectionsState extends State<Detections> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loadModel().then((value) {
      setState(() {});
    });
    super.initState();
  }

  Future classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  Future loadModel() async {
    await Tflite.loadModel(
      model: "assets/model/model_unquant.tflite",
      labels: "assets/model/labels.txt",
    );
  }

  void pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  void pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hello Iam your helper chatbot \n Ask if you have any doughts"),
          contentPadding: EdgeInsets.all(50), // Increase the padding
          content: Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(hintText: "Enter your queries"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your query';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                }
              },
              child: Text("Send"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Detection",
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFF58A76C),
          ),
        ),
        centerTitle: true,
        leading: Image.asset(
          "assets/images/Infa-Care logo.png"
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 20
            ),
            Text(
              "Detect sign",
              style: TextStyle(
                color: Color(0xFF58A76C),
                fontSize: 28,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Baby sign language detection",
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w500,
                color: Color(0xFF58A76C),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: _loading
                  ? Container(
                width: 300,
                child: Column(
                  children: [
                    Image.asset("assets/images/Infa-Care logo.png"),
                    SizedBox(height: 10),
                  ],
                ),
              )
                  : Container(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: Image.file(_image),
                    ),
                    SizedBox(height: 20),
                    _output != null
                        ? Text(
                      "${_output[0]['label']}",
                      style: TextStyle(
                        color: Color(0xFF58A76C),
                        fontSize: 20,
                      ),
                    )
                        : Container(),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickGalleryImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 160,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: Color(0xFF58A76C),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Select from gallery",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 160,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: Color(0xFF58A76C),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Camera Roll",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        backgroundColor: Color(0xFF58A76C),
        child: Icon(
          Icons.chat_bubble, // Replace with your robot head icon
          size: 30,
        ),
      ),
    );
  }
}
