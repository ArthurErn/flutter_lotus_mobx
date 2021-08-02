import 'package:lotus_erp/model/vendas/construtor_forma_pagamento.dart';
import 'package:lotus_erp/repository/vendas/dropdown_venda_auth.dart';
import 'package:mobx/mobx.dart';
part 'editar.pedido.controller.g.dart';

var editVenda = EditarVendaController();

class EditarVendaController = _EditarVendaControllerBase
    with _$EditarVendaController;

abstract class _EditarVendaControllerBase with Store {
  @observable
  ObservableList<FormaPagamento> formas = ObservableList();

  @action
  listarPagamento() {
    getFormaPagamento().then((value) {
      formas.clear();
      formas = value;
    });
  }
}
