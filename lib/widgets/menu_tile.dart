import 'package:flutter/material.dart';

class MenuTile {
  static Widget menuTile({@required String titulo, @required IconData icone, @required Function funcao}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: funcao,
        child: Container(
          height: 100,
          child: new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.teal, width: 3.0, style: BorderStyle.solid),
              borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icone,
                  color: Colors.teal,
                  size: 70,
                ),
                Text(
                  titulo,
                  style: TextStyle(color: Colors.teal, fontSize: 30),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
