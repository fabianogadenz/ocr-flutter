import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:tcc_fabiano/tratar_imagem.dart';
import 'package:translator/translator.dart';

import 'db/database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TratarImagem(),
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
  List<String> blocos = [];
  var imagem_tratada;


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
            isImageLoaded
                ? RaisedButton(
              child: Text("ler texto"),
              onPressed: readText,
            )
                : Container(),
            isImageLoaded ? Text("Texto encontrado:") : Container(),
            RaisedButton(
              child: Text("banco"),
              onPressed: () async {
//                await DBProvider.db.insert();
                await DBProvider.db.buscaAvancada("Voltaren");
              },
            ),
            isImageLoaded ?
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration:
                BoxDecoration(image: DecorationImage(image: FileImage(imagem_tratada), fit: BoxFit.cover)),
              ),
            )
                : Container(),
            RaisedButton(
              child: Text("tratar imagem"),
              onPressed: () async {},
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: blocos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: blocos[index].toString() == "VALERIMED" || blocos[index].toString().contains("Euthyrox")
                          ? Text(
                        blocos[index].toString(),
                        style: TextStyle(backgroundColor: Colors.yellow[300]),
                      )
                          : Text(blocos[index].toString()),
                    );
                  }),
            )
          ],
        ));
  }
}
