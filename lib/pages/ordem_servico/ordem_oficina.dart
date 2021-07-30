import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/ordem_oficina_controller.dart';
import 'package:lotus_erp/repository/clientes/listar_cliente_auth.dart';
import 'package:lotus_erp/repository/ordem_servico/inserir_oficina.dart';
import 'package:lotus_erp/repository/ordem_servico/ordem_servico_auth.dart';
import 'package:lotus_erp/repository/vendas/dropdown_venda_auth.dart';
import 'package:lotus_erp/constructors/ordem_servico/ordem_servico.dart';
import 'package:lotus_erp/pages/ordem_servico/adicionar_cliente.dart';
import 'package:lotus_erp/pages/ordem_servico/alocar_tecnico.dart';
import 'package:lotus_erp/pages/ordem_servico/editar_os.dart';
import 'package:lotus_erp/pages/ordem_servico/produtos_servico.dart';
import 'package:lotus_erp/pages/vendas/nova_venda.dart';

var identificadorControllerAdd = TextEditingController();
var buscarController = TextEditingController();
var ordemId;
var ordemStatusNome;
var ordemClienteNome;
var ordemIdentificador;
var ordemTecnicoNome;
var ordemTotGeralLiquido;
var descontoServico;
var descontoProdutos;
var ordemIndex;
var ordemIdPessoa;
var ordemEntradaData;
var ordemEntradaHora;
var ordemIdEmpresa;
var ordemEmpresaFantasia;
var ordemTecnicoId;
var ordemPadraoMarca;
var ordemPadraoModelo;
var ordemVeicMarca;
var ordemVeicModelo;
var ordemVeicCor;
var ordemVeicFrota;
var ordemVeicChassi;
var ordemVeicKm;
var ordemVeicAno;
var ordemVeicReboque1;
var ordemVeicReboque2;
var ordemVeicCombustivel;
var ordemTipoOsNome;
var ordemSituacaoNome;
var ordemDefeitoReclamado;
var ordemDefeitoConstado;
var ordemPadraoObs;
var ckAntenas;
var ckCalotas;
var ckTapetes;
var ckRadio;
var ckExtintor;
var ckDocumentos;
var ckManual;
var ckChaveRodas;
var ckMacaco;
var ckTriangulo;
var ckTriangulo1;
var ckExtra1;
var ckExtra2;
var ckExtra3;
var ckExtra4;
var ckExtra5;
var ckPneuDdBom;
var ckPneuDdReg;
var ckPneuDdRui;
var ckPneuDeBom;
var ckPneuDeReg;
var ckPneuDeRui;
var ckPneuTdBom;
var ckPneuTdReg;
var ckPneuTdRui;
var ckPneuTeBom;
var ckPneuTeReg;
var ckPneuTeRui;
var ckPneuEstBom;
var ckPneuEstReg;
var ckPneuEstRui;
var ckCombo1;
var ckCombo34;
var ckCombo12;
var ckCombo14;
var ckCombo0;
var fpagtoId;
var fpagtoDescricao;

List<Ordem> ordem = [];

class OrdemServicoOficina extends StatefulWidget {
  const OrdemServicoOficina({Key key}) : super(key: key);

  @override
  _OrdemServicoOficinaState createState() => _OrdemServicoOficinaState();
}

