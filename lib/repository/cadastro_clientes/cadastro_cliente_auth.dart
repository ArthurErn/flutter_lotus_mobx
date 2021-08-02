import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/controllers/clientes.controller.dart';
import 'package:lotus_erp/model/cadastro_clientes/construtor_cadastro.dart';
import 'package:lotus_erp/views/clientes/cadastro_page.dart';
import 'package:lotus_erp/views/clientes/layout/error_message.dart';
import 'package:lotus_erp/views/login/layout/login_dropdown.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:asuka/asuka.dart' as asuka;

List<Cnpj> cnpjs;

//SAO FEITAS TODAS AS OUTRAS AUTENTICACOES ANTES DE CHEGAR NESSA
//METODO POST QUE ADICIONA USUÁRIO NA API
Future postUsuario() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);
  var jsonProduto = jsonEncode({
    "id_empresa": _empresa,
    "id": 0,
    "nome_razao": clientes.nomeRazaoText.toUpperCase(),
    "apelido_fantasia": clientes.apelidoFantasiaText.toUpperCase(),
    "tp_pessoa": clientes.cnpjText.length==14?1:0,
    "cpf_cnpj": clientes.cnpjText,
    "rg_insc": clientes.rgInscText,
    "fone1": clientes.telefoneText,
    "fone2": "",
    "fone3": "",
    "cep": clientes.cepText,
    "endereco": clientes.logradouroText,
    "endereco_numero": clientes.numeroText,
    "bairro": clientes.bairroText,
    "id_municipio": clientes.municipioId!=null?clientes.municipioId:0,
    "complemento": clientes.complementoText,
    "email": clientes.emailText
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
              Text("Usuário cadastrado"),
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
