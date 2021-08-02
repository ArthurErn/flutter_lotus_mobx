import 'package:lotus_erp/model/balanco_estoque/construtor_produtos_balanco.dart';
import 'package:lotus_erp/repository/balanco_estoque/produtos_balanco_auth.dart';
import 'package:mobx/mobx.dart';
part 'balanco.produtos.controller.g.dart';

var balancoProdutos = BalancoEstoqueProdutosController();

class BalancoEstoqueProdutosController = _BalancoEstoqueProdutosControllerBase
    with _$BalancoEstoqueProdutosController;

abstract class _BalancoEstoqueProdutosControllerBase with Store {
  @observable
  ObservableList<ProdutosBalanco> balancoEstoqueProdutos = ObservableList();

  @observable
  ObservableList<ProdutosBalanco> balancoEstoqueProdutosDisplay =
      ObservableList();

  @action
  getLista() {
    getProdutosBalanco().then((value) {
      balancoEstoqueProdutos.clear();
      balancoEstoqueProdutosDisplay.clear();
      balancoEstoqueProdutos.addAll(value);
      balancoEstoqueProdutosDisplay = balancoEstoqueProdutos;
    });
  }
}
