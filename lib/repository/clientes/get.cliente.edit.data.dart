//CONTROLLER DOS CAMPOS
import 'package:flutter/material.dart';
import 'package:lotus_erp/controllers/clientes.controller.dart';
import 'package:lotus_erp/pages/clientes/cadastro_page.dart';
import 'package:lotus_erp/repository/clientes/get.cliente.data.dart';

TextEditingController nomeRazaoEdit;
TextEditingController apelidoFantasiaEdit;
TextEditingController cnpjEdit;
TextEditingController rgInscEdit;
TextEditingController telefoneEdit;
TextEditingController emailEdit;
TextEditingController logradouroEdit;
TextEditingController numeroEdit;
TextEditingController bairroEdit;
TextEditingController complementoEdit;
TextEditingController cepEdit;

//CAMPOS ESCRITOS NA MÃO
var cnpjEditText = cnpjEdit.text;
var nomeRazaoEditText = nomeRazaoEdit.text;
var apelidoFantasiaEditText = apelidoFantasiaEdit.text;
var rgInscEditText = rgInscEdit.text;
var telefoneEditText = telefoneEdit.text;
var emailEditText = emailEdit.text;
var logradouroEditText = logradouroEdit.text;
var numeroEditText = numeroEdit.text;
var bairroEditText = bairroEdit.text;
var complementoEditText = complementoEdit.text;
var cepEditText = cepEdit.text;

//CAMPOS RESGATADOS POR API
var municipioEditId;

class ClienteDataEdit {
  get() {
    nomeRazaoEdit = TextEditingController(text: persistNomeRazao);
      apelidoFantasiaEdit = TextEditingController(text: persistApelidoFantasia);
      cnpjEdit = TextEditingController(text: persistCNPJ);
      clientes.cnpjText = persistCNPJ;
      rgInscEdit = TextEditingController(text: persistRG);
      telefoneEdit = TextEditingController(text: persistTelefone);
      emailEdit = TextEditingController(text: persistEmail);
      logradouroEdit = TextEditingController(text: persistLogradouro);
      numeroEdit = TextEditingController(text: persistNumero);
      bairroEdit = TextEditingController(text: persistBairro);
      complementoEdit = TextEditingController(text: persistComplemento);
      cepEdit = TextEditingController(text: persistCep);

      //ATRIBUIR OS VALORES DO CLIENTE NAS VARIAVEIS PARA EDIÇÃO
      municipioEditId = persistMunicipio;
      cepEditText = persistCep;
      nomeRazaoEditText = persistNomeRazao;
      apelidoFantasiaEditText = persistApelidoFantasia;
      cnpjEditText = persistCNPJ;
      rgInscEditText = persistRG;
      telefoneEditText = persistTelefone;
      emailEditText = persistEmail;
      logradouroEditText = persistLogradouro;
      numeroEditText = persistNumero;
      bairroEditText = persistBairro;
      complementoEditText = persistComplemento;
  }
}
