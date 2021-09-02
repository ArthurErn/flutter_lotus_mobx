import 'dart:convert';
import 'package:lotus_erp/model/charts/chart.model.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:http/http.dart' as http;

Future<List<ChartModel>> getListarVendaAnual() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/lotuserp/mobDashVendasAnual?pidempresa=$_empresa');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  List<ChartModel> vendas = [];

  for (var u in jsonData) {
    ChartModel venda = ChartModel(
      u["mes"],
      u['tot_liquido'],
    );
    vendas.add(venda);
  }
  return vendas;
}
