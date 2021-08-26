import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/ordem_servico/construtor_tecnico.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:mobx/mobx.dart';

//RETORNA UMA LISTA DE TODOS OS CLIENTES DA ROTA
Future getListarTecnico() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobOSOficinaAlocarTecnicoListar?pidos=$ordemId');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonDecode = json.decode(data.body);
  ObservableList<Tecnico> tecnicos = ObservableList();

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
