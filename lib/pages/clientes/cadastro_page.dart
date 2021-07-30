//PAGINA DE CADASTRO
//LAYOUT

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotus_erp/repository/cadastro_clientes/cadastro_cliente_auth.dart';
import 'package:lotus_erp/repository/cadastro_clientes/cep_auth.dart';
import 'package:lotus_erp/repository/cadastro_clientes/cnpj_auth.dart';
import 'package:lotus_erp/repository/cadastro_clientes/municipio_auth.dart';
import 'package:lotus_erp/pages/clientes/layout/error_message.dart';

//CONTROLLER DOS CAMPOS
TextEditingController nomeRazao;
TextEditingController apelidoFantasia;
TextEditingController cnpj;
TextEditingController rgInsc;
TextEditingController telefone;
TextEditingController email;
TextEditingController logradouro;
TextEditingController numero;
TextEditingController bairro;
TextEditingController complemento;
TextEditingController cep;

//CAMPOS ESCRITOS NA MÃO
var cnpjText = cnpj.text;
var cepText = cep.text;
var nomeRazaoText = nomeRazao.text;
var apelidoFantasiaText = apelidoFantasia.text;
var rgInscText = rgInsc.text;
var telefoneText = telefone.text;
var emailText = email.text;
var logradouroText = logradouro.text;
var numeroText = numero.text;
var bairroText = bairro.text;
var complementoText = complemento.text;

