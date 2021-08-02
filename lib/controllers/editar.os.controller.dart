import 'package:lotus_erp/constructors/clientes/construtor_edit_pessoa.dart';
import 'package:lotus_erp/constructors/ordem_servico/construtor_tecnico.dart';
import 'package:lotus_erp/pages/ordem_servico/editar_os.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';
import 'package:lotus_erp/repository/clientes/listar_cliente_auth.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';
import 'package:lotus_erp/repository/ordem_servico/listar_produtos.dart';
import 'package:lotus_erp/repository/ordem_servico/listar_tecnico.dart';
import 'package:mobx/mobx.dart';
part 'editar.os.controller.g.dart';

final osController = EditarOSController();

class EditarOSController = _EditarOSControllerBase with _$EditarOSController;

abstract class _EditarOSControllerBase with Store {
  var produtoLength = 0;

  @observable
  ObservableList<Tecnico> tecnicos = ObservableList();

  @action
  listarTecnico() {
    getListarTecnico().then((value) {
      tecnicos = value;
    });
  }

  @observable
  ObservableList produtosOS = ObservableList();

  @action
  listarProdutos() {
    getListarProdutosOS().then((value) {
      produtoLength = value.length + 1;
      produtosOS = value;
    });
  }

  @observable
  ObservableList<EditPessoa> clientes = ObservableList();

  @observable
  ObservableList<EditPessoa> clientesDisplay = ObservableList();

  @action
  listarClientes() {
    getListarCliente().then((value) {
      clientes = value;
      clientesDisplay = clientes;
    });
  }

  @action
  getIdInfo() {
    getListarCliente().then((value) {
      ordemClienteId = oficina.ordemDisplay[ordemIndex].idPessoa;
      ordemClienteNome = oficina.ordemDisplay[ordemIndex].clienteNome;
    });
  }
}
