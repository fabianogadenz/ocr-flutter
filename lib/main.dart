import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:tcc_fabiano/data/pos_processamento.dart';
import 'package:tcc_fabiano/models/medicamento.dart';
import 'package:tcc_fabiano/screens/mostra_medicamento.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
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
  String myText = "";
  String medicamento = "";

  bool isImageLoaded = false;

  Future pickImage() async {
    File tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    Medicamento medicamento = await identificaMedicamento(tempStore);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MostraMedicamento(imagem: tempStore, medicamento: medicamento)),
    );
  }

  Future<Medicamento> identificaMedicamento(File tempStore2) async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(tempStore2);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    List<String> dados_sujos = [];
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        dados_sujos.add(line.text.toString());
      }
    }
    List<Medicamento> listMedicamento = [];
    listMedicamento = await PosProcessamento.buscaMedicamentos(dados_sujos, context);

    if (listMedicamento.length == 0) return Medicamento();
    if (listMedicamento.length > 0) return listMedicamento[0];
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
    setState(() {
      if (listMedicamento.length == 0) medicamento = "Nenhum medicamento encontrado!";
      if (listMedicamento.length > 0) medicamento = listMedicamento[0].nome;
      myText = readText.text;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("teste"),
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
          Text(
            "$medicamento",
            style: TextStyle(fontSize: 30),
          ),
          Expanded(child: Text("$myText"))
        ],
      ),
    );
  }
}
