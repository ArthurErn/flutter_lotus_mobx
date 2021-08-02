import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/cadastro_clientes/construtor_cadastro.dart';
import 'package:lotus_erp/controllers/clientes.controller.dart';

//PRIMEIRA ROTA, PARA RECOLHER O CNPJ E TRAZER OUTROS CAMPOS
Future<List<Cnpj>> getCNPJ() async {
  var cnpj = clientes.cnpjText;
  var url =
      Uri.parse('https://www.receitaws.com.br/v1/cnpj/${clientes.cnpjText}');
  var data = await http.get(url);
  Map<String, dynamic> jsonData = json.decode(data.body);
  List<Cnpj> clientess = [];

  print(jsonData['cep']);
  Cnpj cliente = Cnpj(jsonData['cep'], jsonData['logradouro'],
      jsonData['numero'], jsonData['bairro'], jsonData['complemento']);
  clientess.add(cliente);
  return clientess;
}
