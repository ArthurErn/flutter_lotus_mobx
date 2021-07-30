import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/vendas/layout/editar_venda.dart';
import 'package:lotus_erp/pages/vendas/vendas_page.dart';

//RETORNA OS BALANÇOS DE ACORDO COM A EMPRESA
Future excluirItem() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _item = posicaoItem;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/vendas_item_delete?vidvenda=$idEdit&vitem=$_item');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);

  return jsonData;
}
