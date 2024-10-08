import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/editar.os.controller.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:lotus_erp/repository/ordem_servico/inserir_tecnico.dart';
import 'package:lotus_erp/views/balanco_estoque/balanco_estoque.dart';
import 'package:lotus_erp/views/ordem_servico/alocar_tecnico.dart';
import 'package:lotus_erp/views/ordem_servico/editar_os.dart';
import 'package:lotus_erp/views/ordem_servico/ordem_oficina.dart';
import 'package:mobx/mobx.dart';

//RECEBE O ID PARA PODER EDITAR
var clienteId;
var persistNomeRazao;
var persistApelidoFantasia;
var persistCNPJ;
var persistRG;
var persistTelefone;
var persistEmail;
var persistLogradouro;
var persistNumero;
var persistBairro;
var persistComplemento;
var persistCep;
var persistMunicipio;

class EditarTecnico extends StatefulWidget {
  const EditarTecnico({Key key}) : super(key: key);

  @override
  _EditarTecnicoState createState() => _EditarTecnicoState();
}

class _EditarTecnicoState extends State<EditarTecnico> {
  var clienteController = TextEditingController();

  @override
  void initState() {
    setState(() {
      isSearch = false;
      persistNomeRazao = "";
    });
    //PROCEDIMENTO PADRÃO PARA GERAR A LISTA

    osController.listarClientes();
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
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditarOrdemServico()));
              },
              icon: Icon(Icons.arrow_back),
            ),
            toolbarHeight: 65,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch == false ? isSearch = true : isSearch = false;
                    });
                  },
                  icon: Icon(
                      isSearch == false ? Icons.search : Icons.close_outlined))
            ],
            title: Text("Técnicos"),
            backgroundColor: Colors.blue[900]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              isSearch == true
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black),
                      )),
                      child: searchBar())
                  : Center(),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  height: isSearch == true
                      ? MediaQuery.of(context).size.height / 1.3
                      : MediaQuery.of(context).size.height / 1.16,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // borderRadius: BorderRadius.circular(8),
                    // border: Border(
                    //   top: BorderSide(width: 1, color: Colors.black),
                    //   bottom: BorderSide(width: 1, color: Colors.black),
                    //   left: BorderSide(width: 1, color: Colors.black),
                    //   right: BorderSide(width: 1, color: Colors.black),
                    // )
                  ),
                  child: Observer(builder: (_) {
                    return Container(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: osController.clientesDisplay.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (osController.clientesDisplay.length > 0) {
                              return listClientes(context, index);
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }

  //BARRA DE PESQUISA, UTILIZANDO FUNÇÃO "CONTAIN" PARA FAZER A CHECAGEM
  searchBar() {
    return TextField(
      onChanged: (text) {
        text = text.toLowerCase();
        setState(() {
          osController.clientesDisplay =
              ObservableList.of(osController.clientes.where((cliente) {
            var clienteId = cliente.id.toString();
            var clienteNome = cliente.nomeRazao != null
                ? cliente.nomeRazao.toLowerCase()
                : "";
            var clienteFantasia = cliente.apelidoFantasia != null
                ? cliente.apelidoFantasia.toLowerCase()
                : "";
            return clienteId.contains(text) ||
                clienteNome.contains(text) ||
                clienteFantasia.contains(text);
          }));
        });
      },
      controller: clienteController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Pesquisar cliente",
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  //RETORNA A LISTA DE TECNICOS
  listClientes(BuildContext context, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Container(
                height: 95,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4.5,
                          spreadRadius: 1)
                    ],
                    border: Border(
                      top: BorderSide(width: 1, color: Colors.black),
                      bottom: BorderSide(width: 1, color: Colors.black),
                      left: BorderSide(width: 1, color: Colors.black),
                      right: BorderSide(width: 1, color: Colors.black),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        ordemTecnicoId = osController.clientesDisplay[index].id;
                        ordemTecnicoNome =
                            osController.clientesDisplay[index].nomeRazao;
                        oficina.ordemDisplay[ordemIndex].tecnicoId =
                            ordemTecnicoId;
                        oficina.ordemDisplay[ordemIndex].tecnicoNome =
                            ordemTecnicoNome;
                      });
                      await postTecnico().then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlocarTecnico()));
                      });
                    },
                    child: ListTile(
                        leading: Image.asset(
                          "lib/assets/images/pessoa.png",
                          color: Colors.black.withOpacity(0.75),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: osController.clientesDisplay[index]
                                              .nomeRazao !=
                                          null
                                      ? osController
                                          .clientesDisplay[index].nomeRazao
                                      : "NOME NÃO INFORMADO",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: osController
                                              .clientesDisplay[index].id !=
                                          null
                                      ? osController.clientesDisplay[index].id
                                          .toString()
                                      : "ID NÃO INFORMADO",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                  children: [
                                    TextSpan(
                                        text: osController
                                                    .clientesDisplay[index]
                                                    .cpfCnpj !=
                                                null
                                            ? "   CPF/CNPJ: " +
                                                "\n" +
                                                osController
                                                    .clientesDisplay[index]
                                                    .cpfCnpj
                                            : "\n" + "CPF/CNPJ NÃO INFORMADO",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600]))
                                  ]),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
