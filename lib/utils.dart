import 'dart:async';
import 'dart:io';
import 'package:image/image.dart' as imageLib;

class Utils{
  Future<File> filterSobel(File file_image) async {
    //convertendo file para img
    var image = imageLib.decodeImage(file_image.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);
    imageLib.Image filtroImage = await imageLib.sobel(image, amount: 1.0);
    //convertendo img para file
    var pixels = filtroImage.getBytes();
    imageLib.Image out = imageLib.Image.fromBytes(filtroImage.width, filtroImage.height, pixels);
    return File(file_image.path)..writeAsBytes(imageLib.encodeNamedImage(out, file_image.path));
  }

  Future<File> filterGray(File file_image) async {
    //convertendo file para img
    var image = imageLib.decodeImage(file_image.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);
    imageLib.Image filtroImage = await imageLib.grayscale(image);
    //convertendo img para file
    var pixels = filtroImage.getBytes();
    imageLib.Image out = imageLib.Image.fromBytes(filtroImage.width, filtroImage.height, pixels);
    return File(file_image.path)..writeAsBytes(imageLib.encodeNamedImage(out, file_image.path));
  }
}