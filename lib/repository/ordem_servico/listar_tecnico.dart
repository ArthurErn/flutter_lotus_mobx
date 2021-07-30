import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/constructors/clientes/construtor_edit_pessoa.dart';
import 'package:lotus_erp/constructors/ordem_servico/construtor_tecnico.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';

//RETORNA UMA LISTA DE TODOS OS CLIENTES DA ROTA
Future getListarTecnico() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/os_oficina_tecnicos_listar?idos=$ordemId');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonDecode = json.decode(data.body);
  List<Tecnico> tecnicos = [];

  for (var u in jsonDecode) {
    Tecnico tecnico = Tecnico(
      u['id_os'],
      u['id_tecnico'],
      u['nome_razao'],
    );
    tecnicos.add(tecnico);
  }
  return tecnicos;
}
