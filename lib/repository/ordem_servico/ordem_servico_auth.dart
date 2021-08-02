import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/ordem_servico/ordem_servico.dart';
import 'package:lotus_erp/pages/login/functions/index_api.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';
import 'package:intl/intl.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:mobx/mobx.dart';

Future<ObservableList<Ordem>> getOrdem() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);
  var _buscar = buscarController.text;
  _buscar = _buscar.replaceAll("/", "");
  DateTime now = DateTime.now();
  String formatado = DateFormat('ddMMyyyy').format(now);

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/os_oficina_listar?idempresa=$_empresa&status=0&identificador=&dinicial=$_buscar&dfinal=$formatado');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  ObservableList<Ordem> ordens = ObservableList();

  for (var u in jsonData) {
    Ordem ordem = Ordem(
      u["id"],
      u['entrada_data'],
      u['entrada_hora'],
      u['id_empresa'],
      u['empresa_fantasia'],
      u['id_pessoa'],
      u['cliente_nome'],
      u['tecnico_id'],
      u['tecnico_nome'],
      u['identificador'],
      u['padrao_marca'],
      u['padrao_modelo'],
      u['veic_marca'],
      u['veic_modelo'],
      u['veic_cor'],
      u['veic_frota'],
      u['veic_chassi'],
      u['veic_km'],
      u['veic_ano'],
      u['veic_reboque1'],
      u['veic_reboque2'],
      u['veic_combustivel'],
      u['tot_geral_liquido'],
      u['tot_pecas_desc_vlr'],
      u['tot_servicos_desc_vlr'],
      u['tipo_os_nome'],
      u['situacao_nome'],
      u['status_nome'],
      u['defeito_reclamado'],
      u['defeito_constatado'],
      u['padrao_obs'],
      u['ck_antena'],
      u['ck_calotas'],
      u['ck_tapetes'],
      u['ck_radio'],
      u['ck_extintor'],
      u['ck_documentos'],
      u['ck_manual'],
      u['ck_chave_rodas'],
      u['ck_macaco'],
      u['ck_triangulo'],
      u['ck_triangulo_1'],
      u['ck_extra1'],
      u['ck_extra2'],
      u['ck_extra3'],
      u['ck_extra4'],
      u['ck_extra5'],
      u['ck_pneu_dd_bom'],
      u['ck_pneu_dd_reg'],
      u['ck_pneu_dd_rui'],
      u['ck_pneu_de_bom'],
      u['ck_pneu_de_reg'],
      u['ck_pneu_de_rui'],
      u['ck_pneu_td_bom'],
      u['ck_pneu_td_reg'],
      u['ck_pneu_td_rui'],
      u['ck_pneu_te_bom'],
      u['ck_pneu_te_reg'],
      u['ck_pneu_te_rui'],
      u['ck_pneu_est_bom'],
      u['ck_pneu_est_reg'],
      u['ck_pneu_est_rui'],
      u['ck_comb_1'],
      u['ck_comb_3_4'],
      u['ck_comb_1_2'],
      u['ck_comb_1_4'],
      u['ck_comb_0'],
      u['fpagto_id'],
      u['fpagto_descricao'],
    );
    ordens.add(ordem);
  }
  return ordens;
}
