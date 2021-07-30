import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/repository/vendas/edit_venda_auth.dart';
import 'package:lotus_erp/pages/login/functions/index_api.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';

Future postTecnico() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var jsonProduto =
      jsonEncode({"id_os": ordemId, "id_tecnico": ordemTecnicoId});

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobile/os_oficina_tecnicos_inserir');
  var data = await http.post(
    url,
    headers: <String, String>{'authorization': basicAuth},
    body: jsonProduto,
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
