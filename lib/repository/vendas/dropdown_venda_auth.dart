import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/vendas/construtor_forma_pagamento.dart';
import 'dart:convert';
import 'dart:async';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:mobx/mobx.dart';

//RETORNA OS BALANÇOS DE ACORDO COM A EMPRESA
Future<ObservableList<FormaPagamento>> getFormaPagamento() async {

  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _empresa = getIndexEmpresa(val);
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/lotuserp/mobFPagtosListar?pidempresa=$_empresa&pdescricao=');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  ObservableList<FormaPagamento> formas = ObservableList();

  for (var u in jsonData) {
    FormaPagamento forma = FormaPagamento(
      u["id"],
      u['descricao'],
      u['juros'],
      u["desconto"],
    );
    formas.add(forma);
  }
  return formas;
}
