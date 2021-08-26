import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/balanco_estoque/construtor_balanco.dart';
import 'dart:convert';
import 'dart:async';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:mobx/mobx.dart';


//RETORNA OS BALANÇOS DE ACORDO COM A EMPRESA
Future<ObservableList<Balanco>> getBalanco() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _empresa = getIndexEmpresa(val);
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobEstBalancosListar?pidempresa=$_empresa');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  ObservableList<Balanco> balancos = ObservableList();

  for (var u in jsonData) {
    Balanco balanco = Balanco(
        u["id"],
        u['data'],
        u['balanco_motivo'],
    );
    balancos.add(balanco);
  }

  print(balancos.length);
  return balancos;
}
