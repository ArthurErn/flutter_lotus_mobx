import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lotus_erp/pages/clientes/cadastro_page.dart';

//SEGUNDA ROTA, COM O CONTEUDO DO CEP DA AUTENTICACAO DE CNPJ, COLOCAMOS ELE NESSA URL PRA RETORNAR O IBGE
Future getIBGE() async {
  var url = Uri.parse('https://viacep.com.br/ws/$cepText/json/');
  var data = await http.get(url);
  var jsonDecode = json.decode(data.body);
    logradouroText = jsonDecode['logradouro'];
    complementoText = jsonDecode['complemento'];
    bairroText = jsonDecode['bairro'];
    return jsonDecode['ibge'];

}
