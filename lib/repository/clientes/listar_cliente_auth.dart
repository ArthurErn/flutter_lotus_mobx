import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/clientes/construtor_edit_pessoa.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:mobx/mobx.dart';

var tipoCad = 0;
//RETORNA UMA LISTA DE TODOS OS CLIENTES DA ROTA
Future getListarCliente() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/pessoas_listar?ptipocad=$tipoCad&ptipopesquisa=1&pvalorpesquisa=');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonDecode = json.decode(data.body);
  ObservableList<EditPessoa> pessoas = ObservableList();

  for (var u in jsonDecode) {
    EditPessoa pessoa = EditPessoa(
      u['id'],
      u['tp_pessoa'],
      u['cpf_cnpj'],
      u['rg_insc'],
      u['nome_razao'],
      u['apelido_fantasia'],
      u['fone1'],
      u['fone2'],
      u['fone3'],
      u['endereco'],
      u['endereco_numero'],
      u['bairro'],
      u['municipio_id'],
      u['municipio_nome'],
      u['municipio_estado'],
      u['status_id'],
      u['status_nome'],
      u['cep'],
      u['complemento'],
      u['email'],
      u['status_bloqueado'],
    );
    pessoas.add(pessoa);
  }
  return pessoas;
}
