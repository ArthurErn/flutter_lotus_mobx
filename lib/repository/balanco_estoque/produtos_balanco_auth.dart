import 'package:http/http.dart' as http;
import 'package:lotus_erp/constructors/balanco_estoque/construtor_produtos_balanco.dart';
import 'package:lotus_erp/pages/balanco_estoque/balanco_estoque.dart';
import 'dart:convert';
import 'dart:async';
import 'package:lotus_erp/pages/login/login_page.dart';

//RETORNA OS ITENS DE UM BALANÇO ESPECIFICO
Future<List<ProdutosBalanco>> getProdutosBalanco() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/balanco_listar_itens?idbalanco=$idBalanco');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  List<ProdutosBalanco> produtosBalanco = [];

  for (var u in jsonData) {
    ProdutosBalanco produto = ProdutosBalanco(
      u["id_balanco"],
      u['id_produto'],
      u['descricao'],
      u['ref_fabrica'],
      u['gtin'],
      u['saldo_novo'],
      u['saldo_anterior'],
      u['vlr_custo'],
      u['vlr_compra'],
      u['vlr_venda'],
      u['grade'],
    );
    produtosBalanco.add(produto);
  }
  print(produtosBalanco.length);
  return produtosBalanco;
}
