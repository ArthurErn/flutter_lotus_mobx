import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

uploadFile(
    String url, Uri uri, String usuario, String senha, int ordemid) async {
  var postUri = Uri.parse(url);
  var request = new http.MultipartRequest("POST", postUri);
  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$usuario:$senha'));
  request.fields['idos'] = ordemid.toString();
  request.files.add(new http.MultipartFile.fromBytes(
      'file', await File.fromUri(uri).readAsBytes(),
      contentType: new MediaType('image', '.jpg'), filename: ordemid.toString()+"_imagem"));
  request.headers.addAll(<String, String>{'authorization': basicAuth});

  request.send().then((response) {
    if (response.statusCode == 200) {
      print(response);
    }
  });
}
