import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:lotus_erp/controllers/editar.os.controller.dart';
import 'package:lotus_erp/views/clientes/layout/error_message.dart';
import 'package:lotus_erp/repository/clientes/get.cliente.edit.data.dart';
import 'package:lotus_erp/repository/clientes/post_edit_cliente_auth.dart';

class FuncEditarCliente {
  editarCliente(BuildContext context) {
    if (cepEditText == null ||
        cepEditText == "" ||
        nomeRazaoEditText == null ||
        nomeRazaoEditText == "" ||
        logradouroEditText == null ||
        logradouroEditText == "" ||
        numeroEditText == null ||
        numeroEditText == "" ||
        bairroEditText == null ||
        bairroEditText == "") {
      errorCampos(context);
    } else {
      if (cnpjEditText == null || cnpjEditText == "") {
        errorCNPJvazio(context);
      } else {
        postEditUsuario().then((value) {
          Navigator.of(context).pop();
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
          osController.listarClientes();
        });
      }
    }
  }
}
