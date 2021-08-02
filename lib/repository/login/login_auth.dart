import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/login/construtor_empresa.dart';
import 'package:lotus_erp/pages/homepage/home_page.dart';
import 'package:lotus_erp/pages/login/layout/error_messages.dart';
import 'package:lotus_erp/pages/login/functions/index_api.dart';
import 'dart:convert';
import '../../pages/login/login_page.dart';
import '../../pages/login/layout/login_dropdown.dart';
import '../../model/login/construtor_login.dart';

var grade;
var empresa = 0;
var idColaborador;
var idUsuario;

//LISTA DE EMPRESAS QUE APARECEM NO DROPDOWN
class AuthenticationEmpresas {
  List<BuilderApi> resposta = <BuilderApi>[];

  //FAZ A CONEXÃO
  Future inicializar() async {
    final _usuario = configLoginController.text;
    final _senha = passController.text;
    var ip = ipController.text;
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));

    var url = Uri.parse('http://$ip/mobile/empresas');
    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    return response;
  }

  //CHECA A CONEXÃO COM A API
  Future getStatus() async {
    inicializar().then((response) {
      if (response.statusCode == 200) {
        isLogin = true;
      } else if (response.statusCode == 401) {
        //ERRO DE API
        errorApiInput(formKey.currentContext);
      }
    });
  }

  //LISTANDO TODAS AS EMPRESAS
  Future<List<LoginEmpresa>> fetchAll() async {
    final _usuario = configLoginController.text;
    final _senha = passController.text;
    var _ip = ipController.text;
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));

    var url = Uri.parse('http://$_ip/mobile/empresas');
    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    var body = response.body;
    String json = body;
    var tagsJson = jsonDecode(json);

    List<LoginEmpresa> empresas = [];
    for (var u in tagsJson) {
      LoginEmpresa empresa = LoginEmpresa(
        u['id'],
        u['razao'],
        u['fantasia'],
        u['cnpj'],
        u['versao_liberacao'],
        u['tipo_os'],
        u['desconto_individual'],
        u['ramo'],
        u['versao'],
        u['codigo_descricao'],
      );
      empresas.add(empresa);
    }
    return empresas;
/*
    for (_element in tags) {
      Map obj = _element;
      String empresas = await obj['codigo_descricao'];
      listaApi.add(empresas);
    }
    //return listaApi;*/
  }
}

//FAZ O LOGIN NA ROTA DA API
class AuthenticationLogin {
  Future inicializar() async {
    var _usuario = configLoginControllerText;
    var _senha = passControllerText;
    var _ip = ipController.text;
    var _user = loginController.text.toUpperCase();
    var _pass = passLogController.text;
    var _empresa = getIndexEmpresa(val);

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
    var url = Uri.parse(
        'http://$_ip/mobile/usuario?pUsuario=$_user&pSenha=$_pass&pidempresa=$_empresa');
    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    return response;
  }

  //CHECA SE A RESPOSTA FOI 200 (SUCESSO), CASO NAO SEJA RETORNA UM ERRO
  Future fetch() async {
    inicializar().then((resposta) async {
      // ignore: unused_local_variable
      var responseJson = await json.decode(resposta.body);
      if (resposta.statusCode == 200) {
        if (resposta.body.contains("MESSAGE")) {
          errorDadosInput(formKey.currentContext);
        } else {
          print('logou');
          Navigator.pushReplacement(formKey.currentContext,
              MaterialPageRoute(builder: (context) => HomePage()));
        }
      } else if (resposta.statusCode != 200) {
        errorDadosInput(formKey.currentContext);
      }
    });
  }

  //NAO UTILIZADO
  /*Future getEmpresa() async {
    await inicializar().then((resposta) async {
      var responseJson = await json.decode(resposta.body);
      String empresaData = await responseJson[0]["empresa_fantasia"];
      print(empresaData);
      return empresaData;
    });
  }*/

  Future getUsuario() async {
    await inicializar().then((resposta) async {
      var responseJson = await json.decode(resposta.body);
      idColaborador = await responseJson[0]["colaborador_id"];
      idUsuario = await responseJson[0]["usuario_id"];
    });
  }
}
