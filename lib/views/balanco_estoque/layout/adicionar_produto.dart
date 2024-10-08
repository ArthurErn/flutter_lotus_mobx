//TELA QUE APARECE AO CLICAR EM "ADICIONAR PRODUTO"
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/balanco.controller.dart';
import 'package:lotus_erp/repository/consulta_produtos/consulta_auth.dart';
import 'package:lotus_erp/model/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/views/balanco_estoque/functions/balanco_barcode.dart';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/vendas/vendas_page.dart';
import 'package:mobx/mobx.dart';
import 'adicionar_saldo.dart';

int valorId;
String produtoId;
String produtoBalanco;
var _usuario = configLoginControllerText;
var _senha = passControllerText;
var _ip = ipControllerText;
var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));

class AdicionarProduto extends StatefulWidget {
  @override
  _AdicionarProdutoState createState() => _AdicionarProdutoState();
}

class _AdicionarProdutoState extends State<AdicionarProduto> {
  var valorController = TextEditingController(text: valorCodigoBarrasProduto);

  @override
  void initState() {
    // TIPO = DIGITADO OU BARCODE
    tipo = 1;
    pvalor = "";
    balanco.getListaProdutos();
    balanco.getListaGrupo();
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
              Colors.black.withOpacity(0.4), BlendMode.dstOver),
          image: AssetImage(
            'lib/assets/images/background.png',
          ),
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Colors.blue[900], Colors.blue])),
              ),
              toolbarHeight: 65,
              title: Text("Produtos"),
              backgroundColor: Colors.blue[900]),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                margin: EdgeInsets.all(14),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(4),
                    // border: Border(
                    //   top: BorderSide(width: 1, color: Colors.black),
                    //   bottom: BorderSide(width: 1, color: Colors.black),
                    //   left: BorderSide(width: 1, color: Colors.black),
                    //   right: BorderSide(width: 1, color: Colors.black),
                    // ),
                    color: Colors.transparent),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Column(children: [
                    searchBar(),
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Observer(builder: (_) {
                return Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: balanco.grupoDisplay?.length ?? 0,
                      itemBuilder: (context, index) {
                        return listGrupo(context, index);
                      },
                    ));
              }),
              SizedBox(
                height: 15,
              ),
              Observer(builder: (_) {
                return Container(
                    height: MediaQuery.of(context).size.height / 1.83,
                    margin: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: balanco.produtoVendasListaDisplay.length,
                        // ignore: missing_return
                        itemBuilder: (BuildContext context, int index) {
                          if (balanco.produtoVendasListaDisplay.length > 0) {
                            return listProduto(context, index);
                          } else if (balanco.produtoVendasListaDisplay.length ==
                              1) {
                            getProdutos().then((value) {
                              setState(() {
                                balanco.produtoVendasLista.addAll(value);
                                balanco.produtoVendasListaDisplay =
                                    balanco.produtoVendasLista;
                              });
                              return listProduto(context, index);
                            });
                          } else {
                            return Center();
                          }
                        }));
              })
            ]),
          )),
    );
  }

  listGrupo(BuildContext context, index) {
    String grupoId = balanco.grupoValue[index].idGrupoFormatado;
    return GestureDetector(
      onTap: () {
        List<Produtos> produtosGrupo = [];
        setState(() {
          tipo = 5;
          pvalor = balanco.grupoValue[index].idGrupo.toString();
          getProdutos().then((value) {
            setState(() {
              produtosGrupo.addAll(value);
              balanco.produtoVendasListaDisplay =
                  ObservableList.of(produtosGrupo);
            });
          });
        });
      },
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: 3),
              height: 70,
              width: 130,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    top: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    right: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white),
              child: Column(
                children: [
                  Image(
                      width: MediaQuery.of(context).size.width / 3,

                      //ROTA PARA TRAZER AS FOTOS DO GRUPO (FILTRO)
                      image: NetworkImage(
                          "http://$_ip/lotuserp/findimagem?tipo=1&escala=1000&img=PRO_$grupoId.PNG",
                          headers: <String, String>{
                            'authorization': basicAuth
                          }),
                      height: 40),
                  SizedBox(
                    height: 5,
                  ),
                  Text(balanco.grupoDisplay[index].grupoDescricao,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.5,
                      )),
                ],
              ))
        ],
      ),
    );
  }

  //LISTA TODOS OS PRODUTOS
  listProduto(BuildContext context, index) {
    produtoId = balanco.produtoVendasListaDisplay[index].id_produto_formatado;
    return GestureDetector(
      onTap: () {
        setState(() {
          produtoBalanco = balanco.produtoVendasListaDisplay[index].descricao;
          valorProduto = 0;
        });
        valorId = balanco.produtoVendasListaDisplay[index].id_produto;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdicionarValorProduto()));
      },
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Container(
            height: 136,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: 1, color: Colors.black),
                  top: BorderSide(width: 1, color: Colors.black),
                  left: BorderSide(width: 1, color: Colors.black),
                  bottom: BorderSide(width: 1, color: Colors.black),
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Image(
                      height: 120,
                      width: 60,

                      //ROTA PARA TRAZER AS IMAGENS DOS PRODUTOS
                      image: NetworkImage(
                          "http://$_ip/lotuserp/findimagem?tipo=1&escala=1000&img=PRO_${produtoId}_001.PNG",
                          headers: <String, String>{
                            'authorization': basicAuth
                          })),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 7),
                            child: Text(
                              balanco
                                  .produtoVendasListaDisplay[index].id_produto
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[600],
                                  ),
                                  top: BorderSide(
                                    color: Colors.grey[600],
                                  ),
                                  left: BorderSide(
                                    color: Colors.grey[600],
                                  ),
                                  right: BorderSide(
                                    color: Colors.grey[600],
                                  )))),
                      SizedBox(height: 2),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            balanco.produtoVendasListaDisplay[index].descricao,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(height: 3),
                          Text(
                            balanco.produtoVendasListaDisplay[index]
                                .fabricante_nome,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.normal,
                                fontSize: 13),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "R\$" +
                                formatoValores
                                    .format(balanco
                                        .produtoVendasListaDisplay[index]
                                        .produto_pvenda)
                                    .toString(),
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  searchBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey[700]),
            bottom: BorderSide(width: 1, color: Colors.grey[700]),
            left: BorderSide(width: 1, color: Colors.grey[700]),
            right: BorderSide(width: 1, color: Colors.grey[700]),
          )),
      child: TextField(
        onChanged: (texto) {
          texto = texto.toUpperCase();
          setState(() {
            balanco.produtoVendasListaDisplay =
                ObservableList.of(balanco.produtoVendasLista.where((produto) {
              var produtoId = produto.id_produto.toString();
              var produtoDescricao = produto.descricao;
              var produtoGtin = produto.gtin;
              var produtoRef = produto.ref_fabrica;
              var produtoFab = produto.fabricante_nome;
              if (produtoId != null &&
                  produtoDescricao != null &&
                  produtoGtin != null &&
                  produtoRef != null &&
                  produtoFab != null) {
                return produtoId.contains(texto) ||
                    produtoDescricao.contains(texto) ||
                    produtoGtin.contains(texto) ||
                    produtoRef.contains(texto) ||
                    produtoFab.contains(texto);
              } else {
                return false;
              }
            }));
          });
        },
        controller: valorController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                Navigator.pop(context);

                //FUNÇÃO DE ESCANEAR
                ConsultaBalancoController().escanearCodigoBarras();
              },
              icon: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.yellow[700],
              )),
          filled: true,
          fillColor: Colors.white,
          hintText: "Pesquisar",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
