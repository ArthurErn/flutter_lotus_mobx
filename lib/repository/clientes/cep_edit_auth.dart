import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lotus_erp/pages/clientes/layout/editar_cliente.dart';

//SEGUNDA ROTA, COM O CONTEUDO DO CEP DA AUTENTICACAO DE CNPJ, COLOCAMOS ELE NESSA URL PRA RETORNAR O IBGE
Future getEditIBGE() async {
  cepEditText = cepEditText.replaceAll(".", "");
  cepEditText = cepEditText.replaceAll("-", "");
  var url = Uri.parse('https://viacep.com.br/ws/$cepEditText/json/');
  var data = await http.get(url);
  var jsonDecode = json.decode(data.body);

  logradouroEditText = jsonDecode['logradouro'];
  complementoEditText = jsonDecode['complemento'];
  bairroEditText = jsonDecode['bairro'];
  return jsonDecode['ibge'];
}
