import 'package:flutter/material.dart';
import 'package:lotus_erp/controllers/clientes.controller.dart';
import 'package:lotus_erp/pages/clientes/cadastro_page.dart';

class ResetFieldCadastro {
  resetFieldCadastro() {
    clientes.nomeRazao = TextEditingController(text: "");
    clientes.apelidoFantasia = TextEditingController(text: "");
    clientes.cnpj = TextEditingController(text: "");
    clientes.rgInsc = TextEditingController(text: "");
    clientes.telefone = TextEditingController(text: "");
    clientes.email = TextEditingController(text: "");
    clientes.logradouro = TextEditingController(text: "");
    clientes.numero = TextEditingController(text: "");
    clientes.bairro = TextEditingController(text: "");
    clientes.complemento = TextEditingController(text: "");
    clientes.cep = TextEditingController(text: "");

    clientes.nomeRazaoText = "";
    clientes.cepText = "";
    clientes.cnpjText = "";
    clientes.apelidoFantasiaText = "";
    clientes.rgInscText = "";
    clientes.telefoneText = "";
    clientes.emailText = "";
    clientes.logradouroText = "";
    clientes.numeroText = "";
    clientes.bairroText = "";
    clientes.complementoText = "";
    clientes.ibge = "";

    clientes.cepField = null;
    clientes.logradouroField = null;
    clientes.numeroField = null;
    clientes.bairroField = null;
    clientes.complementoField = null;
  }
}
