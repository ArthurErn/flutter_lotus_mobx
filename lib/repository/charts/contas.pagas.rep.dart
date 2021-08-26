import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/charts/chart.pagos.model.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:lotus_erp/views/login/login_page.dart';

Future<List<ContasPagas>> getListarContasPagas() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobDashContasPagarPag?pidempresa=$_empresa');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  List<ContasPagas> vendas = [];

  for (var u in jsonData) {
    ContasPagas venda = ContasPagas(
      u["mes"],
      u['tot_pago'],
    );
    vendas.add(venda);
  }
  return vendas;
}
