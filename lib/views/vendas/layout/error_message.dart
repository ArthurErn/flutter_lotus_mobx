import 'package:flutter/material.dart';
import 'package:lotus_erp/views/login/layout/login_dropdown.dart';

bool erro = false;
TextEditingController saldoController;
void errorTotalLiquido(BuildContext context) {
  showDialog(
      context: formKey.currentContext,
      builder: (context) => AlertDialog(
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  "Informações Incorretas",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Por favor adicione um produto",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
          ));
}

void errorPagamento(BuildContext context) {
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
                  "Informações Incorretas",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Selecione o método de pagamento",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
            actions: <Widget>[],
          ));
}

void errorCliente(BuildContext context) {
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
                  "Informações Incorretas",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Text(
                  "Selecione um cliente",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ],
            )),
            actions: <Widget>[],
          ));
}