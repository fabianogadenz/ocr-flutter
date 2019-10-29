import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  onPressed: () => null,
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.camera_alt, size: 30, color: Colors.teal[800])
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Capturar Foto",
                            style: TextStyle(fontSize: 30, color: Colors.teal[800]),
                            textAlign: TextAlign.center,
                          )
                      )
                    ],
                  ),
                  highlightedBorderColor: Colors.cyan,
                  color: Colors.teal,
                  borderSide: new BorderSide(color: Colors.teal),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)
                  )
              ),
            ),
          ),



          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              child: OutlineButton(
                  onPressed: () => null,
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.camera_alt, size: 30, color: Colors.teal[800])
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Carregar Foto",
                            style: TextStyle(fontSize: 30, color: Colors.teal[800]),
                            textAlign: TextAlign.center,
                          )
                      )
                    ],
                  ),
                  highlightedBorderColor: Colors.cyan,
                  color: Colors.teal,
                  borderSide: new BorderSide(color: Colors.teal),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
