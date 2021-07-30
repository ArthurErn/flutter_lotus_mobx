import 'package:lotus_erp/controllers/editar.os.controller.dart';
import 'package:lotus_erp/pages/clientes/clientes_page.dart';
import 'package:lotus_erp/repository/ordem_servico/get.user.data.dart';

class ClienteData {
  get() {
    clienteId = osController.clientesDisplay[indice].id;
    persistNomeRazao = osController.clientesDisplay[indice].nomeRazao;
    persistApelidoFantasia =
        osController.clientesDisplay[indice].apelidoFantasia;
    persistCNPJ = osController.clientesDisplay[indice].cpfCnpj;
    persistRG = osController.clientesDisplay[indice].rgInsc;
    persistTelefone = osController.clientesDisplay[indice].fone1;
    persistEmail = osController.clientesDisplay[indice].email;
    persistLogradouro = osController.clientesDisplay[indice].endereco;
    persistNumero = osController.clientesDisplay[indice].enderecoNumero;
    persistBairro = osController.clientesDisplay[indice].bairro;
    persistComplemento = osController.clientesDisplay[indice].complemento;
    persistCep = osController.clientesDisplay[indice].cep;
    persistMunicipio = osController.clientesDisplay[indice].municipioId;
  }
}
