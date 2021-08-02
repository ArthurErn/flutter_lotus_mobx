import 'package:http/http.dart' as http;
import 'package:lotus_erp/model/balanco_estoque/construtor_categoria.dart';
import 'package:lotus_erp/model/consulta_produtos/construtor_consulta.dart';
import 'dart:convert';
import 'dart:async';
import 'package:lotus_erp/views/login/login_page.dart';
import 'package:lotus_erp/views/login/functions/index_api.dart';
import 'package:mobx/mobx.dart';

//TIPO = 1 CASO NÃO UTILIZE CÓDIGO DE BARRAS, AO CONTRÁRIO UTILIZARÁ TIPO = 5
int tipo = 1;
int val;

//PVALOR VAZIO PARA RETORNAR TODOS OS ITENS
String pvalor = "";

//RETORNA UMA LISTA COM TODOS OS PRODUTOS
Future<ObservableList<Produtos>> getProdutos() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/produtos_listar?ploja=$_empresa&ptipo=$tipo&pvalor=$pvalor');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);
  ObservableList<Produtos> produtos = ObservableList();

  for (var u in jsonData) {
    Produtos produto = Produtos(
        u["id_empresa"],
        u['id_produto'],
        u['id_produto_formatado'],
        u['descricao'],
        u['unidade'],
        u['ref_fabrica'],
        u['gtin'],
        u['fabricante_nome'],
        u['produto_pcompra'],
        u['produto_pcusto'],
        u['produto_pvenda'],
        u['produto_saldo'],
        u['grupo_id'],
        u['grupo_descricao'],
        u['servico']);
    produtos.add(produto);
  }

  print(produtos.length);
  return produtos;
}

//RETORNA LISTA DE GRUPOS (FILTRO DE PRODUTOS) DE ACORDO COM A EMPRESA
Future<ObservableList<GrupoProdutos>> getGrupo() async {
  var _usuario = configLoginControllerText;
  var _senha = passControllerText;
  var _ip = ipController.text;
  var _empresa = getIndexEmpresa(val);

  var basicAuth = 'Basic ' + base64Encode(utf8.encode('$_usuario:$_senha'));
  var url = Uri.parse(
      'http://$_ip/mobile/produtos_grupos_listar?idempresa=$_empresa');
  var data = await http
      .get(url, headers: <String, String>{'authorization': basicAuth});
  var jsonData = json.decode(data.body);

  ObservableList<GrupoProdutos> grupos = ObservableList();

  for (var u in jsonData) {
    GrupoProdutos grupo = GrupoProdutos(
      u["id_grupo"],
      u['id_grupo_formatado'],
      u['grupo_descricao'],
    );

    grupos.add(grupo);
  }
  return grupos;
}
