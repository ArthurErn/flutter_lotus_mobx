import 'package:flutter/material.dart';
import 'package:lotus_erp/controllers/editar.os.controller.dart';
import 'package:lotus_erp/repository/clientes/listar_cliente_auth.dart';
import 'package:lotus_erp/repository/ordem_servico/atualizar_oficina.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:lotus_erp/repository/ordem_servico/persist.checklist.dart';
import 'package:lotus_erp/views/ordem_servico/alocar_tecnico.dart';
import 'package:lotus_erp/views/ordem_servico/checklist.dart';
import 'package:lotus_erp/views/ordem_servico/editar_cliente.dart';
import 'package:lotus_erp/views/ordem_servico/imagens_os.dart';
import 'package:lotus_erp/views/ordem_servico/ordem_oficina.dart';
import 'package:lotus_erp/views/ordem_servico/produtos_servico.dart';
import 'package:lotus_erp/repository/ordem_servico/process.data.os.dart';

var identificadorController = TextEditingController();
var controllerMarca = TextEditingController();
var controllerModelo = TextEditingController();
var controllerCor = TextEditingController();
var controllerFrota = TextEditingController();
var controllerChassi = TextEditingController();
var controllerKm = TextEditingController();
var controllerAno = TextEditingController();
var controllerReboque1 = TextEditingController();
var controllerReboque2 = TextEditingController();
var ordemIdentificadorSave;
var ordemSituacaoNomeSave;
var ordemClienteNomeSave;
var ordemClienteId;
var ordemIdPessoaSave;
var ordemTipoOsSave;
var ordemVeicMarcaSave;
var ordemVeicModeloSave;
var ordemVeicCorSave;
var ordemVeicFrotaSave;
var ordemVeicChassiSave;
var ordemVeicKmSave;
var ordemVeicAnoSave;
var ordemVeicReboque1Save;
var ordemVeicReboque2Save;
var combustivelSelecionado;
var selecionadoOS;
var selecionado2;
var reclamacaoDefeito = TextEditingController();
var constatadoResolvido = TextEditingController();
var obsOcorrencias = TextEditingController();
int indexTipoOs;
List combustivel = ['GASOLINA', 'ALCOOL', 'DIESEL', 'FLEX', 'GAS'];

List tipoOs = [
  'SERVIÇO',
  'GARANTIA',
  'INTERNA',
  'EXTERNA',
  'GARANTIA FABRICA',
  'GARANTIA EXTENDIDA',
  'GARANTIA SERVIÇOS',
  'FORA GARANTIA/PARTICULAR'
];
List situacao = [
  'RECEBIMENTO',
  'FINALIZADA',
  'ORÇAMENTO',
  'AGUARDANDO APROVAÇÃO',
  'NÃO APROVADA',
  'AGUARDANDO CONSERTO',
  'AGUARDANDO PEÇAS',
  'AGUARDANDO RETIRADA',
  'REABERTA',
  'ANÁLISE TÉCNICA',
  'RETIRADA',
  'REPARO EFETUADO',
  'AGUARDANDO PEÇAS/PEDIDO',
  'PRONTO/CRIAR GARANTIA',
  'AGENDADO',
  'VISITA TÉCNICA',
  'PROCESSO COLETA'
];

class EditarOrdemServico extends StatefulWidget {
  const EditarOrdemServico({Key key}) : super(key: key);

  @override
  _EditarOrdemServicoState createState() => _EditarOrdemServicoState();
}

