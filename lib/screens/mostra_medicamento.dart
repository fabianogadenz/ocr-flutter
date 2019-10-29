import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/medicamento.dart';

class MostraMedicamento extends StatefulWidget {
  final File imagem;
  final Medicamento medicamento;
  MostraMedicamento({@required this.imagem, @required this.medicamento});

  @override
  _MostraMedicamentoState createState() => _MostraMedicamentoState();
}

class _MostraMedicamentoState extends State<MostraMedicamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meu Medicamento",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: FileImage(widget.imagem),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
//              Center(
//                child: Container(
//                  height: 200.0,
//                  width: 200.0,
//                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(widget.imagem), fit: BoxFit.cover)),
//                ),
//              ),
              SizedBox(height: 5,),
              Center(child: Text(widget.medicamento.nome, style: TextStyle(fontSize: 25),)),
              SizedBox(height: 5,),
              Text("Tipo de medicamento: Cápsulas"),
              SizedBox(height: 5,),
              Text(
                  "Princípios ativos: ${widget.medicamento.principiosAtivos}"),
              SizedBox(height: 5,),
              Text(
                  "Contra-Indicações: ${widget.medicamento.contraIndicacoes}"),
              SizedBox(height: 5,),
              Text("Data da última atualização: ${widget.medicamento.data}"),
            ],
          ),
        ));
  }
}
