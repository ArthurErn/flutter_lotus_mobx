import 'package:flutter/material.dart';
import 'login_dropdown.dart';
import '../login_page.dart';

//ERRO NOS CAMPOS DE LOGIN
void errorDadosInput(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'lib/assets/images/alerta.png',
                  width: 50,
                  height: 50,
                ),
                Divider(
                  height: 20.0,
                  color: Colors.transparent,
                ),
                Container(
                    child: Text(
                  "CAMPOS INCORRETOS",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Por favor, tente novamente",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
          ));
}

//ERRO NOS CAMPOS DE CONEXAO API
void errorApiInput(BuildContext context) {
  isLogin = false;

  showDialog(
      context: formKey.currentContext,
      builder: (context) => AlertDialog(
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'lib/assets/images/alerta.png',
                  width: 50,
                  height: 50,
                ),
                Divider(
                  height: 20.0,
                  color: Colors.transparent,
                ),
                Container(
                    child: Text(
                  "INFORMAÇÕES INCORRETAS",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Não foi possivel conectar na API",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
            actions: <Widget>[],
          ));
}
