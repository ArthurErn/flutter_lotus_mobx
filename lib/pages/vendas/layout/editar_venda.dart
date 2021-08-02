import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/editar.pedido.controller.dart';
import 'package:lotus_erp/controllers/vendas.controller.dart';
import 'package:lotus_erp/repository/vendas/alterar_pagamento.dart';
import 'package:lotus_erp/repository/vendas/dropdown_venda_auth.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:lotus_erp/repository/vendas/excluir_item.dart';
import 'package:lotus_erp/repository/vendas/lista_item_pedido.dart';
import 'package:lotus_erp/repository/vendas/lista_pedido_auth.dart';
import 'package:lotus_erp/model/vendas/construtor_lista_pedido.dart';
import 'package:lotus_erp/pages/homepage/home_page.dart';
import 'package:lotus_erp/pages/vendas/layout/adicionar_produto.dart';
import 'package:lotus_erp/pages/vendas/nova_venda.dart';
import 'package:lotus_erp/pages/vendas/vendas_page.dart';

bool isCliente = true;
List<ListVenda> itensPedidosEdit = [];
List<ListVenda> itensPedidosEditDisplay = [];
var posicaoItem;

class EditarPedido extends StatefulWidget {
  const EditarPedido({Key key}) : super(key: key);

  @override
  _EditarPedidoState createState() => _EditarPedidoState();
}

class _EditarPedidoState extends State<EditarPedido> {
  @override
  void initState() {
    setState(() {
      vendas.pedidos.clear();
      vendas.pedidosDisplay = vendas.pedidos;
      dataController = TextEditingController(text: "");
      isCliente = false;
      isEdit = true;
      selecionadoVenda = null;
    });
    editVenda.listarPagamento();
    getItensPedido().then((value) {
      setState(() {
        produtoVendas = product;
        itensPedidosEdit = value;
        itensPedidosEditDisplay = itensPedidosEdit;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => VendasPage()));
              },
              icon: Icon(Icons.arrow_back),
            ),
            toolbarHeight: 65,
            title: Text("Editar pedido"),
            backgroundColor: Colors.blue[900]),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(4),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.black),
                        bottom: BorderSide(width: 1, color: Colors.black),
                        left: BorderSide(width: 1, color: Colors.black),
                        right: BorderSide(width: 1, color: Colors.black),
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Produtos",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: isCliente == true
                              ? MediaQuery.of(context).size.height / 2.5
                              : MediaQuery.of(context).size.height / 1.15 - 194,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(width: 1, color: Colors.black),
                                bottom:
                                    BorderSide(width: 1, color: Colors.black),
                                left: BorderSide(width: 1, color: Colors.black),
                                right:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: ListView.builder(
                              itemCount: itensPedidosEditDisplay.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (itensPedidosEditDisplay.length > 0) {
                                  return listItensPedido(context, index);
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Text(
                            "Cliente: " + clienteEdit,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                      Observer(builder: (_) {
                        return Container(
                          margin: EdgeInsets.only(left: 6),
                          child: DropdownButton(
                            //isExpanded: true,
                            hint: Text(
                              'ALTERAR FORMA DE PAGAMENTO',
                              style: TextStyle(fontSize: 13),
                            ),
                            value: selecionadoVenda,
                            style: TextStyle(fontSize: 11, color: Colors.black),
                            items: editVenda.formas.map((selecionadoVenda) {
                              return DropdownMenuItem(
                                value: selecionadoVenda != null
                                    ? selecionadoVenda
                                    : "ALTERAR FORMA DE PAGAMENTO",
                                child: Text(selecionadoVenda.descricao),
                              );
                            }).toList(),
                            onChanged: (valorNovo) {
                              setState(() {
                                selecionadoVenda = valorNovo;
                                alterarPagamento();
                              });
                            },
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdicionarProdutoVenda()));
                          },
                          child: Container(
                            child: Center(
                                child: Text(
                              "Adicionar produto",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                            width: MediaQuery.of(context).size.width,
                            height: 58,
                            decoration: BoxDecoration(
                                color: Colors.blue[900],
                                border: Border(
                                  top:
                                      BorderSide(width: 1, color: Colors.black),
                                  bottom:
                                      BorderSide(width: 1, color: Colors.black),
                                  left:
                                      BorderSide(width: 1, color: Colors.black),
                                  right:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  listItensPedido(BuildContext context, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1),
          child: Container(
            margin: EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text:
                            itensPedidosEditDisplay[index].idProduto.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                        children: [
                      TextSpan(
                        text: "  " +
                            itensPedidosEditDisplay[index].produtoDescricao,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ])),
                SizedBox(
                  height: 7,
                ),
                RichText(
                    text: TextSpan(
                        text: itensPedidosEditDisplay[index].refFabrica != null
                            ? "Referencia: " +
                                itensPedidosEditDisplay[index].refFabrica
                            : "Referencia não informada",
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        children: [
                      TextSpan(
                        text: "      Quantidade: " +
                            itensPedidosEditDisplay[index].qtde.toString(),
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          posicaoItem = itensPedidosEditDisplay[index].item;
                          excluirItem().then((value) {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditarPedido()));
                            asuka.showSnackBar(SnackBar(
                                duration: Duration(seconds: 2),
                                content: Row(
                                  children: [
                                    Text("Item removido!"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  ],
                                )));
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[700],
                          size: 25,
                        )),
                  ],
                ),
                Divider(
                  thickness: .5,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
