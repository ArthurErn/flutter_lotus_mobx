import 'package:lotus_erp/repository/ordem_servico/listar_produtos.dart';
import 'package:mobx/mobx.dart';
part 'editar.os.controller.g.dart';

final osController = EditarOSController();

class EditarOSController = _EditarOSControllerBase with _$EditarOSController;

abstract class _EditarOSControllerBase with Store {

  var produtoLength=0;

  @observable
  ObservableList produtosOS = ObservableList();

  @action
  listarProdutos() {
    getListarProdutosOS().then((value) {
      produtoLength = value.length + 1;
      produtosOS = value;
    });
  }
}
