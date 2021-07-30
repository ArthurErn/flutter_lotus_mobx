import 'package:flutter/material.dart';
import 'package:lotus_erp/repository/ordem_servico/inserir_item.dart';
import 'package:lotus_erp/repository/ordem_servico/listar_produtos.dart';
import 'package:lotus_erp/repository/vendas/dropdown_venda_auth.dart';
import 'package:lotus_erp/constructors/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/pages/ordem_servico/adicionar_produto.dart';
import 'package:lotus_erp/pages/ordem_servico/editar_os.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';
import 'package:lotus_erp/pages/vendas/layout/adicionar_quantidade.dart';
import 'package:lotus_erp/pages/vendas/nova_venda.dart';

List<Produtos> listaProdutoOS = [];
var porcentagemOrdemProduto;
var porcentagemOrdemServico;
var desconto;
var valorDesconto;
var valorDescontoServico;
var valorDescontoProdutos;
var porcentagemProdutoController = TextEditingController();
var descontoProdutoController = TextEditingController();
var porcentagemServicoController = TextEditingController();
var descontoServicoController = TextEditingController();

class ProdutosServico extends StatefulWidget {
  const ProdutosServico({Key key}) : super(key: key);

  @override
  _ProdutosServicoState createState() => _ProdutosServicoState();
}

