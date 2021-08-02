//PAGINA DE CADASTRO
//LAYOUT

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/clientes.controller.dart';
import 'package:lotus_erp/views/clientes/reset.fields.cadastro.dart';
import 'package:lotus_erp/repository/cadastro_clientes/cadastro_cliente_auth.dart';
import 'package:lotus_erp/views/clientes/layout/error_message.dart';

//CONTROLLER DOS CAMPOS

//CAMPOS ESCRITOS NA MÃO

class CadastroCliente extends StatefulWidget {
  const CadastroCliente({Key key}) : super(key: key);

  @override
  _CadastroClienteState createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  @override
  void initState() {
    ResetFieldCadastro().resetFieldCadastro();
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
                                      controller: clientes.nomeRazao,
                                      onChanged: (value) =>
                                          clientes.nomeRazaoText = value,
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
                                            controller: clientes.cnpj,
                                            onChanged: (value) {
                                              setState(() {
                                                clientes.cnpjText = value;
                                              });
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                clientes.fillCNPJ(context);
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
                      Observer(builder: (_) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border(
                                top: BorderSide(width: 1, color: Colors.black),
                                bottom:
                                    BorderSide(width: 1, color: Colors.black),
                                left: BorderSide(width: 1, color: Colors.black),
                                right:
                                    BorderSide(width: 1, color: Colors.black),
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
                              controller: clientes.apelidoFantasia,
                              onChanged: (value) =>
                                  clientes.apelidoFantasiaText = value,
                            ),
                          ),
                        );
                      }),
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
                              Observer(builder: (_) {
                                return Container(
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
                                    controller: clientes.cep,
                                    onChanged: (value) =>
                                        clientes.cepText = value,
                                  ),
                                );
                              }),
                              Observer(builder: (_) {
                                return IconButton(
                                    onPressed: () {
                                      setState(() {
                                        clientes.fillCEP(context);
                                      });
                                      
                                    },
                                    icon: Icon(Icons.more_horiz));
                              })
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
                                            Observer(builder: (_) {
                                              return TextField(
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
                                                controller: clientes.logradouro,
                                                onChanged: (value) => clientes
                                                    .logradouroText = value,
                                              );
                                            }),
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
                                            Observer(builder: (_) {
                                              return TextField(
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
                                                controller: clientes.numero,
                                                onChanged: (value) =>
                                                    clientes.numeroText = value,
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
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
                                            Observer(builder: (_) {
                                              return TextField(
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
                                                controller: clientes.bairro,
                                                onChanged: (value) =>
                                                    clientes.bairroText = value,
                                              );
                                            }),
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
                                    Observer(builder: (_) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                                controller: clientes.complemento,
                                                onChanged: (value) => clientes
                                                    .complementoText = value,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Observer(builder: (_) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.black),
                                                right: BorderSide(
                                                    width: 1,
                                                    color: Colors.black))),
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                            controller: clientes.rgInsc,
                                            onChanged: (value) =>
                                                clientes.rgInscText = value,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Observer(builder: (_) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.black))),
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                            controller: clientes.telefone,
                                            onChanged: (value) =>
                                                clientes.telefoneText = value,
                                          ),
                                        ),
                                      );
                                    }),
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
                                    controller: clientes.email,
                                    onChanged: (value) =>
                                        clientes.emailText = value,
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
                                if (clientes.cepText == null ||
                                    clientes.cepText == "" ||
                                    clientes.nomeRazaoText == null ||
                                    clientes.nomeRazaoText == "" ||
                                    clientes.logradouroText == null ||
                                    clientes.logradouroText == "" ||
                                    clientes.numeroText == null ||
                                    clientes.numeroText == "" ||
                                    clientes.bairroText == null ||
                                    clientes.bairroText == "") {
                                  errorCampos(context);
                                } else {
                                  if (clientes.cnpjText == null ||
                                      clientes.cnpjText == "") {
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
