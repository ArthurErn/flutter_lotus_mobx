import 'dart:convert';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/views/vendas/nova_venda.dart';
import 'package:lotus_erp/views/vendas/vendas_page.dart';

Future alterarPagamento() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var fPagamento = selecionadoVenda.id;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/lotuserp/mobVendasAlterarFPagto?pidvenda=$idEdit&pidfpagto=$fPagamento');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);

  return jsonData;
}
