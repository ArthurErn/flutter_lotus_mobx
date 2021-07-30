import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotus_erp/repository/consulta_produtos/consulta_auth.dart';
import 'package:lotus_erp/constructors/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/pages/balanco_estoque/balanco_estoque.dart';
import 'package:lotus_erp/pages/vendas/vendas_page.dart';
import 'functions/consulta_barcode.dart';

class ConsultaProduto extends StatefulWidget {
  @override
  _ConsultaProdutoState createState() => _ConsultaProdutoState();
}

class _ConsultaProdutoState extends State<ConsultaProduto> {
  var tipoController = TextEditingController();
  var valorController = TextEditingController(text: valorCodigoBarras);
  List<Produtos> produtoEstoque = List<Produtos>();
  List<Produtos> produtoEstoqueDisplay = List<Produtos>();

  @override
  void initState() {
    setState(() {
      isSearch = false;
      //RESETA OS VALORES DO GRUPO (FILTRO)
      tipo = 1;
      pvalor = "";
    });
    getProdutos().then((value) {
      setState(() {
        produtoEstoque.addAll(value);
        produtoEstoqueDisplay = produtoEstoque;
        if (valorCodigoBarras != null) {
          setState(() {
            produtoEstoqueDisplay = produtoEstoque.where((produto) {
              var produtoGtin = produto.gtin;
              if (produtoGtin != null) {
                return produtoGtin.contains(valorCodigoBarras);
              } else {
                return false;
              }
            }).toList();
          });
        }
      });
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
                      valorCodigoBarras = "";
                      isSearch == false ? isSearch = true : isSearch = false;
                    });
                  },
                  icon: Icon(
                      isSearch == false ? Icons.search : Icons.close_outlined))
            ],
            title: Text("Consultar produtos"),
            backgroundColor: Colors.blue[900],
          ),
          backgroundColor: //Color.fromRGBO(21, 101, 192, 0.8)
              Colors.transparent,
          body: Column(children: [
            isSearch == true
                ? Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Column(children: [
                      searchBarConsulta(),
                    ]),
                  )
                : Center(),
            Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height / 1.6,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      // borderRadius: BorderRadius.circular(8),
                      // border: Border(
                      //   top: BorderSide(width: 1, color: Colors.black),
                      //   bottom: BorderSide(width: 1, color: Colors.black),
                      //   left: BorderSide(width: 1, color: Colors.black),
                      //   right: BorderSide(width: 1, color: Colors.black),
                      // ),
                    ),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: produtoEstoqueDisplay.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (produtoEstoqueDisplay.length > 0) {
                            return listProduto(context, index);
                          } else {
                            return Container(
                              height: 200,
                              color: Colors.red,
                            );
                          }
                        })))
          ])),
    );
  }

  //LISTA DE PRODUTOS PARA CONSULTA
  listProduto(BuildContext context, index) {
    return Container(
      height: 140,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4.5,
                spreadRadius: 1)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
          ListTile(
            leading: Image.asset("lib/assets/images/produto.png"),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 7),
                          child: Text(
                            produtoEstoqueDisplay[index].id_produto.toString(),
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
                    Text(
                      produtoEstoqueDisplay[index].produto_saldo.toString(),
                      style: TextStyle(
                          color: Colors.grey[850],
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )
                  ],
                ),
                SizedBox(height: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produtoEstoqueDisplay[index].descricao,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(height: 3),
                    Text(
                      produtoEstoqueDisplay[index].fabricante_nome,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal,
                          fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "R\$" +
                          formatoValores
                              .format(
                                  produtoEstoqueDisplay[index].produto_pvenda)
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
      ),
    );
  }

  //SEARCH BAR PADRÃO (CONSULTA DE PRODUTOS)
  searchBarConsulta() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black),
          )),
      child: TextFormField(
        onTap: () {},
        onChanged: (texto) {
          texto = texto.toUpperCase();
          setState(() {
            produtoEstoqueDisplay = produtoEstoque.where((produto) {
              var produtoConsultaId = produto.id_produto.toString();
              var produtoDescricao = produto.descricao;
              var produtoGtin = produto.gtin;
              var produtoRef = produto.ref_fabrica;
              var produtoFab = produto.fabricante_nome;
              if (produtoConsultaId != null &&
                  produtoDescricao != null &&
                  produtoGtin != null &&
                  produtoRef != null &&
                  produtoFab != null) {
                return produtoConsultaId.contains(texto) ||
                    produtoDescricao.contains(texto) ||
                    produtoGtin.contains(texto) ||
                    produtoRef.contains(texto) ||
                    produtoFab.contains(texto);
              } else {
                return false;
              }
            }).toList();
          });
        },
        controller: valorController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                ConsultaController().escanearCodigoBarras();
              },
              icon: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.yellow[700],
              )),
          filled: true,
          fillColor: Colors.white,
          hintText: "Consulte os produtos aqui",
          hintStyle: TextStyle(color: Colors.grey[700]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
