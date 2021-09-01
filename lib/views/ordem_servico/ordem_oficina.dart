import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lotus_erp/controllers/editar.pedido.controller.dart';
import 'package:lotus_erp/controllers/ordem_oficina_controller.dart';
import 'package:lotus_erp/repository/clientes/listar_cliente_auth.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:lotus_erp/model/ordem_servico/ordem_servico.dart';
import 'package:lotus_erp/views/ordem_servico/adicionar_cliente.dart';
import 'package:lotus_erp/views/ordem_servico/editar_os.dart';
List<Ordem> ordem = [];
final oficina = OrdemOficinaController();

class OrdemServicoOficina extends StatefulWidget {
  const OrdemServicoOficina({Key key}) : super(key: key);

  @override
  _OrdemServicoOficinaState createState() => _OrdemServicoOficinaState();
}

class _OrdemServicoOficinaState extends State<OrdemServicoOficina> {
  @override
  void initState() {
    setState(() {
      editVenda.listarPagamento();
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
                        indice = index;
                        UserData().get();
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
        // ignore: missing_return
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
