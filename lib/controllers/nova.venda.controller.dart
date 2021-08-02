import 'package:lotus_erp/model/clientes/construtor_edit_pessoa.dart';
import 'package:lotus_erp/repository/clientes/listar_cliente_auth.dart';
import 'package:mobx/mobx.dart';
part 'nova.venda.controller.g.dart';

var novaVenda = NovaVendaController();

class NovaVendaController = _NovaVendaControllerBase with _$NovaVendaController;

abstract class _NovaVendaControllerBase with Store {
  @observable
  ObservableList<EditPessoa> clientesNovaVenda = ObservableList();

  @observable
  ObservableList<EditPessoa> clientesDisplayNovaVenda = ObservableList();

  @action
  listarClientes() {
    getListarCliente().then((clientesValor) {
      clientesNovaVenda.addAll(clientesValor);
      clientesDisplayNovaVenda = clientesNovaVenda;
    });
  }
}
