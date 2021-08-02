import 'package:lotus_erp/model/clientes/construtor_edit_pessoa.dart';
import 'package:lotus_erp/model/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/views/balanco_estoque/functions/balanco_barcode.dart';
import 'package:lotus_erp/repository/clientes/listar_cliente_auth.dart';
import 'package:lotus_erp/repository/consulta_produtos/consulta_auth.dart';
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

  @observable
  ObservableList<Produtos> produtoEstoqueAdd = ObservableList();

  @observable
  ObservableList<Produtos> produtoEstoqueAddDisplay = ObservableList();

  @action
  listarProdutos() {
    getProdutos().then((value) {
      produtoEstoqueAdd.addAll(value);
      produtoEstoqueAddDisplay = produtoEstoqueAdd;
      if (valorCodigoBarrasProduto != null && valorCodigoBarrasProduto != "") {
        produtoEstoqueAddDisplay = ObservableList.of(
          produtoEstoqueAdd.where((produto) {
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
}
