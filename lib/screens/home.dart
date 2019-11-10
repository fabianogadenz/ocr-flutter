import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tcc_fabiano/data/pos_processamento.dart';
import 'package:tcc_fabiano/models/medicamento.dart';
import 'package:tcc_fabiano/screens/busca_medicamento.dart';
import 'package:tcc_fabiano/screens/mostra_medicamento.dart';
import 'package:tcc_fabiano/screens/nao_encontrado.dart';
import 'package:tcc_fabiano/widgets/loading_widget.dart';
import 'package:tcc_fabiano/widgets/menu_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  Future pickImage(bool camera) async {
    setState(() {
      _isLoading = true;
    });
    File tempStore;
    if (camera)
      tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    else
      tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(tempStore == null)
      _isLoading = false;

    Medicamento medicamento = await identificaMedicamento(tempStore);
    _isLoading = false;
    if (medicamento.nome != null)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MostraMedicamento(imagem: tempStore, medicamento: medicamento)),
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
      body: (_isLoading == true)
          ? LoadingWidget.loadingWidget(context)
          : GridView.count(
              // Cria um grid com duas colunas
              crossAxisCount: 2,
              children: [
                  MenuTile.menuTile(
                      titulo: "Capturar Foto",
                      icone: Icons.camera_alt,
                      funcao: () {
                        pickImage(true);
                      }),
                  MenuTile.menuTile(
                      titulo: "Carregar Foto",
                      icone: MdiIcons.image,
                      funcao: () {
                        pickImage(false);
                      }),
                  MenuTile.menuTile(
                      titulo: "Pesquisar",
                      icone: Icons.search,
                      funcao: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BuscaMedicamento()),
                        );
                      }),
                  MenuTile.menuTile(titulo: "Favoritos", icone: Icons.star)
                ]),
//      Column(
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
//            child: Container(
//              height: 50,
//              child: OutlineButton(
//                  onPressed: () {
//                    pickImage(true);
//                  },
//                  child: Stack(
//                    children: <Widget>[
//                      Align(
//                          alignment: Alignment.centerLeft,
//                          child: Icon(Icons.camera_alt, size: 30, color: Colors.teal[800])),
//                      Align(
//                          alignment: Alignment.center,
//                          child: Text(
//                            "Capturar Foto",
//                            style: TextStyle(fontSize: 30, color: Colors.teal[800]),
//                            textAlign: TextAlign.center,
//                          ))
//                    ],
//                  ),
//                  highlightedBorderColor: Colors.cyan,
//                  color: Colors.teal,
//                  borderSide: new BorderSide(color: Colors.teal),
//                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0))),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(20),
//            child: Container(
//              height: 50,
//              child: OutlineButton(
//                  onPressed: () {
//                    pickImage(false);
//                  },
//                  child: Stack(
//                    children: <Widget>[
//                      Align(
//                          alignment: Alignment.centerLeft, child: Icon(Icons.image, size: 30, color: Colors.teal[800])),
//                      Align(
//                          alignment: Alignment.center,
//                          child: Text(
//                            "Carregar Foto",
//                            style: TextStyle(fontSize: 30, color: Colors.teal[800]),
//                            textAlign: TextAlign.center,
//                          ))
//                    ],
//                  ),
//                  highlightedBorderColor: Colors.cyan,
//                  color: Colors.teal,
//                  borderSide: new BorderSide(color: Colors.teal),
//                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0))),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(20),
//            child: Container(
//              height: 50,
//              child: OutlineButton(
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => BuscaMedicamento()),
//                    );
//                  },
//                  child: Stack(
//                    children: <Widget>[
//                      Align(
//                          alignment: Alignment.centerLeft, child: Icon(Icons.search, size: 30, color: Colors.teal[800])),
//                      Align(
//                          alignment: Alignment.center,
//                          child: Text(
//                            "Pesquisar",
//                            style: TextStyle(fontSize: 30, color: Colors.teal[800]),
//                            textAlign: TextAlign.center,
//                          ))
//                    ],
//                  ),
//                  highlightedBorderColor: Colors.cyan,
//                  color: Colors.teal,
//                  borderSide: new BorderSide(color: Colors.teal),
//                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0))),
//            ),
//          )
//        ],
//      ),
    );
  }
}
