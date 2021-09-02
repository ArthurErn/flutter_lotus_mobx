import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/views/balanco_estoque/balanco_estoque.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/balanco_estoque/layout/produtos_balanco.dart';

//DELETA O PRODUTO DE UM BALANÇO ESPECIFICO
Future deleteProdutos() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _idProduto = idProduto;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/lotuserp/mobEstBalancosDeleteItem?pidbalanco=$idBalanco&pidproduto=$_idProduto&pgrade=UN');
  // ignore: unused_local_variable
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
}
