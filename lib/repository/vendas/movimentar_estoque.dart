import 'dart:convert';
import 'package:lotus_erp/repository/login/login_auth.dart';
import 'package:lotus_erp/repository/vendas/inserir_item_auth.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:http/http.dart' as http;

Future movimentarEstoque() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);
  var _idVenda = idVenda;
  var _idUsuario = idUsuario;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/vendas_cab_estoque?idvenda=$_idVenda&idusuario=$_idUsuario&idempresa=$_empresa');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  print(jsonData);
  return jsonData;
}
