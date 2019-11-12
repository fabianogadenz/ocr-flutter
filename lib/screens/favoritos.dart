import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tcc_fabiano/data/data.dart';
import 'package:tcc_fabiano/models/medicamento.dart';

import '../utils.dart';
import 'mostra_medicamento.dart';

class Favoritos extends StatefulWidget {
  @override
  _FavoritosState createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  final myController = TextEditingController();
  Data data = Data();
  List<Medicamento> _medicamentos, _medicamentosFiltrados = [];
  int _quantidadeMedicamentos = 0;
  int t = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informe o Medicamento"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: load().asStream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    default:
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.only(top: 10.0),
                                itemCount: _quantidadeMedicamentos,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_medicamentosFiltrados[index].nome),
                                    subtitle: Text(_medicamentosFiltrados[index].tipoMedicamento),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                    leading: Icon(MdiIcons.star),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => MostraMedicamento(
                                            medicamento: _medicamentosFiltrados[index],
                                          )));
                                    },
                                  );
                                }),
                          )
                        ],
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  load() async {
    if (t == 0) {
      _medicamentos = _medicamentosFiltrados = await data.buscaMedicamentos(context);
      print(_medicamentos);
      _quantidadeMedicamentos = _medicamentosFiltrados.length;
      t++;
    }
  }
}
