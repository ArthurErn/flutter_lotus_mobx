import 'package:flutter/material.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';


var adicional1 = TextEditingController();
var adicional2 = TextEditingController();
var adicional3 = TextEditingController();
var adicional4 = TextEditingController();
var adicional5 = TextEditingController();

bool antena = false;
bool calota = false;
bool tapetes = false;
bool radioCentralMultimedia = false;
bool extintor = false;
bool documentos = false;
bool manual = false;
bool chaveRodas = false;
bool macaco = false;
bool triangulo = false;

//ESTADO DOS PNEUS
bool ddBom = false;
bool ddRegular = false;
bool ddRuim = false;

bool deBom = false;
bool deRegular = false;
bool deRuim = false;

bool tdBom = false;
bool tdRegular = false;
bool tdRuim = false;

bool teBom = false;
bool teRegular = false;
bool teRuim = false;

bool estBom = false;
bool estRegular = false;
bool estRuim = false;

//COMBUSTIVEL
bool combustivelUm = false;
bool combustivelTresQuartos = false;
bool combustivelUmMeio = false;
bool combustivelUmQuarto = false;
bool combustivelZero = false;

class PersistChecklist {
  get() {
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

    adicional1 = TextEditingController(text: ckExtra1);
    adicional2 = TextEditingController(text: ckExtra2);
    adicional3 = TextEditingController(text: ckExtra3);
    adicional4 = TextEditingController(text: ckExtra4);
    adicional5 = TextEditingController(text: ckExtra5);

  }
}
