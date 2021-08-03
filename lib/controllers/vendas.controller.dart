import 'package:lotus_erp/model/vendas/construtor_pedidos.dart';
import 'package:lotus_erp/repository/vendas/lista_pedido_auth.dart';
import 'package:mobx/mobx.dart';
part 'vendas.controller.g.dart';

var vendas = VendasController();

class VendasController = _VendasControllerBase with _$VendasController;

abstract class _VendasControllerBase with Store {
  @observable
  ObservableList<ListaPedidos> pedidos = ObservableList();

  @observable
  ObservableList<ListaPedidos> pedidosDisplay = ObservableList();

  @action
  listarPedidos() {
    getPedidos().then((value) {
      pedidos.clear();
      pedidos.addAll(value);
      pedidosDisplay = pedidos;
    });
  }
}
