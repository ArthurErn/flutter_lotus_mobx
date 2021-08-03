import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/controllers/clientes.controller.dart';
import 'package:lotus_erp/model/cadastro_clientes/construtor_municipio.dart';
import 'package:lotus_erp/views/login/login_page.dart';

//PENULTIMA ROTA, PARA CONFIRMACAO DE IBGE, APÓS CONFIRMAÇÃO DE IBGE PARTIMOS PARA cadastro_clientes_auth (ROTA FINAL)
//OBS:. FUNCIONA TANTO PARA EDIT QUANTO PARA CADASTRO DE CLIENTES
Future<List<Municipio>> getMunicipio() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/municipios?ptipo=2&ptipo_valor=${clientes.ibge}');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonDecode = json.decode(data.body);

  List<Municipio> municipios = [];

  for (var u in jsonDecode) {
    Municipio municipio = Municipio(
      u["municipio_id"],
      u['municipio_nome'],
      u['municipio_estado'],
    );
    municipios.add(municipio);
  }
  return municipios;
}
