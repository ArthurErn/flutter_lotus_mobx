import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/vendas/construtor_pedidos.dart';
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/vendas/vendas_page.dart';
import 'package:mobx/mobx.dart';

//RETORNA OS BALANÇOS DE ACORDO COM A EMPRESA
Future<ObservableList<ListaPedidos>> getPedidos() async {
  DateTime now = DateTime.now();
  var _datafinal = DateFormat('dMMyyyy').format(now);
  var _data = dataText != "" ? dataText : _datafinal;
  _datafinal = _data != "" ? _data : _datafinal;
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _empresa = getIndexEmpresa(val);
  var _ip = ipController.text;

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/vendas_listar?idempresa=$_empresa&dinicial=$_data&dfinal=$_datafinal');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
    ObservableList<ListaPedidos> pedidos = ObservableList();

  for (var u in jsonData) {
    ListaPedidos pedido = ListaPedidos(
      u["id"],
      u['data_venda'],
      u['hora_venda'],
      u["id_cliente"],
      u['cliente_nome'],
      u['vendedor_nome'],
      u["fpagto_descricao"],
      u['tot_bruto'],
      u['tot_desc_prc"'],
      u["tot_desc_vlr"],
      u['tot_liquido'],
    );
    pedidos.add(pedido);
  }

  print(pedidos.length);
  return pedidos;
}
