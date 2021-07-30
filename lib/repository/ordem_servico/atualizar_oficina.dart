import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/repository/login/login_auth.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/ordem_servico/adicionar_produto.dart';
import 'package:lotus_erp/pages/ordem_servico/checklist.dart';
import 'package:lotus_erp/pages/ordem_servico/editar_os.dart';
import 'package:lotus_erp/pages/ordem_servico/produtos_servico.dart';

Future postEditOficina() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var indexSelecionado = tipoOs.indexOf(selecionadoOS);
  var situacaoOS = situacao.indexOf(selecionado2);
  var combust = combustivel.indexOf(combustivelSelecionado);
  var tot_geral_bruto = (totalProdutosOrdem + totalServicoOrdem);
  var ck_antena = antena == true ? 1 : 0;
  var ck_calotas = calota == true ? 1 : 0;
  var ck_tapetes = tapetes == true ? 1 : 0;
  var ck_radio = radioCentralMultimedia == true ? 1 : 0;
  var ck_extintor = extintor == true ? 1 : 0;
  var ck_documentos = documentos == true ? 1 : 0;
  var ck_manual = manual == true ? 1 : 0;
  var ck_chave_rodas = chaveRodas == true ? 1 : 0;
  var ck_macaco = macaco == true ? 1 : 0;
  var ck_triangulo = triangulo == true ? 1 : 0;
  var tot_pecas_desc_vlr = descontoProdutoController.text != ""
      ? double.parse(descontoProdutoController.text)
      : 0;
  var tot_servicos_desc_vlr = descontoServicoController.text != ""
      ? double.parse(descontoServicoController.text)
      : 0;
  var selecionadoVendaa = fpagtoId;
  var jsonProduto = jsonEncode({
    "tipo_servico": indexSelecionado,
    "situacao_os": situacaoOS,
    "veic_combustivel": combust,
    "veic_marca": controllerMarca.text.toUpperCase(),
    "veic_modelo": controllerModelo.text.toUpperCase(),
    "veic_cor": controllerCor.text.toUpperCase(),
    "veic_frota": controllerFrota.text.toUpperCase(),
    "veic_chassi": controllerChassi.text.toUpperCase(),
    "veic_km": double.parse(controllerKm.text),
    "veic_ano": double.parse(controllerAno.text),
    "veic_placa_rebo1": controllerReboque1.text,
    "veic_placa_rebo2": controllerReboque2.text,
    "tot_pecas_bru": totalProdutosOrdem,
    "tot_pecas_desc_prc":
        porcentagemOrdemProduto == null ? 0 : porcentagemOrdemProduto,
    "tot_pecas_desc_vlr": tot_pecas_desc_vlr,
    "tot_pecas_liq": totalLiquidoProdutos,
    "tot_servicos_bru": totalServicoOrdem,
    "tot_servicos_desc_prc":
        porcentagemOrdemServico == null ? 0 : porcentagemOrdemServico,
    "tot_servicos_desc_vlr": tot_servicos_desc_vlr,
    "tot_servicos_liq": totalLiquidoServico,
    "tot_geral_bruto": tot_geral_bruto,
    "tot_geral_desc_prc": 0,
    "tot_geral_desc_valor": 0,
    "tot_geral_liquido": (totalLiquidoProdutos + totalLiquidoServico),
    "id_pessoa": ordemIdPessoaSave == null ? ordemIdPessoa : ordemIdPessoaSave,
    "id_atendente": idColaborador,
    "defeito_reclamado": reclamacaoDefeito.text.toUpperCase(),
    "defeito_constatado": constatadoResolvido.text.toUpperCase(),
    "padrao_obs": obsOcorrencias.text.toUpperCase(),
    "ck_antena": ck_antena,
    "ck_calotas": ck_calotas,
    "ck_tapetes": ck_tapetes,
    "ck_radio": ck_radio,
    "ck_extintor": ck_extintor,
    "ck_documentos": ck_documentos,
    "ck_manual": ck_manual,
    "ck_chave_rodas": ck_chave_rodas,
    "ck_macaco": ck_macaco,
    "ck_triangulo": ck_triangulo,
    "ck_extra1": adicional1.text.toUpperCase(),
    "ck_extra2": adicional2.text.toUpperCase(),
    "ck_extra3": adicional3.text.toUpperCase(),
    "ck_extra4": adicional4.text.toUpperCase(),
    "ck_extra5": adicional5.text.toUpperCase(),
    "ck_pneu_dd_bom": ddBom == true ? 1 : 0,
    "ck_pneu_dd_reg": ddRegular == true ? 1 : 0,
    "ck_pneu_dd_rui": ddRuim == true ? 1 : 0,
    "ck_pneu_de_bom": deBom == true ? 1 : 0,
    "ck_pneu_de_reg": deRegular == true ? 1 : 0,
    "ck_pneu_de_rui": deRuim == true ? 1 : 0,
    "ck_pneu_td_bom": tdBom == true ? 1 : 0,
    "ck_pneu_td_reg": tdRegular == true ? 1 : 0,
    "ck_pneu_td_rui": tdRuim == true ? 1 : 0,
    "ck_pneu_te_bom": teBom == true ? 1 : 0,
    "ck_pneu_te_reg": teRegular == true ? 1 : 0,
    "ck_pneu_te_rui": teRuim == true ? 1 : 0,
    "ck_pneu_est_bom": estBom == true ? 1 : 0,
    "ck_pneu_est_reg": estRegular == true ? 1 : 0,
    "ck_pneu_est_rui": estRuim == true ? 1 : 0,
    "ck_comb_1": combustivelUm == true ? 1 : 0,
    "ck_comb_3_4": combustivelTresQuartos == true ? 1 : 0,
    "ck_comb_1_2": combustivelUmMeio == true ? 1 : 0,
    "ck_comb_1_4": combustivelUmQuarto == true ? 1 : 0,
    "ck_comb_0": combustivelZero == true ? 1 : 0,
    "id_formapagto": fpagtoId,
    "id_os": ordemId
  });

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse('http://$_ip/mobile/os_oficina_atualizar');
  var data = await http.post(
    url,
    headers: <String, String>{'authorization': basicAuth},
    body: jsonProduto,
  );
  if (data.statusCode == 200) {
    final String dataString = data.body;
    print(dataString);
    return null;
  } else {
    print('erro');
    return null;
  }
}
