import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcc_fabiano/utils.dart';

class TratarImagem extends StatefulWidget {
  @override
  _TratarImagemState createState() => _TratarImagemState();
}

class _TratarImagemState extends State<TratarImagem> {
  File imageFileOriginal;
  File imageFile;
  File imageFileGrey;
  File imageFileSobel;

  Utils utils = Utils();

  Future getImage(context) async {
    imageFile = imageFileOriginal = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      utils.filterGray(imageFile).then((File imgSobel) {
        imageFileOriginal = imgSobel;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Photo Filter'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              new Container(
                child: imageFileOriginal != null
                    ? Center(
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration:
                    BoxDecoration(image: DecorationImage(image: FileImage(imageFileOriginal), fit: BoxFit.cover)),
                  ),
                )
                    : Container(),
              ),


            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
