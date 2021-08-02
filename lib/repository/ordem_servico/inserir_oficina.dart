import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/repository/login/login_auth.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:lotus_erp/repository/vendas/edit_venda_auth.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/ordem_servico/editar_os.dart';

Future postOficina() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var empresa = getIndexEmpresa(aux);
  var jsonProduto = jsonEncode({
    "id_empresa": empresa,
    "id_usuario": idUsuario,
    "identificador": identificadorControllerAdd.text.toUpperCase(),
    "id_cliente": ordemIdPessoaSave,
    "id_atendente": idColaborador
  });
  //var encoded = base64Encode(utf8.encode(jsonProduto));

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobile/os_oficina_inserir');
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
