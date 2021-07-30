import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/constructors/cadastro_clientes/construtor_cadastro.dart';
import 'package:lotus_erp/pages/clientes/layout/editar_cliente.dart';
import 'package:lotus_erp/pages/clientes/layout/error_message.dart';
import 'package:lotus_erp/pages/login/layout/login_dropdown.dart';

//PRIMEIRA ROTA, PARA RECOLHER O CNPJ E TRAZER OUTROS CAMPOS JUNTO
Future getEditCNPJ() async {
  var url = Uri.parse('https://www.receitaws.com.br/v1/cnpj/$cnpjEditText');
  var data = await http.get(url);
  Map<String, dynamic> jsonData = json.decode(data.body);
  List<Cnpj> clientes = [];
  if (data.statusCode == 200) {
    print(jsonData['cep']);
    Cnpj cliente = Cnpj(jsonData['cep'], jsonData['logradouro'],
        jsonData['numero'], jsonData['bairro'], jsonData['complemento']);
    clientes.add(cliente);
    return clientes;
  } else {
    errorCNPJInput(formKey.currentContext);
  }
}
