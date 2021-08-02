import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lotus_erp/controllers/clientes.controller.dart';
import 'package:lotus_erp/views/clientes/cadastro_page.dart';

//SEGUNDA ROTA, COM O CONTEUDO DO CEP DA AUTENTICACAO DE CNPJ, COLOCAMOS ELE NESSA URL PRA RETORNAR O IBGE
Future getIBGE() async {
  var url = Uri.parse('https://viacep.com.br/ws/${clientes.cepText}/json/');
  var data = await http.get(url);
  var jsonDecode = json.decode(data.body);
  clientes.logradouroText = jsonDecode['logradouro'];
  clientes.complementoText = jsonDecode['complemento'];
  clientes.bairroText = jsonDecode['bairro'];
  return jsonDecode['ibge'];
}
