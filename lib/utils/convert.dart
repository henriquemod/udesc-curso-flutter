import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class Convert {
  static Future<String> encodeXFile(XFile image) async {
    var bytes = await image.readAsBytes();
    String resultado = base64.encode(bytes);
    return resultado;
  }

  static Uint8List decodeBase64Image(String imagem) {
    var bytes = base64.decode(imagem);
    return bytes;
  }
}