class _EditarOrdemServicoState extends State<EditarOrdemServico> {
  @override
  void initState() {
    setState(() {
      PersistChecklist().get();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await postEditOficina().then((value) async {
              buscarController.text = "";
              oficina.ordemDisplayInfo();
              Navigator.pop(context);
            });
          },
          child: Container(
            width: 60,
            height: 80,
            child: Icon(
              Icons.check,
              size: 36,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Colors.blue[900], Colors.blue],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 6,
          shape: CircularNotchedRectangle(),
          color: Colors.blue[800],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Icon(
                  Icons.edit,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ImagensOS()));
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.blue[900], Colors.blue])),
          ),
          title: Row(
            children: [
              Text("OS " + ordemId.toString(), style:TextStyle(fontSize: 18)),
              Spacer(),
              Text("Status ", style:TextStyle(color: Colors.grey[200])),
              Text(ordemStatusNome)
            ],
          ),
          toolbarHeight: 65,
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          shadowColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 164,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            identificadorController.text = ordemIdentificador;
                          });

                          showEditarIdentificacao(context);
                        },
                        child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_pin,
                                  color: Colors.blue[800].withOpacity(.4),
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Identificação",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 240,
                                        child: Text(
                                          ordemClienteNome.length > 23
                                              ? ordemClienteNome.substring(
                                                      0, 23) +
                                                  "..."
                                              : ordemClienteNome,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        )),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      GestureDetector(
                        onTap: () {
                          showEditarVeiculo(context);
                        },
                        child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.time_to_leave,
                                  color: Colors.blue[800].withOpacity(.4),
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Veiculo",
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 240,
                                        child: Text(
                                          ordemVeicMarca == null
                                              ? 'NÃO INFORMADO'
                                              : ordemVeicMarca == ""
                                                  ? 'NÃO INFORMADO'
                                                  : ordemVeicMarca,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        )),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AlocarTecnico()));
                        },
                        child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.quick_contacts_dialer,
                                  color: Colors.blue[800].withOpacity(.4),
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Alocar Técnico",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProdutosServico()));
                        },
                        child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.home_repair_service,
                                  color: Colors.blue[800].withOpacity(.4),
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Produtos / Serviços",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckListOrdemOficina()));
                        },
                        child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.checklist,
                                  color: Colors.blue[800].withOpacity(.4),
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Checklist",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                      GestureDetector(
                        onTap: () {
                          showOcorrencia(context);
                        },
                        child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_alert,
                                  color: Colors.blue[800].withOpacity(.4),
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ocorrências",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_right_outlined,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  showEditarIdentificacao(BuildContext context) {
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
                    height: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            tipoCad = 1;
                            osController.getIdInfo();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditarIdentificacaoCliente()));
                          },
                          child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .3, color: Colors.black)),
                              child: Center(
                                child: Text(
                                  "Alterar cliente",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Tipo OS:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                        DropdownButton(
                          isExpanded: true,
                          hint: Text('SELECIONE O TIPO DE OS'),
                          value: ordemTipoOsSave,
                          items: tipoOs.map((selecionadoOS) {
                            return DropdownMenuItem(
                              value: selecionadoOS != null
                                  ? selecionadoOS
                                  : "SELECIONE O TIPO DE OS",
                              child: Text(selecionadoOS),
                            );
                          }).toList(),
                          onChanged: (valorNovo) {
                            setState(() {
                              selecionadoOS = valorNovo;
                              ordemTipoOsSave = valorNovo;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Situação:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                        DropdownButton(
                          isExpanded: true,
                          hint: Text('SELECIONE A SITUAÇÃO'),
                          value: selecionado2,
                          items: situacao.map((selecionado2) {
                            return DropdownMenuItem(
                              value: selecionado2 != null
                                  ? selecionado2
                                  : "SELECIONE A SITUAÇÃO",
                              child: Text(selecionado2),
                            );
                          }).toList(),
                          onChanged: (valorNovo) {
                            setState(() {
                              selecionado2 = valorNovo;
                              ordemSituacaoNomeSave = valorNovo;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (ordemIdentificadorSave != null) {
                                ordemIdentificador = ordemIdentificadorSave;
                                oficina.ordemDisplay[ordemIndex].identificador =
                                    ordemIdentificadorSave;
                              }
                              if (ordemTipoOsSave != null) {
                                ordemTipoOsNome = ordemTipoOsSave;
                                oficina.ordemDisplay[ordemIndex].tipoOsNome =
                                    ordemTipoOsNome;
                              }
                              if (ordemSituacaoNomeSave != null) {
                                ordemSituacaoNome = ordemSituacaoNomeSave;
                                oficina.ordemDisplay[ordemIndex].situacaoNome =
                                    ordemSituacaoNome;
                              }
                              if (ordemIdPessoaSave != null) {
                                ordemIdPessoa = ordemIdPessoaSave;
                                oficina.ordemDisplay[ordemIndex].idPessoa =
                                    ordemIdPessoaSave;
                              }
                              if (ordemClienteNomeSave != null) {
                                ordemClienteNome = ordemClienteNomeSave;
                                oficina.ordemDisplay[ordemIndex].clienteNome =
                                    ordemClienteNomeSave;
                              }
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border:
                                    Border.all(width: .3, color: Colors.black)),
                            child: Center(
                              child: Text(
                                "Salvar alterações",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
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
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {});
  }

  showEditarVeiculo(BuildContext context) {
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
                    height: 484,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Marca / Modelo",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3, color: Colors.black)),
                              height: 40,
                              width: 110,
                              child: TextField(
                                controller: controllerMarca,
                                onChanged: (valor) {
                                  ordemVeicMarcaSave = valor;
                                },
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3, color: Colors.black)),
                              height: 40,
                              width: 110,
                              child: TextField(
                                onChanged: (valor) {
                                  ordemVeicModeloSave = valor;
                                },
                                controller: controllerModelo,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Cor / Frota",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3, color: Colors.black)),
                              height: 40,
                              width: 110,
                              child: TextField(
                                onChanged: (valor) {
                                  ordemVeicCorSave = valor;
                                },
                                controller: controllerCor,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3, color: Colors.black)),
                              height: 40,
                              width: 110,
                              child: TextField(
                                onChanged: (valor) {
                                  ordemVeicFrotaSave = valor;
                                },
                                controller: controllerFrota,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Chassi",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.3, color: Colors.black)),
                          height: 40,
                          width: 240,
                          child: TextField(
                            onChanged: (valor) {
                              ordemVeicChassiSave = valor;
                            },
                            controller: controllerChassi,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "KM / Ano",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3, color: Colors.black)),
                              height: 40,
                              width: 110,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (valor) {
                                  ordemVeicKmSave = valor;
                                },
                                controller: controllerKm,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3, color: Colors.black)),
                              height: 40,
                              width: 110,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (valor) {
                                  ordemVeicAnoSave = valor;
                                },
                                controller: controllerAno,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Reboques",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Row(children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.3, color: Colors.black)),
                            height: 40,
                            width: 110,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (valor) {
                                ordemVeicReboque1Save = valor;
                              },
                              controller: controllerReboque1,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.3, color: Colors.black)),
                            height: 40,
                            width: 110,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (valor) {
                                ordemVeicReboque2Save = valor;
                              },
                              controller: controllerReboque2,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              style: TextStyle(fontSize: 22),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Combustível",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                          isExpanded: true,
                          hint: Text('SELECIONAR COMBUSTÍVEL'),
                          value: combustivelSelecionado,
                          items: combustivel.map((combustivelSelecionado) {
                            return DropdownMenuItem(
                              value: combustivelSelecionado != null
                                  ? combustivelSelecionado
                                  : "SELECIONAR COMBUSTÍVEL",
                              child: Text(combustivelSelecionado),
                            );
                          }).toList(),
                          onChanged: (valorNovo) {
                            setState(() {
                              combustivelSelecionado = valorNovo;
                            });
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (ordemVeicMarcaSave != null ||
                                  ordemVeicMarcaSave != "") {
                                ordemVeicMarca = ordemVeicMarcaSave;
                                oficina.ordemDisplay[ordemIndex].veicMarca =
                                    ordemVeicMarca;
                              }
                              if (ordemVeicModeloSave != null ||
                                  ordemVeicModeloSave != "") {
                                ordemVeicModelo = ordemVeicModeloSave;
                                oficina.ordemDisplay[ordemIndex].veicModelo =
                                    ordemVeicModelo;
                              }
                              if (ordemVeicCorSave != null ||
                                  ordemVeicModeloSave != "") {
                                ordemVeicCor = ordemVeicCorSave;
                                oficina.ordemDisplay[ordemIndex].veicCor =
                                    ordemVeicCor;
                              }
                              if (ordemVeicFrotaSave != null ||
                                  ordemVeicFrotaSave != "") {
                                ordemVeicFrota = ordemVeicFrotaSave;
                                oficina.ordemDisplay[ordemIndex].veicFrota =
                                    ordemVeicFrota;
                              }
                              if (ordemVeicChassiSave != null ||
                                  ordemVeicChassiSave != "") {
                                ordemVeicChassi = ordemVeicChassiSave;
                                oficina.ordemDisplay[ordemIndex].veicChassi =
                                    ordemVeicChassi;
                              }
                              if (ordemVeicKmSave != null ||
                                  ordemVeicKmSave != "") {
                                ordemVeicKm = ordemVeicKmSave;
                                oficina.ordemDisplay[ordemIndex].veicKm =
                                    ordemVeicKm;
                              }
                              if (ordemVeicAnoSave != null ||
                                  ordemVeicAnoSave != "") {
                                ordemVeicAno = ordemVeicAnoSave;
                                oficina.ordemDisplay[ordemIndex].veicAno =
                                    ordemVeicAno;
                              }
                              if (ordemVeicReboque1Save != null ||
                                  ordemVeicReboque1Save != "") {
                                ordemVeicReboque1 = ordemVeicReboque1Save;
                                oficina.ordemDisplay[ordemIndex].veicReboque1 =
                                    ordemVeicReboque1;
                              }
                              if (ordemVeicReboque2Save != null ||
                                  ordemVeicReboque2Save != "") {
                                ordemVeicReboque2 = ordemVeicReboque2Save;
                                oficina.ordemDisplay[ordemIndex].veicReboque2 =
                                    ordemVeicReboque2;
                              }
                              if (combustivelSelecionado != null ||
                                  combustivelSelecionado != "") {
                                var combust =
                                    combustivel.indexOf(combustivelSelecionado);
                                ordemVeicCombustivel = combust;
                                oficina.ordemDisplay[ordemIndex]
                                    .veicCombustivel = combust;
                              }
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: .3, color: Colors.black),
                                color: Colors.grey[300]),
                            height: 45,
                            width: 240,
                            child: Center(
                              child: Text("Salvar alterações",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
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
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {});
  }

  showOcorrencia(BuildContext context) {
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
                        height: 490,
                        width: 200,
                        child: Column(
                          children: [
                            Text("Reclamação / Defeito",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: .8, color: Colors.black)),
                                width: 245,
                                height: 120,
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  controller: reclamacaoDefeito,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Constatado / Resolvido",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: .8, color: Colors.black)),
                                width: 245,
                                height: 120,
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  controller: constatadoResolvido,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Obs / Ocorrências",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: .8, color: Colors.black)),
                                width: 245,
                                height: 120,
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  controller: obsOcorrencias,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                )),
                            SizedBox(
                              height: 18,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 35,
                                width: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blue[900]),
                                child: Center(
                                  child: Text(
                                    "SALVAR OCORRÊNCIAS",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {});
  }
}
