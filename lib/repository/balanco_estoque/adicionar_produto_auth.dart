import 'package:http/http.dart' as http;
import 'package:lotus_erp/pages/balanco_estoque/layout/adicionar_produto.dart';
import 'package:lotus_erp/pages/balanco_estoque/layout/adicionar_saldo.dart';
import 'package:lotus_erp/pages/balanco_estoque/balanco_estoque.dart';
import 'dart:convert';
import 'dart:async';
import 'package:lotus_erp/pages/login/login_page.dart';

int val;

//ADICIONA PRODUTO NA ROTA DA API
Future postProdutos() async {
  var valorProd = valor.text;
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var jsonProduto = jsonEncode({
    "id_balanco": idBalanco,
    "id_produto": valorId,
    "saldo_novo": valorProd,
    "grade": "UN"
  });
  var encoded = base64Encode(utf8.encode(jsonProduto));

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobile/balanco_inserir');
  var data = await http.post(
    url,
    headers: <String, String>{'authorization': basicAuth},
    body: encoded,
  );
  if (data.statusCode == 200) {
    final String dataString = data.body;
    print(dataString);
    return null;
  } else {
    print('erro');
    return null;
  }
}