//CAMPOS RESGATADOS POR API
var cepField;
var logradouroField;
var municipioId;
var numeroField;
var bairroField;
var complementoField;
var ibge;

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({Key key}) : super(key: key);

  @override
  _CadastroClienteState createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  @override
  void initState() {
    nomeRazao = TextEditingController(text: "");
    apelidoFantasia = TextEditingController(text: "");
    cnpj = TextEditingController(text: "");
    rgInsc = TextEditingController(text: "");
    telefone = TextEditingController(text: "");
    email = TextEditingController(text: "");
    logradouro = TextEditingController(text: "");
    numero = TextEditingController(text: "");
    bairro = TextEditingController(text: "");
    complemento = TextEditingController(text: "");
    cep = TextEditingController(text: "");

    nomeRazaoText = "";
    cepText = "";
    cnpjText = "";
    apelidoFantasiaText = "";
    rgInscText = "";
    telefoneText = "";
    emailText = "";
    logradouroText = "";
    numeroText = "";
    bairroText = "";
    complementoText = "";
    ibge = "";

    cepField = null;
    logradouroField = null;
    numeroField = null;
    bairroField = null;
    complementoField = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      decoration: BoxDecoration(
        //BACKGROUND COM OPACIDADE
        color: Color(0xff7c94b6),
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.dstATop),
          image: AssetImage(
            'lib/assets/images/background.png',
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Colors.blue[900], Colors.blue])),
              ),
            toolbarHeight: 65,
            title: Text("Dados do cliente"),
            backgroundColor: Colors.blue[900]),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border(
                      right: BorderSide(width: 1, color: Colors.black),
                      top: BorderSide(width: 1, color: Colors.black),
                      left: BorderSide(width: 1, color: Colors.black),
                      bottom: BorderSide(width: 1, color: Colors.black),
                    )),
                width: MediaQuery.of(context).size.width / 1.1 + 10,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0.5),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(width: 1, color: Colors.black),
                            bottom: BorderSide(width: 1, color: Colors.black),
                            left: BorderSide(width: 1, color: Colors.black),
                            right: BorderSide(width: 1, color: Colors.black),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border(
                                        top: BorderSide(
                                            width: 1, color: Colors.black),
                                        bottom: BorderSide(
                                            width: 1, color: Colors.black),
                                        left: BorderSide(
                                            width: 1, color: Colors.black),
                                        right: BorderSide(
                                            width: 1, color: Colors.black),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextField(
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Nome Razão",
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                      controller: nomeRazao,
                                      onChanged: (value) =>
                                          nomeRazaoText = value,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.black),
                                        left: BorderSide(
                                            width: 1, color: Colors.black),
                                        right: BorderSide(
                                            width: 1, color: Colors.black),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 60,
                                          child: TextField(
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "CNPJ/CPF",
                                                labelStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            controller: cnpj,
                                            onChanged: (value) {
                                              setState(() {
                                                cnpjText = value;
                                              });
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              getCNPJ().then((value) {
                                                setState(() {
                                                  cnpjs = value;
                                                  if (cnpjs == null) {
                                                    errorCNPJvazio(context);
                                                  } else {
                                                    cepText = value[0].cep;
                                                    cep = TextEditingController(
                                                        text: cepText);
                                                    if (cepText == null) {
                                                      errorCNPJInput(context);
                                                    } else {
                                                      //EXPRESSAO REGULAR PRA TIRAR "." E "-" DO CEP
                                                      cepText = cepText
                                                          .replaceAll(".", "");
                                                      cepText = cepText
                                                          .replaceAll("-", "");

                                                      //ARMAZENANDO VALORES NAS VARIAVEIS PRA FICAR MAIS FACIL DE LER O CADASTRO

                                                      logradouroText =
                                                          value[0].logradouro;
                                                      logradouro =
                                                          TextEditingController(
                                                              text:
                                                                  logradouroText);
                                                      numeroText =
                                                          value[0].numero;
                                                      numero =
                                                          TextEditingController(
                                                              text: numeroText);
                                                      bairroText =
                                                          value[0].bairro;
                                                      bairro =
                                                          TextEditingController(
                                                              text: bairroText);
                                                      complementoText =
                                                          value[0].complemento;
                                                      complemento =
                                                          TextEditingController(
                                                              text:
                                                                  complementoText);

                                                      //PEGA O IBGE PARA PREENCHER ID DO MUNICIPIO
                                                      getIBGE().then((value) {
                                                        ibge = value;

                                                        //CONFIRMAÇÃO DO MUNICIPIO
                                                        getMunicipio()
                                                            .then((value) {
                                                          setState(() {
                                                            municipioId = value[
                                                                    0]
                                                                .municipioId;
                                                          });
                                                        });
                                                      });
                                                    }
                                                  }
                                                });
                                              });
                                            },
                                            icon: Icon(Icons.more_horiz))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border(
                              top: BorderSide(width: 1, color: Colors.black),
                              bottom: BorderSide(width: 1, color: Colors.black),
                              left: BorderSide(width: 1, color: Colors.black),
                              right: BorderSide(width: 1, color: Colors.black),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Apelido Fantasia",
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.normal)),
                            controller: apelidoFantasia,
                            onChanged: (value) => apelidoFantasiaText = value,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border(
                              top: BorderSide(width: 1, color: Colors.black),
                              bottom: BorderSide(width: 1, color: Colors.black),
                              left: BorderSide(width: 1, color: Colors.black),
                              right: BorderSide(width: 1, color: Colors.black),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                height: 60,
                                child: TextField(
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "CEP",
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.normal)),
                                  controller: cep,
                                  onChanged: (value) => cepText = value,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cepText = cepText.replaceAll(".", "");
                                    cepText = cepText.replaceAll("-", "");
                                    getIBGE().then((value) {
                                      ibge = value;
                                      //CONFIRMAÇÃO DO MUNICIPIO
                                      getMunicipio().then((value) {
                                        setState(() {
                                          municipioId = value[0].municipioId;
                                          logradouro = TextEditingController(
                                              text: logradouroText);
                                          bairro = TextEditingController(
                                              text: bairroText);
                                          complemento = TextEditingController(
                                              text: complementoText);
                                        });
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.more_horiz))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border(
                              top: BorderSide(width: 1, color: Colors.black),
                              bottom: BorderSide(width: 1, color: Colors.black),
                              left: BorderSide(width: 1, color: Colors.black),
                              right: BorderSide(width: 1, color: Colors.black),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.2275,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.black),
                                        right: BorderSide(
                                            width: 1, color: Colors.black),
                                      )),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextField(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Logradouro",
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              controller: logradouro,
                                              onChanged: (value) =>
                                                  logradouroText = value,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.234,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.black),
                                      )),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextField(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Numero",
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              controller: numero,
                                              onChanged: (value) =>
                                                  numeroText = value,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.2275,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.black),
                                        right: BorderSide(
                                            width: 1, color: Colors.black),
                                      )),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextField(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Bairro",
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              controller: bairro,
                                              onChanged: (value) =>
                                                  bairroText = value,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.234,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.black),
                                      )),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextField(
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Complemento",
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                              controller: complemento,
                                              onChanged: (value) =>
                                                  complementoText = value,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  width: 1,
                                                  color: Colors.black))),
                                      width: MediaQuery.of(context).size.width /
                                          2.2275,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: "RG insc",
                                              labelStyle: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          controller: rgInsc,
                                          onChanged: (value) =>
                                              rgInscText = value,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Colors.black))),
                                      width: MediaQuery.of(context).size.width /
                                          2.234,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: "Telefone",
                                              labelStyle: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          controller: telefone,
                                          onChanged: (value) =>
                                              telefoneText = value,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: "E-mail",
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    controller: email,
                                    onChanged: (value) => emailText = value,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1, color: Colors.black),
                                bottom:
                                    BorderSide(width: 1, color: Colors.black),
                                left: BorderSide(width: 1, color: Colors.black),
                                right:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              color: Colors.yellow[600]),
                          child: FlatButton(
                              onPressed: () {
                                if (cepText == null ||
                                    cepText == "" ||
                                    nomeRazaoText == null ||
                                    nomeRazaoText == "" ||
                                    logradouroText == null ||
                                    logradouroText == "" ||
                                    numeroText == null ||
                                    numeroText == "" ||
                                    bairroText == null ||
                                    bairroText == "") {
                                  errorCampos(context);
                                } else {
                                  if (cnpjText == null || cnpjText == "") {
                                    errorCNPJvazio(context);
                                  } else {
                                    postUsuario();
                                  }
                                }
                              },
                              child: Text('CADASTRAR CLIENTE')),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
