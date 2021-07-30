import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/constructors/cadastro_clientes/construtor_cadastro.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:lotus_erp/pages/clientes/clientes_page.dart';
import 'package:lotus_erp/pages/clientes/layout/editar_cliente.dart';
import 'package:lotus_erp/pages/clientes/layout/error_message.dart';
import 'package:lotus_erp/pages/login/layout/login_dropdown.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/login/functions/index_api.dart';

List<Cnpj>cnpjsEdit;

//SAO FEITAS TODAS AS OUTRAS AUTENTICACOES ANTES DE CHEGAR NESSA
//METODO POST QUE EDITA USUÁRIO NA API
Future postEditUsuario() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);
  var jsonProduto = jsonEncode({
    "id_empresa": _empresa,
    "id": clienteId,
    "nome_razao": nomeRazaoEditText.toUpperCase(),
    "apelido_fantasia": apelidoFantasiaEditText.toUpperCase(),
    "tp_pessoa": cnpjEditText.length==14?1:0,
    "cpf_cnpj": cnpjEditText,
    "rg_insc": rgInscEditText,
    "fone1": telefoneEditText,
    "fone2": "",
    "fone3": "",
    "cep": cepEditText,
    "endereco": logradouroEditText,
    "endereco_numero": numeroEditText,
    "bairro": bairroEditText,
    "id_municipio": municipioEditId,
    "complemento": complementoEditText,
    "email": emailEditText
  });
  var encoded = base64Encode(utf8.encode(jsonProduto));

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobile/clientes_inserir');
  var data = await http.post(
    url,
    headers: <String, String>{'authorization': basicAuth},
    body: encoded,
  );
  //VERIFICAÇÃO
  if (data.statusCode == 200) {
    //CASO RETORNE RESULT 500 (JSON VAZIO)
    //PRINTA MENSAGEM DE ERRO
    if (data.body.contains("\"RESULT\"\:\"500\"")) {
      print(data.body);
      errorValidar(formKey.currentContext);
      return null;
    } else {
      print(data.body);
      //CASO CRIE O USUARIO, ELE RETORNA UMA MENSAGEM DE SUCESSO
      Navigator.pop(formKey.currentContext);
      Navigator.pop(formKey.currentContext);
      asuka.showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Row(
            children: [
              Text("Usuário editado"),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.check,
                color: Colors.white,
              )
            ],
          )));
      final String dataString = data.body;
      print(dataString);
      return null;
    }
  } else {
    print('erro');
    return null;
  }
}
