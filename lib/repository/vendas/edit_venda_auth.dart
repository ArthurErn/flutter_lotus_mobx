import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/controllers/editar.pedido.controller.dart';
import 'package:lotus_erp/repository/login/login_auth.dart';
import 'package:lotus_erp/views/homepage/home_page.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/vendas/layout/adicionar_quantidade.dart';
import 'package:lotus_erp/views/vendas/vendas_page.dart';

double totalLiquidoVenda = 0;
int aux = -1;
int indice = 0;
int qtdItens = 0;
double totalBrutoVenda = 0;

getTotalEdit() {
  indice = 0;
  // ignore: unused_local_variable
  for (var produto in produtoVendas) {
    totalBrutoVenda = totalBrutoVenda +
        (produtoVendas[indice].produto_pvenda * valoresProduto[indice]);

    totalLiquidoVenda = (totalLiquidoVenda +
            (produtoVendas[indice].produto_pvenda * valoresProduto[indice])) -
        (produtoVendas[indice].produto_pvenda *
            valoresProduto[indice] *
            porcentagensProdutos[indice] /
            100);
    indice = indice + 1;
  }
}

Future editsVenda() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  

  // ignore: unused_local_variable
  for (var produto in produtoVendas) {
    aux = 0;

    qtdItens = qtdItens + editVenda.itensPedidosEdit.length + 1;
    dynamic _totalBruto =
        produtoVendas[aux].produto_pvenda * valoresProduto[aux];
    dynamic _valorPorcentagemFinal =
        _totalBruto * porcentagensProdutos[aux] / 100;
    var jsonItem = jsonEncode({
      "id_venda": idEdit,
      "item": qtdItens,
      "id_produto": produtoVendas[aux].id_produto,
      "complemento": complementoLista[aux],
      "vlr_vendido": produtoVendas[aux].produto_pvenda,
      "qtde": valoresProduto[aux],
      "tot_bruto": _totalBruto,
      "vlr_desc_prc": porcentagensProdutos[aux],
      "vlr_desc_vlr": _valorPorcentagemFinal,
      "grade": "UN",
      "id_vendedor": idColaborador
    });

    var encoded = base64Encode(utf8.encode(jsonItem));

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
    var url = Uri.parse('http://$_ip/mobVendasInserirItem');
    var data = await http.post(
      url,
      headers: <String, String>{'authorization': basicAuth},
      body: jsonItem,
    );
    print(data.body);
  }
}
