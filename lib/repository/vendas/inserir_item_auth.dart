import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/repository/login/login_auth.dart';
import 'package:lotus_erp/pages/homepage/home_page.dart';
import 'package:lotus_erp/pages/login/functions/index_api.dart';
import 'package:lotus_erp/pages/login/layout/login_dropdown.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/vendas/layout/adicionar_quantidade.dart';

import 'package:lotus_erp/pages/vendas/nova_venda.dart';
import 'package:lotus_erp/pages/vendas/vendas_page.dart';

double totalLiquidoVenda = 0;
var idVenda;
int aux = -1;
int indice = 0;
int qtdItens = 0;
double totalBrutoVenda = 0;

getTotal() {
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

Future postItem() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);

  var jsonCabecalho = jsonEncode({
    "id_venda": 0,
    "id_empresa": _empresa,
    "id_cliente": indexCliente,
    "id_vendedor": idColaborador,
    "id_fpagto": selecionadoVenda.id,
    "id_usuario": idUsuario,
    "tot_bruto": totalBrutoVenda,
    "tot_desc_prc": descontoIndividual == 0 ? porcentagemDescontoTotal.text : 0,
    "tot_desc_vlr": descontoIndividual == 0 ? valorDescontoTotal.text : 0,
    "tot_liquido": totalLiquido,
    "status": statusCabecalho
  });
  var encoded = base64Encode(utf8.encode(jsonCabecalho));

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobile/vendas_inserir_cab');
  var data = await http.post(
    url,
    headers: <String, String>{'authorization': basicAuth},
    body: encoded,
  );
  print(data.body);

  idVenda = data.body.replaceAll("{\"MESSAGE\":\"", "");
  idVenda = idVenda.replaceAll("\",\"RESULT\":\"200\"}", "");

  for (var produto in produtoVendas) {
    aux = aux + 1;

    qtdItens = qtdItens + 1;
    dynamic _totalBruto =
        produtoVendas[aux].produto_pvenda * valoresProduto[aux];
    dynamic _valorPorcentagemFinal =
        _totalBruto * porcentagensProdutos[aux] / 100;
    var jsonItem = jsonEncode({
      "id_venda": idVenda,
      "item": qtdItens,
      "id_produto": produtoVendas[aux].id_produto,
      "complemento": complementoLista[aux],
      "vlr_vendido": produtoVendas[aux].produto_pvenda,
      "vlr_vendido_original": produtoVendas[aux].produto_pvenda,
      "qtde": valoresProduto[aux],
      "tot_bruto": _totalBruto,
      "vlr_desc_prc": porcentagensProdutos[aux],
      "vlr_desc_vlr": _valorPorcentagemFinal,
      "vlr_liquido": _totalBruto - _valorPorcentagemFinal,
      "grade": "UN",
      "id_vendedor": idColaborador
    });

    var encoded = base64Encode(utf8.encode(jsonItem));

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
    var url = Uri.parse('http://$_ip/mobile/vendas_inserir_itm');
    var data = await http.post(
      url,
      headers: <String, String>{'authorization': basicAuth},
      body: encoded,
    );
    print(data.body);
  }
  if (descontoIndividual == 0) {
    var attCabecalho = jsonEncode({
      "id_venda": idVenda,
      "tot_bruto": totalBrutoVenda,
      "tot_desc_prc": porcentagemDescontoTotal.text,
      "tot_desc_vlr": valorDescontoTotal.text
    });
    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
    var url = Uri.parse('http://$_ip/mobile/vendas_cab_desc_ger');
    var data = await http.post(
      url,
      headers: <String, String>{'authorization': basicAuth},
      body: attCabecalho,
    );
    print(data.body);
  }
}

Future editItem() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);

  for (var produto in produtoVendas) {
    aux = aux + 1;

    qtdItens = qtdItens + 1;
    dynamic _totalBruto =
        produtoVendas[aux].produto_pvenda * valoresProduto[aux];
    dynamic _valorPorcentagemFinal =
        _totalBruto * porcentagensProdutos[aux] / 100;

    var jsonItem = jsonEncode({
      "id_venda": idEdit,
      "item": qtdItens,
      "id_produto": produtoVendas[aux].id_produto,
      "complemento": complementoText,
      "vlr_vendido": produtoVendas[aux].produto_pvenda,
      "vlr_vendido_original": produtoVendas[aux].produto_pvenda,
      "qtde": valoresProduto[aux],
      "tot_bruto": _totalBruto,
      "vlr_desc_prc": porcentagensProdutos[aux],
      "vlr_desc_vlr": _valorPorcentagemFinal,
      "vlr_liquido": _totalBruto - _valorPorcentagemFinal,
      "grade": "UN",
      "id_vendedor": idColaborador
    });

    var encoded = base64Encode(utf8.encode(jsonItem));

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
    var url = Uri.parse('http://$_ip/mobile/vendas_inserir_itm');
    var data = await http.post(
      url,
      headers: <String, String>{'authorization': basicAuth},
      body: encoded,
    );
    print(data.body);
  }
}
