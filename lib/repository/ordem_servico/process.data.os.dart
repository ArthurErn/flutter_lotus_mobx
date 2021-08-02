import 'package:flutter/material.dart';
import 'package:lotus_erp/views/ordem_servico/adicionar_produto.dart';
import 'package:lotus_erp/views/ordem_servico/editar_os.dart';
import 'package:lotus_erp/repository/ordem_servico/persist.checklist.dart';
import 'package:lotus_erp/views/ordem_servico/produtos_servico.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';

class ProcessedData {
  dataProcess() {
    antena = ckAntenas == 1 ? true : false;
    calota = ckCalotas == 1 ? true : false;
    tapetes = ckTapetes == 1 ? true : false;
    radioCentralMultimedia = ckRadio == 1 ? true : false;
    extintor = ckExtintor == 1 ? true : false;
    documentos = ckDocumentos == 1 ? true : false;
    manual = ckManual == 1 ? true : false;
    chaveRodas = ckChaveRodas == 1 ? true : false;
    macaco = ckMacaco == 1 ? true : false;
    triangulo = ckTriangulo == 1 ? true : false;

    adicional1 = TextEditingController(text: ckExtra1);
    adicional2 = TextEditingController(text: ckExtra2);
    adicional3 = TextEditingController(text: ckExtra3);
    adicional4 = TextEditingController(text: ckExtra4);
    adicional5 = TextEditingController(text: ckExtra5);

    ddBom = ckPneuDdBom == 1 ? true : false;
    ddRegular = ckPneuDdReg == 1 ? true : false;
    ddRuim = ckPneuDdRui == 1 ? true : false;

    deBom = ckPneuDeBom == 1 ? true : false;
    deRegular = ckPneuDeReg == 1 ? true : false;
    deRuim = ckPneuDeRui == 1 ? true : false;

    tdBom = ckPneuTdBom == 1 ? true : false;
    tdRegular = ckPneuTdReg == 1 ? true : false;
    tdRuim = ckPneuTdRui == 1 ? true : false;

    teBom = ckPneuTeBom == 1 ? true : false;
    teRegular = ckPneuTeReg == 1 ? true : false;
    teRuim = ckPneuTeRui == 1 ? true : false;

    estBom = ckPneuEstBom == 1 ? true : false;
    estRegular = ckPneuEstReg == 1 ? true : false;
    estRuim = ckPneuEstRui == 1 ? true : false;

    combustivelUm = ckCombo1 == 1 ? true : false;
    combustivelTresQuartos = ckCombo34 == 1 ? true : false;
    combustivelUmMeio = ckCombo12 == 1 ? true : false;
    combustivelUmQuarto = ckCombo14 == 1 ? true : false;
    combustivelZero = ckCombo0 == 1 ? true : false;
    reclamacaoDefeito = TextEditingController(text: ordemDefeitoReclamado);
    constatadoResolvido = TextEditingController(text: ordemDefeitoConstado);
    obsOcorrencias = TextEditingController(text: ordemPadraoObs);
    listaProdutoOS = [];
    quantidadeLista = [];

    //VALOR INICIAL DOS DROPDOWN BUTTONS
    selecionadoOS = ordemTipoOsNome;
    selecionado2 = ordemSituacaoNome;
    combustivelSelecionado = combustivel[ordemVeicCombustivel];

    //VALOR INICIAL DOS TEXTFIELDS
    identificadorController.text = ordemIdentificador;
    controllerMarca.text = ordemVeicMarca;
    controllerModelo.text = ordemVeicModelo;
    controllerCor.text = ordemVeicCor;
    controllerFrota.text = ordemVeicFrota;
    controllerChassi.text = ordemVeicChassi;
    controllerKm.text = ordemVeicKm != null ? ordemVeicKm.toString() : '0';
    controllerAno.text = ordemVeicAno != null ? ordemVeicAno.toString() : '0';
    controllerReboque1.text =
        ordemVeicReboque1 != null ? ordemVeicReboque1.toString() : "";
    controllerReboque2.text =
        ordemVeicReboque2 != null ? ordemVeicReboque2.toString() : "";
  }
}
