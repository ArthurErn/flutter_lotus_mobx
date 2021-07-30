import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';

//ACESSORIOS/ADICIONAIS
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

var adicional1 = TextEditingController();
var adicional2 = TextEditingController();
var adicional3 = TextEditingController();
var adicional4 = TextEditingController();
var adicional5 = TextEditingController();

class CheckListOrdemOficina extends StatefulWidget {
  const CheckListOrdemOficina({Key key}) : super(key: key);

  @override
  _CheckListOrdemOficinaState createState() => _CheckListOrdemOficinaState();
}

class _CheckListOrdemOficinaState extends State<CheckListOrdemOficina> {
  @override
  void initState() {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.blue[900], Colors.blue])),
        ),
        title: Text("Checklist"),
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 825,
                decoration: BoxDecoration(
                    border: Border.all(width: .8, color: Colors.black)),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.blue[900]),
                      child: Center(
                        child: Text(
                          "ACESSÓRIOS / ADICIONAIS",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: antena,
                            onChanged: (valor) {
                              setState(() {
                                antena = valor;
                              });
                            }),
                        Text(
                          "Antena",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: calota,
                            onChanged: (valor) {
                              setState(() {
                                calota = valor;
                              });
                            }),
                        Text(
                          "Calota",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: tapetes,
                            onChanged: (valor) {
                              setState(() {
                                tapetes = valor;
                              });
                            }),
                        Text(
                          "Tapetes",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: radioCentralMultimedia,
                            onChanged: (valor) {
                              setState(() {
                                radioCentralMultimedia = valor;
                              });
                            }),
                        Text(
                          "Rádio / Central Multimédia",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: extintor,
                            onChanged: (valor) {
                              setState(() {
                                extintor = valor;
                              });
                            }),
                        Text(
                          "Extintor",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: documentos,
                            onChanged: (valor) {
                              setState(() {
                                documentos = valor;
                              });
                            }),
                        Text(
                          "Documentos",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: manual,
                            onChanged: (valor) {
                              setState(() {
                                manual = valor;
                              });
                            }),
                        Text(
                          "Manual",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: chaveRodas,
                            onChanged: (valor) {
                              setState(() {
                                chaveRodas = valor;
                              });
                            }),
                        Text(
                          "Chave Rodas",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: macaco,
                            onChanged: (valor) {
                              setState(() {
                                macaco = valor;
                              });
                            }),
                        Text(
                          "Macaco",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: triangulo,
                            onChanged: (valor) {
                              setState(() {
                                triangulo = valor;
                              });
                            }),
                        Text(
                          "Triângulo",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: .8, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: adicional1,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Inserir Adicional"),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: .8, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: adicional2,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Inserir Adicional"),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: .8, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: adicional3,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Inserir Adicional"),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: .8, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: adicional4,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Inserir Adicional"),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: .8, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: adicional5,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Inserir Adicional"),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 285,
                decoration: BoxDecoration(
                    border: Border.all(width: .8, color: Colors.black)),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.blue[900]),
                      child: Center(
                        child: Text(
                          "ESTADO DOS PNEUS",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "DD: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                            value: ddBom,
                            onChanged: (valor) {
                              setState(() {
                                ddBom = valor;
                                ddRegular = false;
                                ddRuim = false;
                              });
                            }),
                        Text(
                          "Bom",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: ddRegular,
                            onChanged: (valor) {
                              setState(() {
                                ddRegular = valor;
                                ddRuim = false;
                                ddBom = false;
                              });
                            }),
                        Text(
                          "Regular",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: ddRuim,
                            onChanged: (valor) {
                              setState(() {
                                ddRuim = valor;
                                ddBom = false;
                                ddRegular = false;
                              });
                            }),
                        Text(
                          "Ruim",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "DE: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                            value: deBom,
                            onChanged: (valor) {
                              setState(() {
                                deBom = valor;
                                deRuim = false;
                                deRegular = false;
                              });
                            }),
                        Text(
                          "Bom",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: deRegular,
                            onChanged: (valor) {
                              setState(() {
                                deRegular = valor;
                                deBom = false;
                                deRuim = false;
                              });
                            }),
                        Text(
                          "Regular",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: deRuim,
                            onChanged: (valor) {
                              setState(() {
                                deRuim = valor;
                                deRegular = false;
                                deBom = false;
                              });
                            }),
                        Text(
                          "Ruim",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TD: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                            value: tdBom,
                            onChanged: (valor) {
                              setState(() {
                                tdBom = valor;
                                tdRegular = false;
                                tdRuim = false;
                              });
                            }),
                        Text(
                          "Bom",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: tdRegular,
                            onChanged: (valor) {
                              setState(() {
                                tdRegular = valor;
                                tdRuim = false;
                                tdBom = false;
                              });
                            }),
                        Text(
                          "Regular",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: tdRuim,
                            onChanged: (valor) {
                              setState(() {
                                tdRuim = valor;
                                tdBom = false;
                                tdRegular = false;
                              });
                            }),
                        Text(
                          "Ruim",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TE: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                            value: teBom,
                            onChanged: (valor) {
                              setState(() {
                                teBom = valor;
                                teRuim = false;
                                teRegular = false;
                              });
                            }),
                        Text(
                          "Bom",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: teRegular,
                            onChanged: (valor) {
                              setState(() {
                                teRegular = valor;
                                teBom = false;
                                teRuim = false;
                              });
                            }),
                        Text(
                          "Regular",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: teRuim,
                            onChanged: (valor) {
                              setState(() {
                                teRuim = valor;
                                teBom = false;
                                teRegular = false;
                              });
                            }),
                        Text(
                          "Ruim",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "EST:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                            value: estBom,
                            onChanged: (valor) {
                              setState(() {
                                estBom = valor;
                                estRuim = false;
                                estRegular = false;
                              });
                            }),
                        Text(
                          "Bom",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: estRegular,
                            onChanged: (valor) {
                              setState(() {
                                estRegular = valor;
                                estBom = false;
                                estRuim = false;
                              });
                            }),
                        Text(
                          "Regular",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Checkbox(
                            value: estRuim,
                            onChanged: (valor) {
                              setState(() {
                                estRuim = valor;
                                estBom = false;
                                estRegular = false;
                              });
                            }),
                        Text(
                          "Ruim",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 290,
                decoration: BoxDecoration(
                    border: Border.all(width: .8, color: Colors.black)),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.blue[900]),
                      child: Center(
                        child: Text(
                          "COMBUSTÍVEL",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: combustivelUm,
                            onChanged: (valor) {
                              setState(() {
                                combustivelUm = valor;
                                combustivelTresQuartos = false;
                                combustivelUmMeio = false;
                                combustivelUmQuarto = false;
                                combustivelZero = false;
                              });
                            }),
                        Text(
                          "1",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: combustivelTresQuartos,
                            onChanged: (valor) {
                              setState(() {
                                combustivelTresQuartos = valor;
                                combustivelUm = false;
                                combustivelUmMeio = false;
                                combustivelUmQuarto = false;
                                combustivelZero = false;
                              });
                            }),
                        Text(
                          "3/4",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: combustivelUmMeio,
                            onChanged: (valor) {
                              setState(() {
                                combustivelUmMeio = valor;
                                combustivelUm = false;
                                combustivelTresQuartos = false;
                                combustivelUmQuarto = false;
                                combustivelZero = false;
                              });
                            }),
                        Text(
                          "1/2",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: combustivelUmQuarto,
                            onChanged: (valor) {
                              setState(() {
                                combustivelUmQuarto = valor;
                                combustivelUm = false;
                                combustivelTresQuartos = false;
                                combustivelUmMeio = false;
                                combustivelZero = false;
                              });
                            }),
                        Text(
                          "1/4",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: combustivelZero,
                            onChanged: (valor) {
                              setState(() {
                                combustivelZero = valor;
                                combustivelUm = false;
                                combustivelTresQuartos = false;
                                combustivelUmMeio = false;
                                combustivelUmQuarto = false;
                              });
                            }),
                        Text(
                          "0",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
