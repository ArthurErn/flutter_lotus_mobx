import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/editar.pedido.controller.dart';
import 'package:lotus_erp/controllers/nova.venda.controller.dart';
import 'package:lotus_erp/repository/clientes/get.cliente.data.dart';
import 'package:lotus_erp/repository/vendas/inserir_item_auth.dart';
import 'package:lotus_erp/repository/vendas/movimentar_estoque.dart';
import 'package:lotus_erp/views/balanco_estoque/functions/balanco_barcode.dart';
import 'package:lotus_erp/views/consulta_produtos/functions/consulta_barcode.dart';
import 'package:lotus_erp/views/homepage/home_page.dart';
import 'package:lotus_erp/views/login/layout/login_dropdown.dart';
import 'package:lotus_erp/views/vendas/layout/adicionar_produto.dart';
import 'package:lotus_erp/views/vendas/layout/adicionar_quantidade.dart';
import 'package:lotus_erp/views/vendas/layout/error_message.dart';
import 'package:lotus_erp/views/vendas/vendas_page.dart';
import 'package:mobx/mobx.dart';

TextEditingController porcentagemDescontoTotal;
TextEditingController valorDescontoTotal;
double porcentagemDescontoTotalN = 0;
double valorDescontoTotalN = 0;
dynamic totalLiquido;
bool isEdit;
var statusCabecalho;
bool isCliente;
TextEditingController pesquisarClienteController;
var selecionadoVenda;
var indexCliente;

class NovaVenda extends StatefulWidget {
  const NovaVenda({Key key}) : super(key: key);
  @override
  _NovaVendaState createState() => _NovaVendaState();
}

