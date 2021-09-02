import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/ordem_servico/construtor_produtos.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:mobx/mobx.dart';

Future<ObservableList<ProdutoOS>> getListarProdutosOS() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/lotuserp/mobOSOficinaItemListar?pidos=$ordemId');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  ObservableList<ProdutoOS> produtos = ObservableList();

  for (var u in jsonData) {
    ProdutoOS produto = ProdutoOS(
      u["item"],
      u['id_produto'],
      u['produto_nome'],
      u['unidade'],
      u['ref_fabrica'],
      u['gtin'],
      u['servico'],
      u['complemento'],
      u['vlr_vendido'],
      u['qtde'],
      u['vlr_bruto'],
      u['vlr_desc_prc'],
      u['vlr_desc_vlr'],
      u['vlr_liquido'],
      u['id_tecnico'],
      u['tecnico_nome'],
    );
    produtos.add(produto);
  }
  return produtos;
}
