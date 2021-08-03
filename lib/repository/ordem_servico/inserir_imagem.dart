import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/ordem_servico/imagens_os.dart';

Future postImage() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;

  String base64Image = base64Encode(galeria.image.readAsBytesSync());
  String filename = galeria.image.path.split('/').last;

  var url =
      Uri.parse('http://$_ip/mobile/os_oficina_foto_enviar?idos=$ordemId');

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  
  http.post(url,
      headers: <String, String>{'authorization': basicAuth},
      body: {'imagem': base64Image, 'nome': filename}).then((resultado) {
    print(resultado.body);
  });
  
  // ignore: deprecated_member_use
  // var stream =
  //     new http.ByteStream(DelegatingStream.typed(galeria.image.openRead()));
  // var length = await galeria.image.length();
  // var request = http.MultipartRequest("POST", url);
  // Uint8List data = await galeria.image.readAsBytes();
  // request.headers.addAll(<String, String>{'authorization': basicAuth});

  // List<int> list = data.cast();
  // request.files.add(http.MultipartFile.fromBytes('field', list));

  // var response = await request.send();

  // response.stream.bytesToString().asStream().listen((event) {
  //   var parsedJson = event;
  //   print(parsedJson);
  //   print(response.statusCode);
  // });
}
