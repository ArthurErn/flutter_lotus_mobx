import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/login/construtor_empresa.dart';
import 'package:lotus_erp/model/login/construtor_login.dart';
import 'package:lotus_erp/views/homepage/home_page.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'dart:convert';
import '../../views/login/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cherry_toast/cherry_toast.dart';

var grade;
var empresa = 0;
var idColaborador;
var idUsuario;
var mobDashboard;

//LISTA DE EMPRESAS QUE APARECEM NO DROPDOWN
class AuthenticationEmpresas {
  List<BuilderApi> resposta = <BuilderApi>[];

  //FAZ A CONEXÃO
  Future inicializar() async {
    final _usuario = configLoginController.text;
    final _senha = passController.text;
    var ip = ipController.text;
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));

    var url = Uri.parse('http://$ip/lotuserp/mobEmpresasListar');
    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    return response;
  }

  //CHECA A CONEXÃO COM A API
  Future getStatus(BuildContext context) async {
    inicializar().then((response) {
      if (response.statusCode == 200) {
        isLogin = true;
        erro(
            context, 'Conectado com Sucesso!', Icons.check, Colors.green);
      } else if (response.statusCode != 200) {
        //ERRO DE API
        erro(context, 'Conexão inválida', Icons.error, Colors.red);
      }
    });
  }

  //LISTANDO TODAS AS EMPRESAS
  Future<List<LoginEmpresa>> fetchAll() async {
    final _usuario = configLoginController.text;
    final _senha = passController.text;
    var _ip = ipController.text;
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));

    var url = Uri.parse('http://$_ip/lotuserp/mobEmpresasListar');
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
        u['codigo_descricao'],
      );
      empresas.add(empresa);
    }
    return empresas;
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
        'http://$_ip/lotuserp/mobUsuarioLogar?pUsuario=$_user&pSenha=$_pass&pidempresa=$_empresa');
    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    return response;
  }

  //CHECA SE A RESPOSTA FOI 200 (SUCESSO), CASO NAO SEJA RETORNA UM ERRO
  Future fetch(BuildContext context) async {
    await inicializar().then((resposta) async {
      if (resposta.statusCode == 200) {
        if (resposta.body.contains("MESSAGE")) {
          erro(context, 'Campos Invalidos!', Icons.error, Colors.red);
          resposta.body = '';
        } else {
          print('logou');
          // erro(context, 'Login efetuado! redirecionando..', Icons.check,
          //     Colors.green);
          Navigator.pushReplacement(
            context,
            PageTransition(
              duration: Duration(milliseconds: 210),
              type: PageTransitionType.leftToRight,
              alignment: Alignment.topCenter,
              child: HomePage(),
            ),
          );
        }
      } else if (resposta.statusCode != 200) {
        erro(context, 'Campos Invalidos!', Icons.error, Colors.red);
      }
    });
  }

  Future getUsuario() async {
    await inicializar().then((resposta) async {
      var responseJson = await json.decode(resposta.body);
      idColaborador = await responseJson[0]["colaborador_id"];
      idUsuario = await responseJson[0]["usuario_id"];
      mobDashboard = await responseJson[0]["mob_dashboard"];
    });
  }
}

Widget erro(BuildContext context, String text, IconData icon, Color color) {
  return CherryToast(
          themeColor: color,
          icon: Icon(
            icon,
            color: color,
          ),
          title: "",
          displayTitle: false,
          description: text,
          descriptionStyle: TextStyle(fontSize: 15),
          animationType: ANIMATION_TYPE.FROM_LEFT,
          animationDuration: Duration(milliseconds: 500),
          autoDismiss: true,
          displayCloseButton: false,
          )
      .show(context);
}
