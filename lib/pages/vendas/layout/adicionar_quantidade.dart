import 'package:flutter/material.dart';
import 'package:lotus_erp/repository/vendas/edit_venda_auth.dart';
import 'package:lotus_erp/repository/vendas/inserir_item_auth.dart';
import 'package:lotus_erp/repository/vendas/persist_produto.dart';
import 'package:lotus_erp/pages/login/layout/login_dropdown.dart';
import 'package:lotus_erp/pages/vendas/layout/adicionar_produto.dart';
import 'package:intl/intl.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:lotus_erp/pages/vendas/layout/editar_venda.dart';
import 'package:lotus_erp/pages/vendas/nova_venda.dart';

dynamic valorProduto;
int porcentagemProduto = 0;
double valorPorcentagemFinal;
double valorProdutoFinal;
List<dynamic> valoresProduto = [];
List<dynamic> porcentagensProdutos = [];
List<String> complementoLista = [];
List<dynamic> valorFinalProduto = [];
TextEditingController complemento;
String complementoText = "";
var valor = TextEditingController(text: valorProduto.toString());
var porcentagem = TextEditingController(text: porcentagemProduto.toString());
var idEmpresa;
var idProduto;
var idProdutoFormatado;
var descricao;
var unidade;
var refFabrica;
var gtin;
var fabricanteNome;
var produtoCompra;
var produtoCusto;
var produtoVenda;
var produtoSaldo;
var grupoId;
var grupoDescricao;
var servico;

TextEditingController descontoPorcentagem;
TextEditingController descontoValor;
double descontoPorcentagemN = 0;
double descontoValorN = 0;
dynamic valorItem;
NumberFormat formatter = new NumberFormat("00.00");

class AdicionarQuantidade extends StatefulWidget {
  const AdicionarQuantidade({Key key}) : super(key: key);

  @override
  _AdicionarQuantidadeState createState() => _AdicionarQuantidadeState();
}

