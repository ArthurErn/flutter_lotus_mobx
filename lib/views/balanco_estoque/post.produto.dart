import 'package:flutter/material.dart';
import 'package:lotus_erp/views/balanco_estoque/layout/adicionar_saldo.dart';
import 'package:lotus_erp/views/balanco_estoque/layout/produtos_balanco.dart';
import 'package:lotus_erp/repository/balanco_estoque/adicionar_produto_auth.dart';
import 'package:asuka/asuka.dart' as asuka;

class PostProduto {
  postProduto(BuildContext context) {
    if (valorProduto > 0) {
      postProdutos().then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ItensBalanco()));
        asuka.showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Row(
              children: [
                Text("Item adicionado!"),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.check,
                  color: Colors.white,
                )
              ],
            )));
      });
    } else {
      errorSaldoInput(context);
    }
  }
}
