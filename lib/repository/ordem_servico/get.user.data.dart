import 'package:flutter/material.dart';
import 'package:lotus_erp/controllers/ordem_oficina_controller.dart';
import 'package:lotus_erp/pages/ordem_servico/alocar_tecnico.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';
import 'package:lotus_erp/pages/ordem_servico/produtos_servico.dart';

var indice;

var identificadorControllerAdd = TextEditingController();
var buscarController = TextEditingController();
var ordemId;
var ordemStatusNome;
var ordemClienteNome;
var ordemIdentificador;
var ordemTecnicoNome;
var ordemTotGeralLiquido;
var descontoServico;
var descontoProdutos;
var ordemIndex;
var ordemIdPessoa;
var ordemEntradaData;
var ordemEntradaHora;
var ordemIdEmpresa;
var ordemEmpresaFantasia;
var ordemTecnicoId;
var ordemPadraoMarca;
var ordemPadraoModelo;
var ordemVeicMarca;
var ordemVeicModelo;
var ordemVeicCor;
var ordemVeicFrota;
var ordemVeicChassi;
var ordemVeicKm;
var ordemVeicAno;
var ordemVeicReboque1;
var ordemVeicReboque2;
var ordemVeicCombustivel;
var ordemTipoOsNome;
var ordemSituacaoNome;
var ordemDefeitoReclamado;
var ordemDefeitoConstado;
var ordemPadraoObs;
var ckAntenas;
var ckCalotas;
var ckTapetes;
var ckRadio;
var ckExtintor;
var ckDocumentos;
var ckManual;
var ckChaveRodas;
var ckMacaco;
var ckTriangulo;
var ckTriangulo1;
var ckExtra1;
var ckExtra2;
var ckExtra3;
var ckExtra4;
var ckExtra5;
var ckPneuDdBom;
var ckPneuDdReg;
var ckPneuDdRui;
var ckPneuDeBom;
var ckPneuDeReg;
var ckPneuDeRui;
var ckPneuTdBom;
var ckPneuTdReg;
var ckPneuTdRui;
var ckPneuTeBom;
var ckPneuTeReg;
var ckPneuTeRui;
var ckPneuEstBom;
var ckPneuEstReg;
var ckPneuEstRui;
var ckCombo1;
var ckCombo34;
var ckCombo12;
var ckCombo14;
var ckCombo0;
var fpagtoId;
var fpagtoDescricao;
class UserData {
  
