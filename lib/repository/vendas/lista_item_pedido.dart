import 'package:http/http.dart' as http;
import 'package:lotus_erp/constructors/vendas/construtor_lista_pedido.dart';
import 'dart:convert';
import 'dart:async';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/vendas/vendas_page.dart';

//RETORNA OS BALANÇOS DE ACORDO COM A EMPRESA
Future<List<ListVenda>> getItensPedido() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobile/vendas_listar_itens?idvenda=$idEdit');
  var data = await http.get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  List<ListVenda> itensPedido = [];

  for (var u in jsonData) {
    ListVenda itemPedido = ListVenda(
      u["id_venda"],
      u["item"],
      u["id_produto"],
      u["produto_descricao"],
      u["unidade"],
      u["ref_fabrica"],
      u["gtin"],
      u["vlr_vendido"],
      u["qtde"],
      u["vlr_bruto"],
      u["vlr_desc_prc"],
      u["vlr_desc_vlr"],
      u["vlr_liquido"],
      u["grade"],
      u["vlr_vendido_original"],
      u["complemento"]);
    itensPedido.add(itemPedido);
  }

  print(itensPedido.length);
  return itensPedido;
}