class _AdicionarQuantidadeState extends State<AdicionarQuantidade> {
  @override
  void initState() {
    setState(() {
      complementoText = "";
      valorPorcentagemFinal = 0;
      complemento = TextEditingController(text: complementoText);
      //RESETA A QUANTIDADE DO SALDO
      valorProduto = 0;
      valor.text = valorProduto.toString();
      descontoPorcentagemN = 0;
      descontoValorN = 0;
      valorPorcentagemFinal = 0;
      valorProduto = 0;
      valorProdutoFinal = 0;
      valorItem = 0;
      valor = TextEditingController(text: valorProduto.toString());
      descontoPorcentagem = TextEditingController(text: "00.00");
      descontoValor =
          TextEditingController(text: descontoValorN.toStringAsFixed(2));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text("Adicionar quantidade"),
          backgroundColor: Colors.blue[900]),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Container(
            //height: MediaQuery.of(context).size.height / 1.09,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Produto",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.grey)),
                          Text(produtoBalanco,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.black))
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Quantidade",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                valorProduto > 0
                                    ? valorProduto = valorProduto - 1
                                    // ignore: unnecessary_statements
                                    : null;
                                valor.text = valorProduto.toString();
                                valorItem = produtoVenda * valorProduto;
                                descontoPorcentagemN =
                                    (descontoValorN * 100) / valorItem;
                                dynamic valorPrctg = num.parse(
                                    descontoPorcentagemN
                                        .toStringAsPrecision(2));
                                descontoPorcentagem.text =
                                    formatter.format(valorPrctg);
                                valorPorcentagemFinal = (produtoVenda *
                                    valorProduto *
                                    porcentagemProduto /
                                    100);
                                valorProdutoFinal =
                                    (produtoVenda * valorProduto) -
                                        descontoValorN;
                                descontoPorcentagemN = valorPorcentagemFinal;
                                totalLiquido = valorProdutoFinal;
                              });
                            },
                            icon: Icon(Icons.remove_circle_sharp),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  valorProduto = int.parse(value);
                                  //valor.text = valorProduto.toString();
                                  valorItem = produtoVenda * valorProduto;
                                  descontoPorcentagemN =
                                      (descontoValorN * 100) / valorItem;
                                  double valorPrctg = num.parse(
                                      descontoPorcentagemN
                                          .toStringAsPrecision(2));
                                  descontoPorcentagem.text =
                                      formatter.format(valorPrctg);
                                  valorPorcentagemFinal = (produtoVenda *
                                      valorProduto *
                                      porcentagemProduto /
                                      100);
                                  valorProdutoFinal =
                                      (produtoVenda * valorProduto) -
                                          valorPorcentagemFinal;
                                  descontoPorcentagemN = valorPorcentagemFinal;
                                  totalLiquido = valorProdutoFinal;
                                });
                              },
                              controller: valor,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[350]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[350]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                valorProduto >= 0
                                    ? valorProduto = valorProduto + 1
                                    : null;
                                valor.text = valorProduto.toString();
                                valorItem = produtoVenda * valorProduto;
                                descontoPorcentagemN =
                                    (descontoValorN * 100) / valorItem;
                                dynamic valorPrctg = num.parse(
                                    descontoPorcentagemN
                                        .toStringAsPrecision(2));
                                descontoPorcentagem.text =
                                    formatter.format(valorPrctg);
                                valorPorcentagemFinal = (produtoVenda *
                                    valorProduto *
                                    porcentagemProduto /
                                    100);
                                valorProdutoFinal =
                                    (produtoVenda * valorProduto) -
                                        descontoValorN;
                                descontoPorcentagemN = valorPorcentagemFinal;
                                totalLiquido = valorProdutoFinal;
                              });
                            },
                            icon: Icon(Icons.add_circle_sharp),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (descontoIndividual == 1)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text("Descontos",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(width: 60),
                              Container(
                                height: 50,
                                width: 60,
                                child: TextField(
                                  onChanged: (valor) {
                                    setState(() {
                                      descontoPorcentagemN =
                                          double.parse(valor);
                                      if (descontoPorcentagemN == null) {
                                        descontoPorcentagemN = 0;
                                      }
                                      if (descontoPorcentagemN <= 100) {
                                        valorItem = produtoVenda * valorProduto;
                                        descontoValorN = valorItem *
                                            descontoPorcentagemN /
                                            100;
                                        descontoValor.text =
                                            descontoValorN.toStringAsFixed(2);
                                        valorProdutoFinal =
                                            (produtoVenda * valorProduto) -
                                                descontoValorN;
                                      }
                                    });
                                  },
                                  controller: descontoPorcentagem,
                                  decoration: InputDecoration(labelText: '%'),
                                ),
                              ),
                              SizedBox(width: 30),
                              Container(
                                height: 50,
                                width: 60,
                                child: TextField(
                                  onChanged: (valor) {
                                    setState(() {
                                      descontoValorN = double.parse(valor);
                                      if (descontoValor.text == "") {
                                        descontoPorcentagem.text = "00.00";
                                      }
                                      valorItem = produtoVenda * valorProduto;
                                      descontoPorcentagemN =
                                          (descontoValorN * 100) / valorItem;
                                      dynamic valorPrctg = num.parse(
                                          descontoPorcentagemN
                                              .toStringAsPrecision(2));
                                      descontoPorcentagem.text =
                                          formatter.format(valorPrctg);

                                      valorProdutoFinal =
                                          (produtoVenda * valorProduto) -
                                              descontoValorN;
                                    });
                                  },
                                  controller: descontoValor,
                                  decoration:
                                      InputDecoration(labelText: 'Valor'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: descontoIndividual == 1 ? 90 : 70,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (descontoIndividual == 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Subtotal",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              Text(valorItem.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Colors.black)),
                            ],
                          ),
                        SizedBox(height: 6),
                        if (descontoIndividual == 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Desconto",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              Text(descontoValorN.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Colors.black)),
                            ],
                          ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            Text(valorProdutoFinal.toStringAsFixed(2),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(labelText: "Complemento"),
                      controller: complemento,
                      onChanged: (texto) {
                        setState(() {
                          complementoText = texto;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 1,
                  height: 66,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(width: .5, color: Colors.black),
                      top: BorderSide(width: .5, color: Colors.black),
                      left: BorderSide(width: .5, color: Colors.black),
                      bottom: BorderSide(width: .5, color: Colors.black),
                    )),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (isEdit == false) {
                            if (valorProduto > 0) {
                              complementoLista.add(complementoText);
                              valoresProduto.add(valorProduto);
                              porcentagensProdutos.add(descontoPorcentagemN);
                              valorFinalProduto.add(valorProdutoFinal);
                              getPersist();

                              Navigator.pop(context);
                              Navigator.pop(context);
                              asuka.showSnackBar(SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Row(
                                    children: [
                                      Text("Item adicionado!"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    ],
                                  )));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NovaVenda()));
                              getTotal();
                            } else {
                              errorSaldoInput(context);
                            }
                          } else {
                            if (valorProduto > 0) {
                              complementoLista.clear();
                              complementoLista.add(complementoText);
                              valoresProduto.clear();
                              valoresProduto.add(valorProduto);
                              porcentagensProdutos.clear();
                              porcentagensProdutos.add(descontoPorcentagemN);
                              valorFinalProduto.clear();
                              valorFinalProduto.add(valorProdutoFinal);
                              getPersistProdutos();

                              getTotalEdit();
                              editVenda().then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditarPedido()));
                              });
                            } else {
                              errorSaldoInput(context);
                            }
                          }
                        });
                      },
                      child: Text("Adicionar Item"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void errorSaldoInput(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/images/alerta.png',
                    width: 50,
                    height: 50,
                  ),
                  Divider(
                    height: 20.0,
                    color: Colors.transparent,
                  ),
                  Container(
                      child: Text(
                    "VALOR NÃO DISPONÍVEL",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: Text(
                    "Adicione um valor maior que zero",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  )),
                ],
              )),
              actions: <Widget>[],
            ));
  }
}