  get() {
    listaProdutoOS.clear();
    tecnicos.clear();
    ordemStatusNome = oficina.ordemDisplay[indice].statusNome;
    ordemId = oficina.ordemDisplay[indice].id;
    ordemEntradaData = oficina.ordemDisplay[indice].entradaData;
    ordemEntradaHora = oficina.ordemDisplay[indice].entradaHora;
    ordemIdEmpresa = oficina.ordemDisplay[indice].idEmpresa;
    ordemEmpresaFantasia = oficina.ordemDisplay[indice].empresaFantasia;
    ordemIdPessoa = oficina.ordemDisplay[indice].idPessoa;
    ordemClienteNome = oficina.ordemDisplay[indice].clienteNome;
    ordemTecnicoId = oficina.ordemDisplay[indice].tecnicoId;
    ordemTecnicoNome = oficina.ordemDisplay[indice].tecnicoNome;
    ordemIdentificador = oficina.ordemDisplay[indice].identificador;
    ordemPadraoMarca = oficina.ordemDisplay[indice].padraoMarca;
    ordemPadraoModelo = oficina.ordemDisplay[indice].padraoModelo;
    ordemVeicMarca = oficina.ordemDisplay[indice].veicMarca;
    ordemVeicModelo = oficina.ordemDisplay[indice].veicModelo;
    ordemVeicCor = oficina.ordemDisplay[indice].veicCor;
    ordemVeicFrota = oficina.ordemDisplay[indice].veicFrota;
    ordemVeicChassi = oficina.ordemDisplay[indice].veicChassi;
    ordemVeicKm = oficina.ordemDisplay[indice].veicKm;
    ordemVeicAno = oficina.ordemDisplay[indice].veicAno;
    ordemVeicReboque1 = oficina.ordemDisplay[indice].veicReboque1;
    ordemVeicReboque2 = oficina.ordemDisplay[indice].veicReboque2;
    ordemVeicCombustivel = oficina.ordemDisplay[indice].veicCombustivel;

    ordemTotGeralLiquido = oficina.ordemDisplay[indice].totGeralLiquido;
    descontoServico = oficina.ordemDisplay[indice].totServicosDescVlr;
    descontoProdutos = oficina.ordemDisplay[indice].totPecasDescVlr;
    ordemTipoOsNome = oficina.ordemDisplay[indice].tipoOsNome;
    ordemSituacaoNome = oficina.ordemDisplay[indice].situacaoNome;
    ordemStatusNome = oficina.ordemDisplay[indice].statusNome;
    ordemDefeitoReclamado = oficina.ordemDisplay[indice].defeitoReclamado;
    ordemDefeitoConstado = oficina.ordemDisplay[indice].defeitoConstatado;
    ordemPadraoObs = oficina.ordemDisplay[indice].padraoObs;

    ckAntenas = oficina.ordemDisplay[indice].ckAntena;
    ckCalotas = oficina.ordemDisplay[indice].ckCalotas;
    ckTapetes = oficina.ordemDisplay[indice].ckTapetes;
    ckRadio = oficina.ordemDisplay[indice].ckRadio;
    ckExtintor = oficina.ordemDisplay[indice].ckExtintor;
    ckDocumentos = oficina.ordemDisplay[indice].ckDocumentos;
    ckManual = oficina.ordemDisplay[indice].ckManual;
    ckChaveRodas = oficina.ordemDisplay[indice].ckChaveRodas;
    ckMacaco = oficina.ordemDisplay[indice].ckMacaco;
    ckTriangulo = oficina.ordemDisplay[indice].ckTriangulo;
    ckTriangulo1 = oficina.ordemDisplay[indice].ckTriangulo1;

    ckExtra1 = oficina.ordemDisplay[indice].ckExtra1;
    ckExtra2 = oficina.ordemDisplay[indice].ckExtra2;
    ckExtra3 = oficina.ordemDisplay[indice].ckExtra3;
    ckExtra4 = oficina.ordemDisplay[indice].ckExtra4;
    ckExtra5 = oficina.ordemDisplay[indice].ckExtra5;

    ckPneuDdBom = oficina.ordemDisplay[indice].ckPneuDdBom;
    ckPneuDdReg = oficina.ordemDisplay[indice].ckPneuDdReg;
    ckPneuDdRui = oficina.ordemDisplay[indice].ckPneuDdRui;

    ckPneuDeBom = oficina.ordemDisplay[indice].ckPneuDeBom;
    ckPneuDeReg = oficina.ordemDisplay[indice].ckPneuDeReg;
    ckPneuDeRui = oficina.ordemDisplay[indice].ckPneuDeRui;

    ckPneuTdBom = oficina.ordemDisplay[indice].ckPneuTdBom;
    ckPneuTdReg = oficina.ordemDisplay[indice].ckPneuTdReg;
    ckPneuTdRui = oficina.ordemDisplay[indice].ckPneuTdRui;

    ckPneuTeBom = oficina.ordemDisplay[indice].ckPneuTeBom;
    ckPneuTeReg = oficina.ordemDisplay[indice].ckPneuTeReg;
    ckPneuTeRui = oficina.ordemDisplay[indice].ckPneuTeRui;

    ckPneuEstBom = oficina.ordemDisplay[indice].ckPneuEstBom;
    ckPneuEstReg = oficina.ordemDisplay[indice].ckPneuEstReg;
    ckPneuEstRui = oficina.ordemDisplay[indice].ckPneuEstRui;

    ckCombo1 = oficina.ordemDisplay[indice].ckComb1;
    ckCombo34 = oficina.ordemDisplay[indice].ckComb34;
    ckCombo12 = oficina.ordemDisplay[indice].ckComb12;
    ckCombo14 = oficina.ordemDisplay[indice].ckComb14;
    ckCombo0 = oficina.ordemDisplay[indice].ckComb0;

    fpagtoId = oficina.ordemDisplay[indice].fpagtoId != null
        ? oficina.ordemDisplay[indice].fpagtoId
        : 1;
    fpagtoDescricao = oficina.ordemDisplay[indice].fpagtoDescricao;

    ordemIndex = indice;
  }
}
