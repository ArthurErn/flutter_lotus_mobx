import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/services.dart';
import 'package:lotus_erp/pages/balanco_estoque/layout/adicionar_produto.dart';
import 'package:lotus_erp/pages/balanco_estoque/layout/produtos_balanco.dart';
import 'package:lotus_erp/pages/balanco_estoque/post.produto.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/repository/balanco_estoque/adicionar_produto_auth.dart';

int valorProduto;
var _usuario = configLoginControllerText;
var _senha = passControllerText;
var _ip = ipControllerText;
var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
var valor = TextEditingController(text: valorProduto.toString());

class AdicionarValorProduto extends StatefulWidget {
  @override
  _AdicionarValorProdutoState createState() => _AdicionarValorProdutoState();
}

class _AdicionarValorProdutoState extends State<AdicionarValorProduto> {
  @override
  void initState() {
    setState(() {
      //RESETA A QUANTIDADE DO SALDO
      valorProduto = 0;
      valor.text = valorProduto.toString();
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
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Colors.blue[900], Colors.blue])),
              ),
              toolbarHeight: 65,
              title: Text("Adicionar saldo"),
              backgroundColor: Colors.blue[900],
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Column(children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 90),
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 3.4,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5)
                            ]),
                        child: Image(
                            width: MediaQuery.of(context).size.width / 2.2,
                            image: NetworkImage(

                                //RETORNA A FOTO ESPECIFICA DO PRODUTO
                                "http://$_ip/contextmobile/findimagem?tipo=1&img=PRO_$produtoId.PNG&escala=1000",
                                headers: <String, String>{
                                  'authorization': basicAuth
                                }))),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        valorProduto = valorProduto - 1;
                                        valor.text = valorProduto.toString();
                                      });
                                    },
                                    icon: Icon(Icons.remove_circle_sharp),
                                    color: Colors.redAccent[700],
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          valorProduto = int.parse(value);
                                          valor.text = valorProduto.toString();
                                        });
                                      },
                                      controller: valor,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[350]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(9))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[350]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          //contentPadding: EdgeInsets.all(10),
                                          labelText: 'Insira o saldo',
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[800]
                                                  .withOpacity(0.4))),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        valorProduto = valorProduto + 1;
                                        valor.text = valorProduto.toString();
                                      });
                                    },
                                    icon: Icon(Icons.add_circle_sharp),
                                    color: Colors.blueAccent[700],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellow[600],
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    PostProduto().postProduto(context);
                                  },
                                  child: Text(
                                    'ADICIONAR PRODUTO',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(top: 5, right: 5),
                            child: Text(
                              produtoBalanco,
                              style: TextStyle(color: Colors.red[800]),
                            ),
                          )
                        ],
                      ),
                      height: MediaQuery.of(context).size.height / 3.4,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 5)
                          ]),
                    ),
                  ],
                ),
              ),
            ]))));
  }

  //ERRO ESPECIFICO PARA VALORES MENORES QUE ZERO NO SALDO DO PRODUTO

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
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
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
