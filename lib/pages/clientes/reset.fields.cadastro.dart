import 'package:flutter/material.dart';
import 'package:lotus_erp/pages/clientes/cadastro_page.dart';

class ResetFieldCadastro {
  resetFieldCadastro() {
    nomeRazao = TextEditingController(text: "");
    apelidoFantasia = TextEditingController(text: "");
    cnpj = TextEditingController(text: "");
    rgInsc = TextEditingController(text: "");
    telefone = TextEditingController(text: "");
    email = TextEditingController(text: "");
    logradouro = TextEditingController(text: "");
    numero = TextEditingController(text: "");
    bairro = TextEditingController(text: "");
    complemento = TextEditingController(text: "");
    cep = TextEditingController(text: "");

    nomeRazaoText = "";
    cepText = "";
    cnpjText = "";
    apelidoFantasiaText = "";
    rgInscText = "";
    telefoneText = "";
    emailText = "";
    logradouroText = "";
    numeroText = "";
    bairroText = "";
    complementoText = "";
    ibge = "";

    cepField = null;
    logradouroField = null;
    numeroField = null;
    bairroField = null;
    complementoField = null;
  }
}
