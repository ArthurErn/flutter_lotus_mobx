import 'package:lotus_erp/model/balanco_estoque/construtor_balanco.dart';
import 'package:lotus_erp/model/balanco_estoque/construtor_categoria.dart';
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
