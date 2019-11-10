import 'package:flutter/material.dart';
import 'package:tcc_fabiano/models/medicamento.dart';


class BuscaMedicamento extends StatefulWidget {
  @override
  _BuscaMedicamentoState createState() => _BuscaMedicamentoState();
}

class _BuscaMedicamentoState extends State<BuscaMedicamento> {
  final myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informe o Medicamento}"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: myController,
            decoration: InputDecoration(hintText: "Digite o nome do medicamento", prefixIcon: Icon(Icons.search)),
            onChanged: (value) {
              setState(() {
              });
            },
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: load(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[Icon(Icons.not_interested), Text("Sem conexão com a internet!")],
                          ),
                        ),
                      );
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
                                itemCount: quantidadeCli,
                                itemBuilder: (context, index) {
                                  return WidgetTeste(listCliFiltrados[index]);
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
  Widget WidgetTeste(Medicamento med) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: Text(med.nome),
            subtitle: Text(med.tipoMedicamento),
            leading: Icon(Icons.person),
            onTap: () {
//              Navigator.of(context).push(MaterialPageRoute(builder: (context) => cliente_screen(widget.data, Cli.id)));
            },
          ),
        )
      ],
    );
  }
}
