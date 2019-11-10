import 'dart:io';

import 'package:floating_action_row/floating_action_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tcc_fabiano/widgets/card_expanded_info.dart';

import '../models/medicamento.dart';

class MostraMedicamento extends StatefulWidget {
  final File imagem;
  final Medicamento medicamento;

  MostraMedicamento({this.imagem, @required this.medicamento});

  @override
  _MostraMedicamentoState createState() => _MostraMedicamentoState();
}

class _MostraMedicamentoState extends State<MostraMedicamento> {
  double fonte_media = 25;
  double fonte_grande = 35;
  double fonte_pequena = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionRow(
          color: Colors.teal,
          children: <Widget>[
            FloatingActionRowButton(
                icon: Icon(Icons.add),
                onTap: () {
                  setState(() {
                    fonte_grande = fonte_grande + 3;
                  });
                }),
            FloatingActionRowDivider(),
            FloatingActionRowButton(
                icon: Icon(Icons.minimize),
                onTap: () {
                  setState(() {
                    fonte_grande = fonte_grande - 3;
                  });
                }),
          ],
        ),
        appBar: AppBar(
          title: Text(
            "Meu Medicamento",
            style: TextStyle(color: Colors.white),
          ),
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
                  child: widget.imagem != null? CircleAvatar(
                    radius: 30.0,
                    backgroundImage: FileImage(widget.imagem),
                    backgroundColor: Colors.transparent,
                  ): CircleAvatar(
                    radius: 30.0,
                    child: Icon(Icons.info_outline, size: 150,),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                  child: Text(
                widget.medicamento.nome,
                style: TextStyle(fontSize: fonte_grande),
              )),
              CardExpandedInfo.CardExpanded(
                  nomeCampo: "Tipo de medicamento:",
                  dadoCampo: widget.medicamento.tipoMedicamento,
                  abertoInicial: true),
              SizedBox(
                height: 5,
              ),
              CardExpandedInfo.CardExpanded(
                  nomeCampo: "Princípios ativos:", dadoCampo: widget.medicamento.principiosAtivos, abertoInicial: true),
              SizedBox(
                height: 5,
              ),
              CardExpandedInfo.CardExpanded(
                  nomeCampo: "Contra-Indicações:", dadoCampo: widget.medicamento.contraIndicacoes, abertoInicial: true),
              SizedBox(
                height: 5,
              ),
              Text(
                "Última atualização: \n${widget.medicamento.data}",
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ));
  }
}
