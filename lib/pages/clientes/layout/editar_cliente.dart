import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotus_erp/pages/clientes/funct.editar.dart';
import 'package:lotus_erp/repository/cadastro_clientes/municipio_auth.dart';
import 'package:lotus_erp/repository/clientes/cep_edit_auth.dart';
import 'package:lotus_erp/repository/clientes/cnpj_edit_auth.dart';
import 'package:lotus_erp/repository/clientes/get.cliente.data.dart';
import 'package:lotus_erp/repository/clientes/get.cliente.edit.data.dart';
import 'package:lotus_erp/repository/clientes/post_edit_cliente_auth.dart';
import 'package:lotus_erp/pages/clientes/cadastro_page.dart';
import 'package:lotus_erp/pages/clientes/clientes_page.dart';
import 'package:lotus_erp/pages/clientes/layout/error_message.dart';
import 'package:asuka/asuka.dart' as asuka;

class EditarClientes extends StatefulWidget {
  const EditarClientes({Key key}) : super(key: key);

  @override
  _EditarClientesState createState() => _EditarClientesState();
}

class _EditarClientesState extends State<EditarClientes> {
  @override
  void initState() {
    setState(() {
      //TRAZER O CONTEUDO DOS CAMPOS
      ClienteDataEdit().get();
    });
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
          backgroundColor: Colors.blue[900],
        ),
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
                                      controller: nomeRazaoEdit,
                                      onChanged: (value) =>
                                          nomeRazaoEditText = value,
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
                                          height: 60,
                                          width: 200,
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
                                            controller: cnpjEdit,
                                            onChanged: (value) {
                                              setState(() {
                                                cnpjEditText = value;
                                              });
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              getEditCNPJ().then((value) {
                                                setState(() {
                                                  cnpjsEdit = value;
                                                  if (cnpjsEdit == null) {
                                                    errorCNPJvazio(context);
                                                  } else {
                                                    cepEditText = value[0].cep;
                                                    cepEdit =
                                                        TextEditingController(
                                                            text: cepEditText);
                                                    if (cepEditText == null) {
                                                      errorCNPJInput(context);
                                                    } else {
                                                      //EXPRESSAO REGULAR PRA TIRAR "." E "-" DO CEP
                                                      cepEditText = cepEditText
                                                          .replaceAll(".", "");
                                                      cepEditText = cepEditText
                                                          .replaceAll("-", "");

                                                      //ARMAZENANDO VALORES NAS VARIAVEIS PRA FICAR MAIS FACIL DE LER O CADASTRO

                                                      logradouroEditText =
                                                          value[0].logradouro;
                                                      logradouroEdit =
                                                          TextEditingController(
                                                              text:
                                                                  logradouroEditText);
                                                      numeroEditText =
                                                          value[0].numero;
                                                      numeroEdit =
                                                          TextEditingController(
                                                              text:
                                                                  numeroEditText);
                                                      bairroEditText =
                                                          value[0].bairro;
                                                      bairroEdit =
                                                          TextEditingController(
                                                              text:
                                                                  bairroEditText);
                                                      complementoEditText =
                                                          value[0].complemento;
                                                      complementoEdit =
                                                          TextEditingController(
                                                              text:
                                                                  complementoEditText);
                                                      //PEGA O IBGE PARA PREENCHER ID DO MUNICIPIO
                                                      getEditIBGE()
                                                          .then((value) {
                                                        ibge = value;

                                                        //CONFIRMAÇÃO DO MUNICIPIO
                                                        getMunicipio()
                                                            .then((value) {
                                                          setState(() {
                                                            municipioEditId =
                                                                value[0]
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
                            controller: apelidoFantasiaEdit,
                            onChanged: (value) =>
                                apelidoFantasiaEditText = value,
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
                                  controller: cepEdit,
                                  onChanged: (value) => cepEditText = value,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      cepEditText =
                                          cepEditText.replaceAll(".", "");
                                      cepEditText =
                                          cepEditText.replaceAll("-", "");
                                      getEditIBGE().then((value) {
                                        ibge = value;
                                        //CONFIRMAÇÃO DO MUNICIPIO
                                        getMunicipio().then((value) {
                                          setState(() {
                                            municipioEditId =
                                                value[0].municipioId;
                                            logradouroEdit =
                                                TextEditingController(
                                                    text: logradouroEditText);
                                            bairroEdit = TextEditingController(
                                                text: bairroEditText);
                                            complementoEdit =
                                                TextEditingController(
                                                    text: complementoEditText);
                                          });
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
                                              controller: logradouroEdit,
                                              onChanged: (value) =>
                                                  logradouroEditText = value,
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
                                              controller: numeroEdit,
                                              onChanged: (value) =>
                                                  numeroEditText = value,
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
                                              controller: bairroEdit,
                                              onChanged: (value) =>
                                                  bairroEditText = value,
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
                                              controller: complementoEdit,
                                              onChanged: (value) =>
                                                  complementoEditText = value,
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
                                          controller: rgInscEdit,
                                          onChanged: (value) =>
                                              rgInscEditText = value,
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
                                          controller: telefoneEdit,
                                          onChanged: (value) =>
                                              telefoneEditText = value,
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
                                    controller: emailEdit,
                                    onChanged: (value) => emailEditText = value,
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
                                FuncEditarCliente().editarCliente(context);
                              },
                              child: Text('EDITAR CLIENTE')),
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
