//LISTAR PRODUTOS NO BALANÇO

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/balanco.produtos.controller.dart';
import 'package:lotus_erp/repository/balanco_estoque/delete_produto.dart';
import 'package:lotus_erp/views/balanco_estoque/functions/balanco_barcode.dart';
import 'package:lotus_erp/views/consulta_produtos/functions/consulta_barcode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adicionar_produto.dart';
import 'adicionar_saldo.dart';
import '../balanco_estoque.dart';
import 'package:asuka/asuka.dart' as asuka;

String idProduto;

class ItensBalanco extends StatefulWidget {
  @override
  _ItensBalancoState createState() => _ItensBalancoState();
}

class _ItensBalancoState extends State<ItensBalanco> {
  @override
  void initState() {
    valorProduto = 0;
    initSharedPreferences();
    balancoProdutos.getLista();
    super.initState();
  }

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
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
        color: const Color(0xff7c94b6),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              valorCodigoBarras = null;
              valorCodigoBarrasProduto = null;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdicionarProduto()));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            elevation: 8,
            backgroundColor: Colors.yellow[700],
            icon: Icon(
              Icons.add_shopping_cart_sharp,
              size: 35,
            ),
            label: Text(
              "ADICIONAR PRODUTO",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Column(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              height: 40,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                  left: 10,
                  right: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('PRODUTO',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('SALDO',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Container(
              height: 0,
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            ),
            Expanded(child: Observer(builder: (_) {
              return Container(
                  margin: EdgeInsets.only(bottom: 20, left: 4.8, right: 4.8),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: balancoProdutos.balancoEstoqueProdutos.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (balancoProdutos.balancoEstoqueProdutos.length > 0) {
                          return listBalancoProduto(context, index);
                        } else if (balancoProdutos
                                .balancoEstoqueProdutos.length ==
                            0) {
                          return Center(
                            child: Text("Produto não encontrado"),
                          );
                        } else {
                          return Center();
                        }
                      }));
            })),
          ])),
    );
  }

  listBalancoProduto(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
      child: Card(
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 3,
                      spreadRadius: 2)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 68,
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Wrap(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 35,
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                    balancoProdutos
                                        .balancoEstoqueProdutos[index].idProduto
                                        .toString(),
                                    style: TextStyle(fontSize: 12)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: Text(
                                  balancoProdutos
                                      .balancoEstoqueProdutos[index].descricao,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 30,
                                child: Text(
                                  balancoProdutos
                                      .balancoEstoqueProdutos[index].saldoNovo
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              IconButton(
                                alignment: Alignment.center,
                                onPressed: () async{
                                  setState(() {
                                    idProduto = balancoProdutos
                                        .balancoEstoqueProdutos[index].idProduto
                                        .toString();
                                    

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
                                  await deleteProdutos().then((value) {
                                      balancoProdutos.getLista();
                                    });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]))),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.blue, Colors.red],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
