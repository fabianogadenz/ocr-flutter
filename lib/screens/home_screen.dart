import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:tcc_fabiano/db/database.dart';

import '../utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Utils utils = Utils();
  File pickedImage;
  File sobelImage;
  bool isImageLoaded = false;
  bool isImageTratada = false;
  String texto;
  List<String> blocos = [];
  File imagem_tratada;

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(myImage);
    for (TextBlock block in readText.blocks) {
      blocos.add(block.text);
      print("texto: " + block.text);
    }
    print("teste");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("OCR de Medicamento"),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("pick"),
              onPressed: pickImage,
            ),
            isImageLoaded
                ? Center(
              child: Container(
                height: 200,
                width: 200,
                decoration:
                BoxDecoration(image: DecorationImage(image: FileImage(pickedImage), fit: BoxFit.cover)),
              ),
            )
                : Container(),
            RaisedButton(
              child: Text("ler texto"),
              onPressed: readText,
            ),
          ],
        ));
  }
}