class _ProdutosServicoState extends State<ProdutosServico> {
  @override
  void initState() {
    setState(() {
      descontoProdutoController =
          TextEditingController(text: descontoProdutos.toString());
      descontoServicoController =
          TextEditingController(text: descontoServico.toString());
      calcularTotal();

      formas.clear();
      selecionadoVenda = null;
    });
    getListarProdutosOS().then((value) {
      setState(() {
        produtosOS = value;
      });
    });
    getFormaPagamento().then((value) {
      setState(() {
        formas = value;
        // selecionadoVenda = formas.indexOf(fpagtoDescricao);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.blue[900], Colors.blue[600]])),
        ),
        title: Text("Produtos / Serviço"),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        toolbarHeight: 65,
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditarOrdemServico()));
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 5, bottom: 10),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.15,
                width: 330,
                decoration: BoxDecoration(
                    border: Border.all(width: .6, color: Colors.black)),
                child: ListView.builder(
                    itemCount: produtosOS.length,
                    itemBuilder: (context, index) {
                      return listaProdutosOS(context, index);
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 165,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(width: .6, color: Colors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 21,
                        width: 165,
                        color: Colors.blue[900],
                        child: Center(
                          child: Text(
                            "Total produtos",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          formatter.format(totalLiquidoProdutos).toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 165,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: .6, color: Colors.black),
                    top: BorderSide(width: .6, color: Colors.black),
                    right: BorderSide(width: .6, color: Colors.black),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 21,
                        width: 165,
                        color: Colors.blue[900],
                        child: Center(
                          child: Text(
                            "Total serviço",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          formatter.format(totalLiquidoServico).toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              width: 330,
              decoration: BoxDecoration(
                  border: Border.all(width: .7, color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 165,
                      color: Colors.blue[900],
                      child: Center(
                        child: Text(
                          "TOTAL GERAL",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDesconto();
                      },
                      child: Image.asset(
                        'lib/assets/images/desconto.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Text(
                      formatter.format(totalOrdemGeral).toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              margin: EdgeInsets.only(left: 6),
              child: DropdownButton(
                hint: Text(
                  'EDITAR FORMA DE PAGAMENTO',
                  style: TextStyle(fontSize: 14),
                ),
                value: selecionadoVenda,
                style: TextStyle(fontSize: 14, color: Colors.black),
                items: formas.map((selecionadoVenda) {
                  return DropdownMenuItem(
                    value: selecionadoVenda != null
                        ? selecionadoVenda
                        : "EDITAR FORMA DE PAGAMENTO",
                    child: Text(selecionadoVenda.descricao),
                  );
                }).toList(),
                onChanged: (valorNovo) {
                  setState(() {
                    selecionadoVenda = valorNovo;
                    fpagtoId = selecionadoVenda.id;
                  });
                },
              ),
            ),
            SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdicionarProdutoOrdemServico()));
              },
              child: Container(
                width: 330,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    border: Border.all(width: .7, color: Colors.black)),
                child: Center(
                  child: Text(
                    'Adicionar produto/serviço',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  listaProdutosOS(context, index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  produtosOS[index].idProduto.toString(),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  produtosOS[index].produtoNome.length > 26
                      ? produtosOS[index].produtoNome.substring(0, 25) + "..."
                      : produtosOS[index].produtoNome,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                Text(
                  produtosOS[index].unidade,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Text(
                  produtosOS[index].qtde.toString() + " x ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  formatter.format(produtosOS[index].vlrVendido).toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Text(
                  "TOTAL: " +
                      formatter
                          .format(produtosOS[index].vlrVendido *
                              produtosOS[index].qtde)
                          .toString(),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: 300,
              height: 1,
              color: Colors.grey[400],
            )
          ],
        ),
      ),
    );
  }

  showDesconto() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              height: 190,
              width: 270,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Descontos",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Produtos",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      width: 300,
                      height: 30,
                      decoration: BoxDecoration(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 66,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .6, color: Colors.black)),
                              child: TextField(
                                controller: porcentagemProdutoController,
                                onChanged: (porcentagem) {
                                  setState(() {
                                    porcentagemOrdemProduto =
                                        double.parse(porcentagem);

                                    desconto = (totalProdutosOrdem *
                                        porcentagemOrdemProduto /
                                        100);
                                    descontoProdutoController.text =
                                        formatter.format(desconto).toString();
                                    totalLiquidoProdutos =
                                        totalProdutosOrdem - desconto;
                                    totalOrdemGeral = totalLiquidoServico +
                                        totalLiquidoProdutos;
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: "%", border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              width: 18,
                            ),
                            Container(
                              height: 30,
                              width: 69,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .6, color: Colors.black)),
                              child: TextField(
                                controller: descontoProdutoController,
                                onChanged: (valor) {
                                  setState(() {
                                    valorDesconto = double.parse(valor);
                                    totalLiquidoProdutos =
                                        totalProdutosOrdem - valorDesconto;
                                    porcentagemProdutoController.text =
                                        formatter
                                            .format((valorDesconto * 100) /
                                                totalProdutosOrdem)
                                            .toString();
                                    totalOrdemGeral = totalLiquidoServico +
                                        totalLiquidoProdutos;
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: "Valor",
                                    border: InputBorder.none),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Serviços",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 66,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: .6, color: Colors.black)),
                          child: TextField(
                            controller: porcentagemServicoController,
                            onChanged: (porcentagem) {
                              setState(() {
                                porcentagemOrdemServico =
                                    double.parse(porcentagem);

                                desconto = (totalServicoOrdem *
                                    porcentagemOrdemServico /
                                    100);
                                descontoServicoController.text =
                                    formatter.format(desconto).toString();
                                totalLiquidoServico =
                                    totalServicoOrdem - desconto;
                                totalOrdemGeral =
                                    totalLiquidoServico + totalLiquidoProdutos;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "%", border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          height: 30,
                          width: 69,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: .6, color: Colors.black)),
                          child: TextField(
                            controller: descontoServicoController,
                            onChanged: (valor) {
                              setState(() {
                                valorDesconto = double.parse(valor);
                                totalLiquidoServico =
                                    totalServicoOrdem - valorDesconto;
                                totalOrdemGeral =
                                    totalLiquidoServico + totalLiquidoProdutos;
                                porcentagemServicoController.text = formatter
                                    .format((valorDesconto * 100) /
                                        totalServicoOrdem)
                                    .toString();
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "Valor", border: InputBorder.none),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
