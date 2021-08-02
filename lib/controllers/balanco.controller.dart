import 'package:lotus_erp/model/balanco_estoque/construtor_balanco.dart';
import 'package:lotus_erp/model/balanco_estoque/construtor_categoria.dart';
import 'package:lotus_erp/model/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/pages/balanco_estoque/functions/balanco_barcode.dart';
import 'package:lotus_erp/repository/balanco_estoque/balanco_auth.dart';
import 'package:lotus_erp/repository/consulta_produtos/consulta_auth.dart';
import 'package:mobx/mobx.dart';
part 'balanco.controller.g.dart';

var balanco = BalancoEstoqueController();

class BalancoEstoqueController = _BalancoEstoqueControllerBase
    with _$BalancoEstoqueController;

abstract class _BalancoEstoqueControllerBase with Store {
  @observable
  ObservableList<Balanco> balancoEstoque = ObservableList();

  @observable
  ObservableList<Balanco> balancoEstoqueDisplay = ObservableList();

  @action
  getListaBalanco() {
    getBalanco().then((value) {
      balancoEstoque.clear();
      balancoEstoqueDisplay.clear();
      balancoEstoque.addAll(value);
      balancoEstoqueDisplay = balancoEstoque;
    });
  }

  @observable
  ObservableList<Produtos> produtoVendasLista = ObservableList();

  @observable
  ObservableList<Produtos> produtoVendasListaDisplay = ObservableList();

  @action
  getListaProdutos() {
    getProdutos().then((value) {
        produtoVendasLista.addAll(value);
        produtoVendasListaDisplay = produtoVendasLista;
        if (valorCodigoBarrasProduto != null) {
            produtoVendasListaDisplay = ObservableList.of(produtoVendasLista.where((produto) {
              var produtoGtin = produto.gtin;
              if (produtoGtin != null) {
                return produtoGtin.contains(valorCodigoBarrasProduto);
              } else {
                return false;
              }
            }));
        }
      
    });
  }

  @observable
  ObservableList<GrupoProdutos> grupoValue = ObservableList();

  @observable
  ObservableList<GrupoProdutos> grupoDisplay = ObservableList();

  @action
  getListaGrupo() {
    getGrupo().then((value) {
      grupoValue.clear();
      grupoDisplay.clear();
      grupoValue.addAll(value);
      grupoDisplay = grupoValue;
    });
  }
}