class _NovaVendaState extends State<NovaVenda> {
  @override
  void initState() {
    setState(() {
      produtoVendas = product;
    });
    resetarValores();
    editVenda.listarPagamento();
    novaVenda.listarClientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: formKey,
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.blue[900], Colors.blue])),
          ),
          toolbarHeight: 65,
          title: Text("Nova venda"),
          backgroundColor: Colors.blue[900]),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border(
                          bottom: BorderSide(width: 0.2, color: Colors.black),
                        )),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cliente",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isCliente == false) {
                                    isCliente = true;
                                  } else {
                                    isCliente = false;
                                  }
                                });
                              },
                              icon: Icon(isCliente == false
                                  ? Icons.keyboard_arrow_right
                                  : Icons.keyboard_arrow_down))
                        ],
                      ),
                    ),
                  ),
                  isCliente == true ? searchBar() : Container(),
                  Observer(builder: (_) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: isCliente == true ? 300 : 0,
                      color: Colors.transparent,
                      child: ListView.builder(
                          itemCount: novaVenda.clientesDisplayNovaVenda.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (novaVenda.clientesDisplayNovaVenda.length > 0) {
                              return listclientes(context, index);
                            } else {
                              return Center();
                            }
                          }),
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      height: isCliente == true
                          ? 0
                          : persistNomeRazao != ""
                              ? 50
                              : 0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            width: 0.2,
                            color: persistNomeRazao != ""
                                ? Colors.grey
                                : Colors.transparent),
                      )),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              persistNomeRazao != null
                                  ? persistNomeRazao
                                  : "NENHUM SELECIONADO",
                              style: TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            border: Border(
                              top: BorderSide(width: 0.2, color: Colors.black),
                              bottom:
                                  BorderSide(width: 0.2, color: Colors.black),
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Itens do pedido",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                  onPressed: () {
                                    valorCodigoBarrasProduto = "";
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdicionarProdutoVenda()));
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outlined,
                                    color: Colors.blue[900],
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Observer(builder: (_) {
                    return Container(
                      height: persistNomeRazao != ""
                          ? MediaQuery.of(context).size.height / 3 - 10
                          : MediaQuery.of(context).size.height / 2.5 - 10,
                      child: ListView.builder(
                          itemCount: product.length,
                          itemBuilder: (BuildContext context, int index) {
                            return listVenda(context, index);
                          }),
                    );
                  }),
                  if (descontoIndividual == 0)
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 1.15,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text("Desconto"),
                            SizedBox(width: 22),
                            Container(
                              width: 60,
                              height: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: porcentagemDescontoTotal,
                                onChanged: (valor) {
                                  setState(() {
                                    porcentagemDescontoTotalN =
                                        double.parse(valor);
                                    valorDescontoTotalN = totalLiquidoVenda *
                                        porcentagemDescontoTotalN /
                                        100;
                                    valorDescontoTotal.text =
                                        valorDescontoTotalN.toStringAsFixed(2);
                                    totalLiquido =
                                        totalLiquidoVenda - valorDescontoTotalN;
                                    valorProdutoFinal = totalLiquido;
                                  });
                                },
                                decoration: InputDecoration(labelText: "%"),
                              ),
                            ),
                            SizedBox(width: 22),
                            Container(
                              width: 60,
                              height: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: valorDescontoTotal,
                                onChanged: (valor) {
                                  setState(() {
                                    valorDescontoTotalN = double.parse(valor);
                                    porcentagemDescontoTotalN =
                                        (valorDescontoTotalN *
                                            100 /
                                            totalLiquidoVenda);
                                    dynamic valorPrctg = num.parse(
                                        porcentagemDescontoTotalN
                                            .toStringAsPrecision(2));
                                    porcentagemDescontoTotal.text =
                                        formatter.format(valorPrctg);

                                    totalLiquido =
                                        totalLiquidoVenda - valorDescontoTotalN;
                                    valorProdutoFinal = totalLiquido;
                                  });
                                },
                                decoration: InputDecoration(labelText: "Valor"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            border: Border(
                              top: BorderSide(width: 0.2, color: Colors.black),
                              bottom:
                                  BorderSide(width: 0.2, color: Colors.black),
                            )),
                        height: 50,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, top: 10),
                          child: Text(
                            "Forma de pagamento",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Observer(builder: (_) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 6),
                        child: DropdownButton(
                          //isExpanded: true,
                          hint: Text(
                            'SELECIONE FORMA DE PAGAMENTO',
                            style: TextStyle(fontSize: 13),
                          ),
                          value: selecionadoVenda,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                          items: editVenda.formas.map((selecionadoVenda) {
                            return DropdownMenuItem(
                              value: selecionadoVenda != null
                                  ? selecionadoVenda
                                  : "SELECIONE FORMA DE PAGAMENTO",
                              child: Text(selecionadoVenda.descricao),
                            );
                          }).toList(),
                          onChanged: (valorNovo) {
                            setState(() {
                              selecionadoVenda = valorNovo;
                            });
                          },
                        ),
                      ),
                    );
                  }),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 0.2, color: Colors.grey),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              height: 50,
              child: Text(
                totalLiquidoVenda != 0.0
                    ? "TOTAL: " + totalLiquido.toStringAsFixed(2)
                    : "",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1, color: Colors.black),
                          bottom: BorderSide(width: 1, color: Colors.black),
                          left: BorderSide(width: 1, color: Colors.black),
                          right: BorderSide(width: 1, color: Colors.black),
                        ),
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(4)),
                    child: FlatButton(
                      child: Text(
                        "CONCLUIR VENDA",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        if (totalLiquidoVenda == 0.0) {
                          errorTotalLiquido(context);
                        } else if (persistNomeRazao == "" ||
                            persistNomeRazao == null) {
                          errorCliente(context);
                        } else if (selecionadoVenda == null) {
                          errorPagamento(context);
                        } else {
                          Navigator.pop(context);
                          showAfterVender(formKey.currentContext);
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void showAfterVender(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                  height: 167,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'lib/assets/images/questionmark.png',
                        width: 50,
                        height: 50,
                      ),
                      Divider(
                        height: 25,
                        color: Colors.transparent,
                      ),
                      Container(
                          child: Text(
                        "Concluir o fechamento desta venda?",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              statusCabecalho = 0;
                              postItem().then((value) {
                                movimentarEstoque().then((value) {
                                  afterPost(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VendasPage()));
                                });
                              });
                            },
                            child: Text("Sim"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              statusCabecalho = 1;
                              postItem().then((value) {
                                afterPost(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VendasPage()));
                              });
                            },
                            child: Text("Não"),
                          )
                        ],
                      )
                    ],
                  )),
              actions: <Widget>[],
            ));
  }

  afterPost(BuildContext _context) {
    showDialog(
        context: _context,
        builder: (context) => Dialog(
            child: Container(
                height: 120,
                child: Column(
                  children: [
                    Text(
                      "ID da Venda",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      idVenda,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(_context).pop();
                        },
                        child: Text('OK'))
                  ],
                ))));
  }

  searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        child: TextField(
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              novaVenda.clientesDisplayNovaVenda = ObservableList.of(
                  novaVenda.clientesNovaVenda.where((cliente) {
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
          controller: pesquisarClienteController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.search, color: Color.fromRGBO(21, 101, 192, 0.8)),
            ),
            labelText: "Pesquisar cliente",
            labelStyle: TextStyle(color: Color.fromRGBO(21, 101, 192, 0.8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                color: Colors.grey[400],
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }

  listVenda(BuildContext context, index) {
    return Column(
      children: [
        ListTile(
            title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: product[index].id_produto.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: [
                    TextSpan(
                        text: "  " + product[index].descricao,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.black))
                  ]),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                  text: product[index].fabricante_nome,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  children: []),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                valoresProduto[index].toString() +
                    " x " +
                    (valorFinalProduto[index] / valoresProduto[index])
                        .toStringAsFixed(2),
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
              Text(valorFinalProduto[index].toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]))
            ])
          ],
        )),
        Divider(
          thickness: .5,
          color: Colors.grey,
        )
      ],
    );
  }

  listclientes(BuildContext context, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(
          thickness: 0.3,
          color: Colors.grey[700],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          child: Column(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        indexCliente =
                            novaVenda.clientesDisplayNovaVenda[index].id;
                        clienteId =
                            novaVenda.clientesDisplayNovaVenda[index].id;
                        persistNomeRazao =
                            novaVenda.clientesDisplayNovaVenda[index].nomeRazao;
                        persistApelidoFantasia = novaVenda
                            .clientesDisplayNovaVenda[index].apelidoFantasia;
                        persistCNPJ =
                            novaVenda.clientesDisplayNovaVenda[index].cpfCnpj;
                        persistRG =
                            novaVenda.clientesDisplayNovaVenda[index].rgInsc;
                        persistTelefone =
                            novaVenda.clientesDisplayNovaVenda[index].fone1;
                        persistEmail =
                            novaVenda.clientesDisplayNovaVenda[index].email;
                        persistLogradouro =
                            novaVenda.clientesDisplayNovaVenda[index].endereco;
                        persistNumero = novaVenda
                            .clientesDisplayNovaVenda[index].enderecoNumero;
                        persistBairro =
                            novaVenda.clientesDisplayNovaVenda[index].bairro;
                        persistComplemento = novaVenda
                            .clientesDisplayNovaVenda[index].complemento;
                        persistCep =
                            novaVenda.clientesDisplayNovaVenda[index].cep;
                        persistMunicipio = novaVenda
                            .clientesDisplayNovaVenda[index].municipioId;
                        isCliente = false;
                      });
                    },
                    child: ListTile(
                        title: Text(
                          novaVenda.clientesDisplayNovaVenda[index]
                                      .apelidoFantasia !=
                                  null
                              ? novaVenda
                                  .clientesDisplayNovaVenda[index].nomeRazao
                              : "NOME NÃO INFORMADO",
                          style: TextStyle(fontSize: 13),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              novaVenda.clientesDisplayNovaVenda[index]
                                          .cpfCnpj !=
                                      null
                                  ? "CNPJ/CPF: " +
                                      novaVenda.clientesDisplayNovaVenda[index]
                                          .cpfCnpj
                                  : 'CNPJ não informado',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              novaVenda.clientesDisplayNovaVenda[index].id
                                          .toString() !=
                                      null
                                  ? "ID: " +
                                      novaVenda
                                          .clientesDisplayNovaVenda[index].id
                                          .toString()
                                  : "ID não informado",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            )
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

  resetarValores() {
    valorDescontoTotalN = 0;
    valorDescontoTotal =
        TextEditingController(text: valorDescontoTotalN.toStringAsFixed(2));
    porcentagemDescontoTotal = TextEditingController(text: "00.00");
    complemento = TextEditingController(text: "");
    totalLiquido = totalLiquidoVenda - valorDescontoTotalN;
    porcentagemDescontoTotalN = 0;
    isEdit = false;
    valorCodigoBarras = "";
    pesquisarClienteController = TextEditingController(text: '');
    selecionadoVenda = null;
    persistApelidoFantasia = "";
    persistCNPJ = "";
    persistRG = "";
    persistTelefone = "";
    persistEmail = "";
    persistLogradouro = "";
    persistNumero = "";
    persistBairro = "";
    persistComplemento = "";
    persistCep = "";
    persistMunicipio = "";
    isCliente = false;
  }
}
