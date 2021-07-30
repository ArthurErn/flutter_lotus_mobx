import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/ordem_servico/imagens_os.dart';

Future postImage() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;

  var url = Uri.parse('');
  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));

  var request = http.MultipartRequest("post", url);
  Uint8List data = await galeria.image.readAsBytes();
  List<int> list = data.cast();
  request.files
      .add(http.MultipartFile.fromBytes('teste', list, filename: 'teste'));
  request.headers.addAll(<String, String>{'authorization': basicAuth});

  var response = await request.send();

  response.stream.bytesToString().asStream().listen((event) {
    var parsedJson = json.decode(event);
    print(parsedJson);
    print(response.statusCode);
  });
}
