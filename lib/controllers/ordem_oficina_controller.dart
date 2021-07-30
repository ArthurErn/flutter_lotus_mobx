import 'package:lotus_erp/constructors/ordem_servico/ordem_servico.dart';
import 'package:lotus_erp/repository/ordem_servico/inserir_oficina.dart';
import 'package:lotus_erp/repository/ordem_servico/ordem_servico_auth.dart';
import 'package:mobx/mobx.dart';
part 'ordem_oficina_controller.g.dart';

class OrdemOficinaController = _OrdemOficinaControllerBase
    with _$OrdemOficinaController;

abstract class _OrdemOficinaControllerBase with Store {
  
  @observable
  ObservableList<Ordem> ordemDisplay = ObservableList();

  @action
  ordemDisplayInfo() async {
    await getOrdem().then((value) {
      ordemDisplay = value;
    });
  }

  @action
  postOrdemOficina() {
    postOficina().then((value) {
      ordemDisplayInfo();
    });
  }
}
