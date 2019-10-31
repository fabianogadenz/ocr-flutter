import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc_fabiano/data/pos_processamento.dart';
import 'package:tcc_fabiano/models/medicamento.dart';
import 'package:tcc_fabiano/screens/mostra_medicamento.dart';
import 'package:tcc_fabiano/screens/nao_encontrado.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future pickImage(bool camera) async {
    File tempStore;
    if (camera)
      tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    else
      tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    Medicamento medicamento = await identificaMedicamento(tempStore);
    if (medicamento.nome != null)
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => MostraMedicamento(imagem: tempStore, medicamento: medicamento)),
      );
    else
      Navigator.push(context, MaterialPageRoute(builder: (context) => NaoEncontradoScreen()));
  }

  Future<Medicamento> identificaMedicamento(File tempStore2) async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(tempStore2);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    List<String> dados_sujos = [];
    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        print(line.text);
        dados_sujos.add(line.text.toString());
      }
    }
    List<Medicamento> listMedicamento = [];
    listMedicamento = await PosProcessamento.buscaMedicamentos(dados_sujos, context);

    if (listMedicamento.length == 0) return Medicamento();
    if (listMedicamento.length > 0) return listMedicamento[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bula Fácil",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              child: OutlineButton(
                  onPressed: () {
                    pickImage(true);
                  },
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.camera_alt, size: 30, color: Colors.teal[800])),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Capturar Foto",
                            style: TextStyle(fontSize: 30, color: Colors.teal[800]),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  highlightedBorderColor: Colors.cyan,
                  color: Colors.teal,
                  borderSide: new BorderSide(color: Colors.teal),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              child: OutlineButton(
                  onPressed: () {
                    pickImage(false);
                  },
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft, child: Icon(Icons.image, size: 30, color: Colors.teal[800])),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Carregar Foto",
                            style: TextStyle(fontSize: 30, color: Colors.teal[800]),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  highlightedBorderColor: Colors.cyan,
                  color: Colors.teal,
                  borderSide: new BorderSide(color: Colors.teal),
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0))),
            ),
          )
        ],
      ),
    );
  }
}
