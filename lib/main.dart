import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:tcc_fabiano/data/pos_processamento.dart';
import 'package:tcc_fabiano/models/medicamento.dart';
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File pickedImage;
  String myText = "";
  String medicamento = "";

  bool isImageLoaded = false;

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    List<String> dados_sujos = [];
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        dados_sujos.add(line.text.toString());
//        for (TextElement word in line.elements) {
//          print(line.text);
//        }
      }
    }
    List<Medicamento> listMedicamento = [];
    listMedicamento = await PosProcessamento.buscaMedicamentos(dados_sujos, context);
    PosProcessamento.buscaMedicamentos(dados_sujos, context).then((list){
      setState(() {
      if(list.length > 0)
        medicamento = list[0].nome;
        myText = readText.text;
      });
    });

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
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          isImageLoaded
              ? Center(
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(image: DecorationImage(image: FileImage(pickedImage), fit: BoxFit.cover)),
                  ),
                )
              : Container(),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            child: Text('Escolher imagem'),
            onPressed: pickImage,
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            child: Text('Ler texto'),
            onPressed: readText,
          ),
          Text("$medicamento", style: TextStyle(fontSize: 30),),
          Expanded(child: Text("$myText"))
        ],
      ),

    );
  }
}
