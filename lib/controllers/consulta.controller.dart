import 'package:lotus_erp/model/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/pages/consulta_produtos/functions/consulta_barcode.dart';
import 'package:lotus_erp/repository/consulta_produtos/consulta_auth.dart';
import 'package:mobx/mobx.dart';
part 'consulta.controller.g.dart';

var consulta = ConsultaProdutosController();

class ConsultaProdutosController = _ConsultaProdutosControllerBase
    with _$ConsultaProdutosController;

abstract class _ConsultaProdutosControllerBase with Store {
  @observable
  ObservableList<Produtos> produtoEstoque = ObservableList();

  @observable
  ObservableList<Produtos> produtoEstoqueDisplay = ObservableList();

  @action
  listarProdutos() {
    getProdutos().then((value) {
      produtoEstoque.addAll(value);
      produtoEstoqueDisplay = produtoEstoque;
      if (valorCodigoBarras != null) {
        produtoEstoqueDisplay =
            ObservableList.of(produtoEstoque.where((produto) {
          var produtoGtin = produto.gtin;
          if (produtoGtin != null) {
            return produtoGtin.contains(valorCodigoBarras);
          } else {
            return false;
          }
        }));
      }
    });
  }
}
