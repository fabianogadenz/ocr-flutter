import 'package:flutter/material.dart';

class NaoEncontradoScreen extends StatefulWidget {
  @override
  _NaoEncontradoScreenState createState() => _NaoEncontradoScreenState();
}

class _NaoEncontradoScreenState extends State<NaoEncontradoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ocorreu um erro"),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                    child: Text(
                  "Não encontramos nenhum registro de medicamento!",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                child: OutlineButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Tentar Novamente",
                              style: TextStyle(fontSize: 22, color: Colors.teal[800]),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                    highlightedBorderColor: Colors.cyan,
                    color: Colors.teal,
                    borderSide: new BorderSide(color: Colors.teal),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0))),
              ),
            ],
          )),
    );
  }
}
