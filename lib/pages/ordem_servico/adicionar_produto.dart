import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotus_erp/controllers/editar.os.controller.dart';
import 'package:lotus_erp/repository/consulta_produtos/consulta_auth.dart';
import 'package:lotus_erp/repository/ordem_servico/inserir_item.dart';
import 'package:lotus_erp/repository/ordem_servico/listar_produtos.dart';
import 'package:lotus_erp/constructors/balanco_estoque/construtor_categoria.dart';
import 'package:lotus_erp/constructors/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/pages/balanco_estoque/functions/balanco_barcode.dart';
import 'package:lotus_erp/pages/login/login_page.dart';
import 'package:lotus_erp/pages/ordem_servico/editar_os.dart';
import 'package:lotus_erp/pages/ordem_servico/produtos_servico.dart';
import 'package:lotus_erp/pages/vendas/layout/adicionar_quantidade.dart';
import 'package:lotus_erp/pages/vendas/vendas_page.dart';

Produtos produtosOrdem;
dynamic totalProdutosOrdem = 0;
dynamic totalServicoOrdem = 0;
dynamic totalLiquidoProdutos = 0;
dynamic totalLiquidoServico = 0;
dynamic totalOrdemGeral = 0;
dynamic quantidadeProdutoOrdem = 0;
List<int> quantidadeLista = [];

var quantidadeController = TextEditingController(text: '0');

int valorId;
String produtoId;
String produtoBalanco;
var _usuario = configLoginControllerText;
var _senha = passControllerText;
var _ip = ipControllerText;
var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));

calcularTotal() {
  var aux = 0;
  totalLiquidoServico = 0;
  totalLiquidoProdutos = 0;
  totalProdutosOrdem = 0;
  totalServicoOrdem = 0;
  getListarProdutosOS().then((value) {
    osController.produtosOS = value;
    for (var u in osController.produtosOS) {
      if (osController.produtosOS[aux].servico == 1) {
        totalServicoOrdem = totalServicoOrdem +
            (osController.produtosOS[aux].vlrVendido * osController.produtosOS[aux].qtde);
        totalLiquidoServico =
            totalServicoOrdem - double.parse(descontoServicoController.text);
      } else {
        totalProdutosOrdem = totalProdutosOrdem +
            (osController.produtosOS[aux].vlrVendido * osController.produtosOS[aux].qtde);
        totalLiquidoProdutos =
            totalProdutosOrdem - double.parse(descontoProdutoController.text);
      }

      aux++;
    }
    totalOrdemGeral = totalLiquidoProdutos + totalLiquidoServico;
  });
}

class AdicionarProdutoOrdemServico extends StatefulWidget {
  @override
  _AdicionarProdutoOrdemServicoState createState() =>
      _AdicionarProdutoOrdemServicoState();
}

