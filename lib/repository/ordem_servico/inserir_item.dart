import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/repository/login/login_auth.dart';
import 'package:lotus_erp/pages/login/functions/index_api.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/ordem_servico/adicionar_produto.dart';
import 'package:lotus_erp/pages/ordem_servico/editar_os.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';
import 'package:lotus_erp/pages/ordem_servico/produtos_servico.dart';

Future postItem() async {
  var aux = 0;
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var empresa = getIndexEmpresa(aux);

  var jsonProduto = jsonEncode({
    "id_os": ordemId,
    "item": produtoLength,
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
  var url = Uri.parse('http://$_ip/mobile/os_oficina_item');
  var data = await http.post(
    url,
    headers: <String, String>{'authorization': basicAuth},
    body: jsonProduto,
  );
  aux++;
  produtoLength++;
  if (data.statusCode == 200) {
    final String dataString = data.body;
    print(dataString);
  } else {
    print('erro');
  }
  return null;
}