class _OrdemServicoOficinaState extends State<OrdemServicoOficina> {
  final oficina = OrdemOficinaController();
  @override
  void initState() {
    setState(() {
      getFormaPagamento().then((value) {
        formas = value;
      });
      buscarController = TextEditingController(text: "");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        elevation: 8,
        backgroundColor: Colors.blue[900],
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            size: 35,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              shape: BoxShape.rectangle,
              gradient:
                  LinearGradient(colors: [Colors.blue[900], Colors.blue])),
        ),
        onPressed: () {
          showAdicionarOficina(context);
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.blue[900], Colors.blue])),
        ),
        title: Text("Ordem de Serviço"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        toolbarHeight: 65,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1.2, color: Colors.grey[300]))),
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: .4, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 147,
                              child: TextFormField(
                                controller: buscarController,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    hintText: "Pesquisar OS",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    border: InputBorder.none),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            oficina.ordemDisplayInfo();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            width: 100,
                            height: 50,
                            child: Center(
                                child: Text(
                              "Buscar",
                              style:
                                  TextStyle(fontSize: 19, color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Observer(builder: (_) {
              return Container(
                  height: MediaQuery.of(context).size.height - 183,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: oficina.ordemDisplay != null
                          ? oficina.ordemDisplay.length
                          : 0,
                      itemBuilder: (BuildContext context, int index) {
                        if (oficina.ordemDisplay != null) {
                          return listOrdem(context, index);
                        } else {
                          return Center(
                            child: Container(
                              child: Text(
                                "Busque por uma OS",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }
                      }));
            }),
          ],
        ),
      ),
    );
  }

  Widget listOrdem(BuildContext context, index) {
    if (oficina.ordemDisplay[index].defeitoReclamado == null) {
      oficina.ordemDisplay[index].defeitoReclamado = "";
    }
    return Container(
      height: oficina.ordemDisplay[index].defeitoReclamado.length > 31
          ? 255.1
          : 235.1,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[400],
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  oficina.ordemDisplay[index].id.toString(),
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        listaProdutoOS.clear();
                        tecnicos.clear();
                        ordemStatusNome =
                            oficina.ordemDisplay[index].statusNome;
                        ordemId = oficina.ordemDisplay[index].id;
                        ordemEntradaData =
                            oficina.ordemDisplay[index].entradaData;
                        ordemEntradaHora =
                            oficina.ordemDisplay[index].entradaHora;
                        ordemIdEmpresa = oficina.ordemDisplay[index].idEmpresa;
                        ordemEmpresaFantasia =
                            oficina.ordemDisplay[index].empresaFantasia;
                        ordemIdPessoa = oficina.ordemDisplay[index].idPessoa;
                        ordemClienteNome =
                            oficina.ordemDisplay[index].clienteNome;
                        ordemTecnicoId = oficina.ordemDisplay[index].tecnicoId;
                        ordemTecnicoNome =
                            oficina.ordemDisplay[index].tecnicoNome;
                        ordemIdentificador =
                            oficina.ordemDisplay[index].identificador;
                        ordemPadraoMarca =
                            oficina.ordemDisplay[index].padraoMarca;
                        ordemPadraoModelo =
                            oficina.ordemDisplay[index].padraoModelo;
                        ordemVeicMarca = oficina.ordemDisplay[index].veicMarca;
                        ordemVeicModelo =
                            oficina.ordemDisplay[index].veicModelo;
                        ordemVeicCor = oficina.ordemDisplay[index].veicCor;
                        ordemVeicFrota = oficina.ordemDisplay[index].veicFrota;
                        ordemVeicChassi =
                            oficina.ordemDisplay[index].veicChassi;
                        ordemVeicKm = oficina.ordemDisplay[index].veicKm;
                        ordemVeicAno = oficina.ordemDisplay[index].veicAno;
                        ordemVeicReboque1 =
                            oficina.ordemDisplay[index].veicReboque1;
                        ordemVeicReboque2 =
                            oficina.ordemDisplay[index].veicReboque2;
                        ordemVeicCombustivel =
                            oficina.ordemDisplay[index].veicCombustivel;

                        ordemTotGeralLiquido =
                            oficina.ordemDisplay[index].totGeralLiquido;
                        descontoServico =
                            oficina.ordemDisplay[index].totServicosDescVlr;
                        descontoProdutos =
                            oficina.ordemDisplay[index].totPecasDescVlr;
                        ordemTipoOsNome =
                            oficina.ordemDisplay[index].tipoOsNome;
                        ordemSituacaoNome =
                            oficina.ordemDisplay[index].situacaoNome;
                        ordemStatusNome =
                            oficina.ordemDisplay[index].statusNome;
                        ordemDefeitoReclamado =
                            oficina.ordemDisplay[index].defeitoReclamado;
                        ordemDefeitoConstado =
                            oficina.ordemDisplay[index].defeitoConstatado;
                        ordemPadraoObs = oficina.ordemDisplay[index].padraoObs;

                        ckAntenas = oficina.ordemDisplay[index].ckAntena;
                        ckCalotas = oficina.ordemDisplay[index].ckCalotas;
                        ckTapetes = oficina.ordemDisplay[index].ckTapetes;
                        ckRadio = oficina.ordemDisplay[index].ckRadio;
                        ckExtintor = oficina.ordemDisplay[index].ckExtintor;
                        ckDocumentos = oficina.ordemDisplay[index].ckDocumentos;
                        ckManual = oficina.ordemDisplay[index].ckManual;
                        ckChaveRodas = oficina.ordemDisplay[index].ckChaveRodas;
                        ckMacaco = oficina.ordemDisplay[index].ckMacaco;
                        ckTriangulo = oficina.ordemDisplay[index].ckTriangulo;
                        ckTriangulo1 = oficina.ordemDisplay[index].ckTriangulo1;

                        ckExtra1 = oficina.ordemDisplay[index].ckExtra1;
                        ckExtra2 = oficina.ordemDisplay[index].ckExtra2;
                        ckExtra3 = oficina.ordemDisplay[index].ckExtra3;
                        ckExtra4 = oficina.ordemDisplay[index].ckExtra4;
                        ckExtra5 = oficina.ordemDisplay[index].ckExtra5;

                        ckPneuDdBom = oficina.ordemDisplay[index].ckPneuDdBom;
                        ckPneuDdReg = oficina.ordemDisplay[index].ckPneuDdReg;
                        ckPneuDdRui = oficina.ordemDisplay[index].ckPneuDdRui;

                        ckPneuDeBom = oficina.ordemDisplay[index].ckPneuDeBom;
                        ckPneuDeReg = oficina.ordemDisplay[index].ckPneuDeReg;
                        ckPneuDeRui = oficina.ordemDisplay[index].ckPneuDeRui;

                        ckPneuTdBom = oficina.ordemDisplay[index].ckPneuTdBom;
                        ckPneuTdReg = oficina.ordemDisplay[index].ckPneuTdReg;
                        ckPneuTdRui = oficina.ordemDisplay[index].ckPneuTdRui;

                        ckPneuTeBom = oficina.ordemDisplay[index].ckPneuTeBom;
                        ckPneuTeReg = oficina.ordemDisplay[index].ckPneuTeReg;
                        ckPneuTeRui = oficina.ordemDisplay[index].ckPneuTeRui;

                        ckPneuEstBom = oficina.ordemDisplay[index].ckPneuEstBom;
                        ckPneuEstReg = oficina.ordemDisplay[index].ckPneuEstReg;
                        ckPneuEstRui = oficina.ordemDisplay[index].ckPneuEstRui;

                        ckCombo1 = oficina.ordemDisplay[index].ckComb1;
                        ckCombo34 = oficina.ordemDisplay[index].ckComb34;
                        ckCombo12 = oficina.ordemDisplay[index].ckComb12;
                        ckCombo14 = oficina.ordemDisplay[index].ckComb14;
                        ckCombo0 = oficina.ordemDisplay[index].ckComb0;

                        fpagtoId = oficina.ordemDisplay[index].fpagtoId != null
                            ? oficina.ordemDisplay[index].fpagtoId
                            : 1;
                        fpagtoDescricao =
                            oficina.ordemDisplay[index].fpagtoDescricao;

                        ordemIndex = index;
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditarOrdemServico()));
                    },
                    icon: Icon(Icons.settings))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              oficina.ordemDisplay[index].clienteNome.length > 30
                  ? oficina.ordemDisplay[index].clienteNome.substring(0, 30) +
                      "..."
                  : oficina.ordemDisplay[index].clienteNome,
              style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.blue[900],
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  oficina.ordemDisplay[index].entradaData,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.alarm,
                  color: Colors.blue[900],
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  oficina.ordemDisplay[index].entradaHora,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 22,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          oficina.ordemDisplay[index].statusNome == "CONCLUIDA"
                              ? Colors.blue[900]
                              : oficina.ordemDisplay[index].statusNome ==
                                      "CANCELADA"
                                  ? Colors.red
                                  : Colors.cyan[900]),
                  height: 28,
                  width: 100,
                  child: Center(
                      child: Text(
                    oficina.ordemDisplay[index].statusNome,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              oficina.ordemDisplay[index].identificador != null
                  ? oficina.ordemDisplay[index].identificador
                  : "NÃO INFORMADO",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Text(
                  oficina.ordemDisplay[index].veicMarca != null
                      ? oficina.ordemDisplay[index].veicMarca
                      : "NÃO INFORMADO",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 60,
                ),
                Text(
                  oficina.ordemDisplay[index].veicModelo != null
                      ? oficina.ordemDisplay[index].veicModelo
                      : "NÃO INFORMADO",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              oficina.ordemDisplay[index].defeitoReclamado == null
                  ? "NÃO INFORMADO"
                  : oficina.ordemDisplay[index].defeitoReclamado == ""
                      ? "NÃO INFORMADO"
                      : oficina.ordemDisplay[index].defeitoReclamado,
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  showAdicionarOficina(BuildContext context) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                content: SingleChildScrollView(
                  child: Container(
                    width: 290,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Identificador",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: .7, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              controller: identificadorControllerAdd,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Digite uma placa"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  tipoCad = 1;
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdicionarCliente()))
                                      .then((value) {
                                    showAdicionarOficina(context);
                                  });
                                },
                                icon: Icon(Icons.add_circle_outline_rounded)),
                            Text(
                              " Selecione um cliente",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          ordemClienteNomeSave == null
                              ? ""
                              : ordemClienteNomeSave.length > 25
                                  ? ordemClienteNomeSave
                                      .toString()
                                      .substring(0, 24)
                                  : ordemClienteNomeSave.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (identificadorControllerAdd.text.length > 0) {
                              oficina.postOrdemOficina();
                              Navigator.of(context).pop();
                            } else {
                              showErroAdicionarOrdem();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.blue[900]),
                            width: 290,
                            height: 36,
                            child: Center(
                                child: Text(
                              "Adicionar Ordem",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  showErroAdicionarOrdem() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 190,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/alerta.png',
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Por favor informe um identificador',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          );
        });
  }
}