class _AdicionarProdutoOrdemServicoState
    extends State<AdicionarProdutoOrdemServico> {
  var valorController = TextEditingController(text: valorCodigoBarrasProduto);
  List<Produtos> produtoEstoqueAdd = List<Produtos>();
  List<Produtos> produtoEstoqueAddDisplay = List<Produtos>();
  List<GrupoProdutos> grupoValue = [];
  List<GrupoProdutos> grupoDisplay = [];

  @override
  void initState() {
    // TIPO = DIGITADO OU BARCODE
    tipo = 1;
    pvalor = "";
    quantidadeController.text = '0';
    getProdutos().then((value) {
      setState(() {
        produtoEstoqueAdd.addAll(value);
        produtoEstoqueAddDisplay = produtoEstoqueAdd;
        if (valorCodigoBarrasProduto != null) {
          setState(() {
            produtoEstoqueAddDisplay = produtoEstoqueAdd.where((produto) {
              var produtoGtin = produto.gtin;
              if (produtoGtin != null) {
                return produtoGtin.contains(valorCodigoBarrasProduto);
              } else {
                return false;
              }
            }).toList();
          });
        }
      });
    });
    getGrupo().then((value) {
      setState(() {
        grupoValue.addAll(value);
        grupoDisplay = grupoValue;
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
              title: Text("Produtos"), backgroundColor: Colors.blue[900]),
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
                child: Column(children: [
                  searchBar(),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: grupoDisplay?.length ?? 0,
                        itemBuilder: (context, index) {
                          return listGrupo(context, index);
                        },
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    //borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: produtoEstoqueAddDisplay.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (produtoEstoqueAddDisplay.length > 0) {
                          return listProduto(context, index);
                        } else if (produtoEstoqueAddDisplay.length == 1) {
                          getProdutos().then((value) {
                            setState(() {
                              produtoEstoqueAdd.addAll(value);
                              produtoEstoqueAddDisplay = produtoEstoqueAdd;
                            });
                            return listProduto(context, index);
                          });
                        } else {
                          return Center();
                        }
                      }))
            ]),
          )),
    );
  }

  listGrupo(BuildContext context, index) {
    String grupoId = grupoValue[index].idGrupoFormatado;
    return GestureDetector(
      onTap: () {
        List<Produtos> produtosGrupo = List<Produtos>();
        setState(() {
          tipo = 5;
          pvalor = grupoValue[index].idGrupo.toString();
          getProdutos().then((value) {
            setState(() {
              produtosGrupo.addAll(value);
              produtoEstoqueAddDisplay = produtosGrupo;
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
                          "http://$_ip/contextmobile/findimagem?tipo=4&img=GRU_$grupoId.PNG&escala=1000",
                          headers: <String, String>{
                            'authorization': basicAuth
                          }),
                      height: 40),
                  SizedBox(
                    height: 5,
                  ),
                  Text(grupoDisplay[index].grupoDescricao,
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
    produtoId = produtoEstoqueAddDisplay[index].id_produto_formatado;
    return GestureDetector(
      onTap: () {
        setState(() {
          produtoBalanco = produtoEstoqueAddDisplay[index].descricao;
          valorProduto = 1;
          idEmpresa = produtoEstoqueAddDisplay[index].id_empresa;
          idProduto = produtoEstoqueAddDisplay[index].id_produto;
          idProdutoFormatado =
              produtoEstoqueAddDisplay[index].id_produto_formatado;
          descricao = produtoEstoqueAddDisplay[index].descricao;
          unidade = produtoEstoqueAddDisplay[index].unidade;
          refFabrica = produtoEstoqueAddDisplay[index].ref_fabrica;
          gtin = produtoEstoqueAddDisplay[index].gtin;
          fabricanteNome = produtoEstoqueAddDisplay[index].fabricante_nome;
          produtoCompra = produtoEstoqueAddDisplay[index].produto_pcompra;
          produtoCusto = produtoEstoqueAddDisplay[index].produto_pcusto;
          produtoVenda = produtoEstoqueAddDisplay[index].produto_pvenda;
          produtoSaldo = produtoEstoqueAddDisplay[index].produto_saldo;
          grupoId = produtoEstoqueAddDisplay[index].grupo_id;
          grupoDescricao = produtoEstoqueAddDisplay[index].grupo_descricao;
          servico = produtoEstoqueAddDisplay[index].servico;

          Navigator.pop(context);
          showQuantidade();
        });
      },
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Container(
            height: 145,
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
                      height: 145,
                      width: 65,

                      //ROTA PARA TRAZER AS IMAGENS DOS PRODUTOS
                      image: NetworkImage(
                          "http://$_ip/contextmobile/findimagem?tipo=1&img=PRO_$produtoId.PNG&escala=3000",
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
                              produtoEstoqueAddDisplay[index]
                                  .id_produto
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
                            produtoEstoqueAddDisplay[index].descricao,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(height: 3),
                          Text(
                            produtoEstoqueAddDisplay[index].fabricante_nome,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.normal,
                                fontSize: 13),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "R\$" +
                                formatoValores
                                    .format(produtoEstoqueAddDisplay[index]
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
            produtoEstoqueAddDisplay = produtoEstoqueAdd.where((produto) {
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
            }).toList();
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
            icon: Icon(Icons.qr_code_scanner_rounded),
            color: Colors.yellow[700],
          ),
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

  showQuantidade() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              height: 140,
              width: 300,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Adicionar quantidade",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: .4, color: Colors.black)),
                    width: 230,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        onChanged: (valor) {
                          if (valor != "") {
                            quantidadeProdutoOrdem = int.parse(valor);
                          }
                        },
                        controller: quantidadeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Adicionar quantidade"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (servico == 0) {
                        produtosOrdem = Produtos(
                            idEmpresa,
                            idProduto,
                            idProdutoFormatado,
                            descricao,
                            unidade,
                            refFabrica,
                            gtin,
                            fabricanteNome,
                            produtoCompra,
                            produtoCusto,
                            produtoVenda,
                            produtoSaldo,
                            grupoId,
                            grupoDescricao,
                            servico);
                      }
                      if (servico == 1) {
                        produtosOrdem = Produtos(
                            idEmpresa,
                            idProduto,
                            idProdutoFormatado,
                            descricao,
                            unidade,
                            refFabrica,
                            gtin,
                            fabricanteNome,
                            produtoCompra,
                            produtoCusto,
                            produtoVenda,
                            produtoSaldo,
                            grupoId,
                            grupoDescricao,
                            servico);
                      }
                      await postItem().then((value) async {
                        calcularTotal();
                        await Future.delayed(Duration(seconds: 1))
                            .then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProdutosServico()));
                        });
                      });
                    },
                    child: Container(
                      color: Colors.blue[900],
                      width: 230,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ),
          );
        });
  }
}
