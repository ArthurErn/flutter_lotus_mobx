import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotus_erp/repository/clientes/get.cliente.data.dart';
import 'package:lotus_erp/repository/vendas/inserir_item_auth.dart';
import 'package:lotus_erp/repository/vendas/lista_pedido_auth.dart';
import 'package:lotus_erp/constructors/vendas/construtor_pedidos.dart';
import 'package:intl/intl.dart';
import 'package:lotus_erp/pages/balanco_estoque/balanco_estoque.dart';
import 'package:lotus_erp/pages/clientes/clientes_page.dart';
import 'package:lotus_erp/pages/consulta_produtos/functions/consulta_barcode.dart';
import 'package:lotus_erp/pages/homepage/home_page.dart';
import 'package:lotus_erp/pages/vendas/layout/adicionar_quantidade.dart';
import 'package:lotus_erp/pages/vendas/layout/editar_venda.dart';
import 'package:lotus_erp/pages/vendas/nova_venda.dart';

TextEditingController dataController;
var dataText = dataController.text;
var idEdit;
var clienteEdit;
var clienteIdEdit;

List<ListaPedidos> pedidos = [];
List<ListaPedidos> pedidosDisplay = [];
final formatoValores = NumberFormat.currency(locale: "pt_BR", symbol: "");

class VendasPage extends StatefulWidget {
  const VendasPage({Key key}) : super(key: key);

  @override
  _VendasPageState createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  @override
  void initState() {
    setState(() {
      valorCodigoBarras = "";
      dataText = "";
      pedidos = [];
      pedidosDisplay = [];
      isSearch = false;
      valoresProduto.clear();
      porcentagensProdutos.clear();
      valorFinalProduto.clear();
      idEdit = null;
      clienteEdit = null;
      indexCliente = "";
      persistNomeRazao = "";
      produtoVendas = [];
      complementoLista = [];
      product = [];
      valoresProduto = [];
      totalLiquidoVenda = 0;
      aux = -1;
      indice = 0;
      qtdItens = 0;
      totalBrutoVenda = 0;
    });

    dataController = TextEditingController(text: "");
    getPedidos().then((value) {
      setState(() {
        pedidos.addAll(value);
        pedidosDisplay = pedidos;
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
                      isSearch == false ? isSearch = true : isSearch = false;
                    });
                  },
                  icon: Icon(
                      isSearch == false ? Icons.search : Icons.close_outlined))
            ],
            title: Text("Pedidos"),
            backgroundColor: Colors.blue[900]),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      isSearch == true
                          ? Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  color: Colors.white),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: dataController,
                                  decoration: InputDecoration(
                                      suffixIcon: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end, // added line
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2001),
                                                        lastDate:
                                                            DateTime(2100))
                                                    .then((date) {
                                                  setState(() {
                                                    isSearch = true;
                                                    var data =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(date);
                                                    dataController.text =
                                                        data.toString();
                                                    dataText =
                                                        dataController.text;
                                                  });
                                                });
                                              },
                                              icon: Icon(Icons.calendar_today)),
                                          IconButton(
                                            icon: Icon(Icons.search),
                                            onPressed: () {
                                              dataText = dataController.text;
                                              dataText =
                                                  dataText.replaceAll("/", "");
                                              getPedidos().then((value) {
                                                setState(() {
                                                  pedidos = value;
                                                  pedidosDisplay = pedidos;
                                                  dataText = "";
                                                });
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Data',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                            )
                          : Center()
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    valoresProduto.clear();
                    porcentagensProdutos.clear();
                    valorFinalProduto.clear();
                    totalLiquidoVenda = 0;
                    aux = -1;
                    indice = 0;
                    qtdItens = 0;
                    totalBrutoVenda = 0;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => NovaVenda()));
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.05,
                    decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        border: Border(
                          top: BorderSide(width: 1, color: Colors.black),
                          bottom: BorderSide(width: 1, color: Colors.black),
                          left: BorderSide(width: 1, color: Colors.black),
                          right: BorderSide(width: 1, color: Colors.black),
                        )),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_rounded),
                          Text(
                            "  Novo pedido",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: isSearch == true
                        ? MediaQuery.of(context).size.height / 1.36
                        : MediaQuery.of(context).size.height / 1.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      // borderRadius: BorderRadius.circular(12),
                      // border: Border(
                      //   top: BorderSide(width: 1, color: Colors.black),
                      //   bottom: BorderSide(width: 1, color: Colors.black),
                      //   left: BorderSide(width: 1, color: Colors.black),
                      //   right: BorderSide(width: 1, color: Colors.black),
                      // ),
                    ),
                    child: Container(
                        //height: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: pedidosDisplay.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (pedidosDisplay.length > 0) {
                                return listPedidos(context, index);
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  listPedidos(BuildContext context, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  idEdit = pedidosDisplay[index].id;
                  clienteEdit = pedidosDisplay[index].clienteNome;
                  clienteIdEdit = pedidosDisplay[index].idCliente;
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => EditarPedido()));
              },
              child: Container(
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
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                      title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            pedidosDisplay[index].id.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            pedidosDisplay[index].vendedorNome,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          Text(
                            pedidosDisplay[index].clienteNome,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          Text(
                            pedidosDisplay[index].fpagtoDescricao != null
                                ? pedidosDisplay[index].fpagtoDescricao
                                : 'Forma de pagamento não informada',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            pedidosDisplay[index].dataVenda,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            formatoValores
                                .format(pedidosDisplay[index].totLiquido),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blue[800]),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
