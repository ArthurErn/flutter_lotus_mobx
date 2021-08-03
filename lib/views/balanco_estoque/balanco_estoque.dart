import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/balanco.controller.dart';
import 'package:lotus_erp/views/balanco_estoque/layout/produtos_balanco.dart';
import 'package:lotus_erp/views/consulta_produtos/functions/consulta_barcode.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

var idEmpresa = getIndexEmpresa(val);
int val;
bool isSearch = false;
int idBalanco;
SharedPreferences sharedPreferences;

class BalancoEstoque extends StatefulWidget {
  @override
  _BalancoEstoqueState createState() => _BalancoEstoqueState();
}

class _BalancoEstoqueState extends State<BalancoEstoque> {
  var balancoController = TextEditingController();

  @override
  void initState() {
    setState(() {
      valorCodigoBarras = "";
      isSearch = false;
    });
    initSharedPreferences();
    balanco.getListaBalanco();
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
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch == false ? isSearch = true : isSearch = false;
                      });
                    },
                    icon: Icon(isSearch == false
                        ? Icons.search
                        : Icons.close_outlined))
              ],
              toolbarHeight: 65,
              title: Text("Balanço estoque"),
              backgroundColor: Colors.blue[900]),
          body: Column(children: [
            isSearch == true
                ? Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Column(children: [
                      searchBar(),
                    ]),
                  )
                : Center(),
            Expanded(child: Observer(builder: (_) {
              return Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 14, right: 14),
                  color: Colors.transparent,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: balanco.balancoEstoqueDisplay.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (balanco.balancoEstoqueDisplay.length > 0) {
                          return listBalanco(context, index);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }));
            })),
          ])),
    );
  }

  searchBar() {
    return Observer(builder: (_) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: .5, color: Colors.black),
            )),
        child: TextField(
          onChanged: (text) {
            text = text.toLowerCase();
            balanco.balancoEstoqueDisplay =
                ObservableList.of(balanco.balancoEstoque.where((balanco) {
              var balancoData = balanco.data.toLowerCase();
              var balancoId = balanco.id.toString();
              var balancoMotivo = balanco.balanco_motivo.toLowerCase();
              return balancoData.contains(text) ||
                  balancoMotivo.contains(text) ||
                  balancoId.contains(text);
            }));
          },
          controller: balancoController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Pesquisar",
            hintStyle: TextStyle(color: Colors.grey[700]),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      );
    });
  }

  listBalanco(BuildContext context, index) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.all(6),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.005,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItensBalanco()));
                idBalanco = balanco.balancoEstoque[index].id;
                print(idBalanco);
              },
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4.5,
                          spreadRadius: 1)
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      top: BorderSide(width: 1, color: Colors.black),
                      bottom: BorderSide(width: 1, color: Colors.black),
                      left: BorderSide(width: 1, color: Colors.black),
                      right: BorderSide(width: 1, color: Colors.black),
                    ),
                    color: Colors.white),
                child: ListTile(
                  leading: Image.asset("lib/assets/images/balanco.png"),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(
                            text: balanco.balancoEstoqueDisplay[index].id
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          )),
                          RichText(
                              text: TextSpan(
                                  text: balanco
                                      .balancoEstoqueDisplay[index].data
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.grey[700]))),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        balanco.balancoEstoqueDisplay[index].balanco_motivo,
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ))
    ]);
  }
}
