import 'package:flutter/material.dart';

class LoadingWidget{
  static Widget loadingWidget(context){
    return Center(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Processando as informações...",
                  style: TextStyle(fontSize: 30, color: Colors.black54), textAlign: TextAlign.center),
              SizedBox(height: 20,),
              LinearProgressIndicator()
            ],
          )),
    );
  }
}