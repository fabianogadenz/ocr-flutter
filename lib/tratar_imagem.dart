import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as teste;
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

class TratarImagem extends StatefulWidget {
  @override
  _TratarImagemState createState() => _TratarImagemState();
}

class _TratarImagemState extends State<TratarImagem> {
  String fileName;
  File imageFile;
  Future getImage(context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    fileName = basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);
    imageLib.Image filtroImage = await teste.sobel(image, amount: 1.0);

    var pixels = filtroImage.getBytes();
    imageLib.Image out = imageLib.Image.fromBytes(filtroImage.width, filtroImage.height, pixels);
    setState(() {
      imageFile = new File(imageFile.path)..writeAsBytes(imageLib.encodeNamedImage(out, imageFile.path));
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
          child: new Container(
            child: imageFile == null
                ? Center(
              child: new Text('No image selected.'),
            )
                : Image.file(imageFile),
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
