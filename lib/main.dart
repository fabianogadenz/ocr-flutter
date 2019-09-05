import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:translator/translator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File pickedImage;

  bool isImageLoaded = false;
  String texto;

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

//    for(TextBlock block in readText.blocks){
//      print("${block.text}");
//      for(TextLine lines in block.lines){
//        for(TextElement word in lines.elements){
//          result = texto = " " + word.text;
//        }
//      }
//    }

    translate(readText.text);
  }

  void translate(String readText) async {
    GoogleTranslator translator = GoogleTranslator();

    String input = readText;

    translator.translate(input, to: 'pt').then((s) => print("Source: " +
        input +
        "\n"
            "Translated: " +
        s +
        "\n"));

    // var translation = await translator.translate(input, from: 'ru', to: 'en');
    // print("translation: " + translation);
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
