import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/controllers/editar.os.controller.dart';
import 'package:lotus_erp/repository/login/login_auth.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/ordem_servico/adicionar_produto.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';

Future postItem() async {
  var aux = 0;
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  // ignore: unused_local_variable
  var empresa = getIndexEmpresa(aux);

  var jsonProduto = jsonEncode({
    "id_os": ordemId,
    "item": osController.produtosOS.length + 1,
    "id_produto": produtosOrdem.id_produto,
    "complemento": '',
    "vlr_vendido": produtosOrdem.produto_pvenda,
    "qtde": quantidadeProdutoOrdem,
    "vlr_bruto": (produtosOrdem.produto_pvenda * quantidadeProdutoOrdem),
    "vlr_desc_prc": 0,
    "vlr_desc_vlr": 0,
    "vlr_liquido": (produtosOrdem.produto_pvenda * quantidadeProdutoOrdem),
    "id_tecnico": idUsuario
  });

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobOSOficinaItemInserir');
  var data = await http.post(
    url,
    headers: <String, String>{'authorization': basicAuth},
    body: jsonProduto,
  );
  aux++;
  osController.produtoLength++;
  if (data.statusCode == 200) {
    final String dataString = data.body;
    print(dataString);
  } else {
    print('erro');
  }
  return null;
}
