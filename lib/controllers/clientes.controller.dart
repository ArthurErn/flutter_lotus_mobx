import 'package:flutter/material.dart';
import 'package:lotus_erp/pages/clientes/cadastro_page.dart';
import 'package:lotus_erp/pages/clientes/layout/error_message.dart';
import 'package:lotus_erp/repository/cadastro_clientes/cadastro_cliente_auth.dart';
import 'package:lotus_erp/repository/cadastro_clientes/cep_auth.dart';
import 'package:lotus_erp/repository/cadastro_clientes/cnpj_auth.dart';
import 'package:lotus_erp/repository/cadastro_clientes/municipio_auth.dart';
import 'package:mobx/mobx.dart';
part 'clientes.controller.g.dart';

var clientes = ClientesController();

class ClientesController = _ClientesControllerBase with _$ClientesController;

abstract class _ClientesControllerBase with Store {
  @observable
  var cnpjText;
  @observable
  var cepText;
  @observable
  var nomeRazaoText;
  @observable
  var apelidoFantasiaText;
  @observable
  var rgInscText;
  @observable
  var telefoneText;
  @observable
  var emailText;
  @observable
  var logradouroText;
  @observable
  var numeroText;
  @observable
  var bairroText;
  @observable
  var complementoText;

  @observable
  var nomeRazao = TextEditingController();
  @observable
  TextEditingController apelidoFantasia;
  @observable
  TextEditingController cnpj;
  @observable
  TextEditingController rgInsc;
  @observable
  TextEditingController telefone;
  @observable
  TextEditingController email;
  @observable
  TextEditingController logradouro;
  @observable
  TextEditingController numero;
  @observable
  TextEditingController bairro;
  @observable
  TextEditingController complemento;
  @observable
  TextEditingController cep;

  //CAMPOS RESGATADOS POR API
  @observable
  var cepField;
  @observable
  var logradouroField;
  @observable
  var municipioId;
  @observable
  var numeroField;
  @observable
  var bairroField;
  @observable
  var complementoField;
  @observable
  var ibge;

  @action
  fillCEP(BuildContext context) {
    cepText = cepText.replaceAll(".", "");
    cepText = cepText.replaceAll("-", "");
    getIBGE().then((value) {
      ibge = value;
      //CONFIRMAÇÃO DO MUNICIPIO
      getMunicipio().then((value) {
        municipioId = value[0].municipioId;
        logradouro = TextEditingController(text: logradouroText);
        bairro = TextEditingController(text: bairroText);
        complemento = TextEditingController(text: complementoText);
      });
    });
  }

  @action
  fillCNPJ(BuildContext context) {
    getCNPJ().then((value) {
      cnpjs = value;
      if (cnpjs == null) {
        errorCNPJvazio(context);
      } else {
        cepText = value[0].cep;
        cep = TextEditingController(text: cepText);
        if (cepText == null) {
          errorCNPJInput(context);
        } else {
          //EXPRESSAO REGULAR PRA TIRAR "." E "-" DO CEP
          cepText = cepText.replaceAll(".", "");
          cepText = cepText.replaceAll("-", "");

          //ARMAZENANDO VALORES NAS VARIAVEIS PRA FICAR MAIS FACIL DE LER O CADASTRO

          logradouroText = value[0].logradouro;
          logradouro = TextEditingController(text: logradouroText);
          numeroText = value[0].numero;
          numero = TextEditingController(text: numeroText);
          bairroText = value[0].bairro;
          bairro = TextEditingController(text: bairroText);
          complementoText = value[0].complemento;
          complemento = TextEditingController(text: complementoText);

          //PEGA O IBGE PARA PREENCHER ID DO MUNICIPIO
          getIBGE().then((value) {
            ibge = value;

            //CONFIRMAÇÃO DO MUNICIPIO
            getMunicipio().then((value) {
              municipioId = value[0].municipioId;
            });
          });
        }
      }
    });
  }
}
