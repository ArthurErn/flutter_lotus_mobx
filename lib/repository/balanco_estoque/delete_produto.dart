import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/pages/balanco_estoque/balanco_estoque.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/balanco_estoque/layout/produtos_balanco.dart';

//DELETA O PRODUTO DE UM BALANÇO ESPECIFICO
Future deleteProdutos() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _idProduto = idProduto;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/balanco_item_delete?idbalanco=$idBalanco&idproduto=$_idProduto&grade=UN');
  var data = await http
      .post(url, headers: <String, String>{'authorization': basicAuth});

  print(data.body);
  return data.body;
}
