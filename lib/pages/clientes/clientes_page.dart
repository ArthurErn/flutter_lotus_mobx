import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/editar.os.controller.dart';
import 'package:lotus_erp/repository/clientes/get.cliente.data.dart';
import 'package:lotus_erp/repository/clientes/listar_cliente_auth.dart';
import 'package:lotus_erp/model/clientes/construtor_edit_pessoa.dart';
import 'package:lotus_erp/pages/balanco_estoque/balanco_estoque.dart';
import 'package:lotus_erp/pages/clientes/cadastro_page.dart';
import 'package:lotus_erp/pages/clientes/layout/editar_cliente.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:mobx/mobx.dart';

//RECEBE O ID PARA PODER EDITAR


class ClientesPage extends StatefulWidget {
  const ClientesPage({Key key}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  var clienteController = TextEditingController();

  @override
  void initState() {
    setState(() {
      tipoCad = 0;
      isSearch = false;
      persistNomeRazao = "";
    });
    osController.listarClientes();
    //PROCEDIMENTO PADRÃO PARA GERAR A LISTA
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue[900],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.person_add,
            size: 35,
          ),
          label: Text(
            "CADASTRAR",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          elevation: 8,
          backgroundColor: Colors.blue[900],
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroCliente()));
          },
        ),
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[Colors.blue[900], Colors.blue])),
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
            title: Text("Clientes"),
            backgroundColor: Colors.blue[900]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  height: isSearch == true ? 58 : 0,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black),
                  )),
                  child: searchBar()),
              AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  height: isSearch == true
                      ? MediaQuery.of(context).size.height / 1.3
                      : MediaQuery.of(context).size.height / 1.16,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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

  //RETORNA A LISTA DE CLIENTES
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
                    onTap: () {
                      setState(() {
                        indice = index;
                        ClienteData().get();
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditarClientes()));
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
