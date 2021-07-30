import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/constructors/cadastro_clientes/construtor_cadastro.dart';
import 'package:lotus_erp/pages/clientes/cadastro_page.dart';


//PRIMEIRA ROTA, PARA RECOLHER O CNPJ E TRAZER OUTROS CAMPOS
Future<List<Cnpj>> getCNPJ() async {
  var url = Uri.parse('https://www.receitaws.com.br/v1/cnpj/$cnpjText');
  var data = await http.get(url);
  Map<String, dynamic> jsonData = json.decode(data.body);
  List<Cnpj> clientes = [];

  print(jsonData['cep']);
  Cnpj cliente = Cnpj(jsonData['cep'], jsonData['logradouro'], jsonData['numero'], jsonData['bairro'], jsonData['complemento']);
  clientes.add(cliente);
  return clientes;
}
