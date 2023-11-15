import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hungry_calculator/asprise_api/http_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/asprise/models.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";

  //late ReceiptHttp receiptHttp;
  late Future<List<Receipt>> receiptsFuture;
  late List<Receipt> receipts;
  late List<Item> items;

  @override
  void initState() {
    //receiptHttp = ReceiptHttp();
    receipts = [];
    items = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Распознаватель текста по пикче"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loading(),
                showPicture(),
                buttonPanel(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  scannedText,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            )),
      )),
    );
  }

  Widget loading() {
    return textScanning ? const CircularProgressIndicator() : Container();
  }

  Widget showPicture() {
    if (!textScanning && imageFile == null) {
      return Container(
        width: 300,
        height: 300,
        color: Colors.grey[300]!,
      );
    }
    if (imageFile != null) return Image.file(File(imageFile!.path));
    return Container();
  }

  Widget buttonPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [scannerButton(), cameraButton()],
    );
  }

  Widget scannerButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey[400],
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: () {
          getImage(ImageSource.gallery);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.document_scanner,
                size: 30,
              ),
              Text(
                "Gallery",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cameraButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey[400],
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: () {
          getImage(ImageSource.camera);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.camera_alt,
                size: 30,
              ),
              Text(
                "Camera",
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        //TODO getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  //send picture to API
  //get json from API
/*  void getRecognisedText(XFile image){
    FutureBuilder(future: future, builder: builder)
  }*/
}
