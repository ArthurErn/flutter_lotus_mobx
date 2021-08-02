import 'package:flutter/material.dart';
import 'package:lotus_erp/pages/login/layout/login_dropdown.dart';

//MENSAGEM DE CNPJ INVALIDO != VAZIO
void errorCNPJInput(BuildContext context) {
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
                  "INFORMAÇÕES INCORRETAS",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Não foi possível encontrar este CNPJ",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
            actions: <Widget>[],
          ));
}

//MENSAGEM DE CNPJ INVALIDO != VAZIO
void errorSalvarInput(BuildContext context) {
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
                  "Não foi possível encontrar este CNPJ",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
            actions: <Widget>[],
          ));
}

//MENSAGEM DE CNPJ VAZIO
void errorCNPJvazio(BuildContext context) {
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
                  "Por favor insira o CNPJ/CPF",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
            actions: <Widget>[],
          ));
}

//MENSAGEM DE CAMPOS INVALIDOS != CNPJ
void errorCampos(BuildContext context) {
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
                  "INFORMAÇÕES INCORRETAS",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Por favor insira os campos obrigatórios",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
            actions: <Widget>[],
          ));
}

//ERRO DE VALIDAÇÃO, OBRIGATORIO VALIDAR CNPJ ANTES DE DAR CONTINUIDADE
void errorValidar(BuildContext context) {
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
                  "ERRO",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Por favor valide seu CNPJ",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
            actions: <Widget>[],
          ));
}
