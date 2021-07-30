import 'package:flutter/material.dart';
import 'package:lotus_erp/repository/clientes/listar_cliente_auth.dart';
import 'package:lotus_erp/repository/ordem_servico/listar_tecnico.dart';
import 'package:lotus_erp/constructors/ordem_servico/construtor_tecnico.dart';
import 'package:lotus_erp/pages/ordem_servico/editar_tecnico.dart';

List<Tecnico> tecnicos = [];

class AlocarTecnico extends StatefulWidget {
  const AlocarTecnico({Key key}) : super(key: key);

  @override
  _AlocarTecnicoState createState() => _AlocarTecnicoState();
}

class _AlocarTecnicoState extends State<AlocarTecnico> {
  @override
  void initState() {
    getListarTecnico().then((value) {
      setState(() {
        tecnicos = value;
      });
    });
    setState(() {
      tipoCad = 3;
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
        title: Text("Alocar Técnico"),
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(width: .7, color: Colors.black)),
              child: ListView.builder(
                  itemCount: tecnicos.length,
                  itemBuilder: (context, index) {
                    return listTecnico(index);
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => EditarTecnico()));
              },
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(width: .7, color: Colors.black),
                    color: Colors.blue[900]),
                child: Center(
                    child: Text(
                  "Adicionar Técnico",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  listTecnico(index) {
    return Container(
      //height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID ' + tecnicos[index].ordemTecnicoId.toString(),
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  tecnicos[index].ordemTecnicoNome,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(width: .7, color: Colors.grey))),
          ),
        ],
      ),
    );
  }
}
