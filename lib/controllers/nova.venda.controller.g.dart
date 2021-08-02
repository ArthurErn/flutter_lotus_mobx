// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nova.venda.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NovaVendaController on _NovaVendaControllerBase, Store {
  final _$clientesNovaVendaAtom =
      Atom(name: '_NovaVendaControllerBase.clientesNovaVenda');

  @override
  ObservableList<EditPessoa> get clientesNovaVenda {
    _$clientesNovaVendaAtom.reportRead();
    return super.clientesNovaVenda;
  }

  @override
  set clientesNovaVenda(ObservableList<EditPessoa> value) {
    _$clientesNovaVendaAtom.reportWrite(value, super.clientesNovaVenda, () {
      super.clientesNovaVenda = value;
    });
  }

  final _$clientesDisplayNovaVendaAtom =
      Atom(name: '_NovaVendaControllerBase.clientesDisplayNovaVenda');

  @override
  ObservableList<EditPessoa> get clientesDisplayNovaVenda {
    _$clientesDisplayNovaVendaAtom.reportRead();
    return super.clientesDisplayNovaVenda;
  }

  @override
  set clientesDisplayNovaVenda(ObservableList<EditPessoa> value) {
    _$clientesDisplayNovaVendaAtom
        .reportWrite(value, super.clientesDisplayNovaVenda, () {
      super.clientesDisplayNovaVenda = value;
    });
  }

  final _$produtoEstoqueAddAtom =
      Atom(name: '_NovaVendaControllerBase.produtoEstoqueAdd');

  @override
  ObservableList<Produtos> get produtoEstoqueAdd {
    _$produtoEstoqueAddAtom.reportRead();
    return super.produtoEstoqueAdd;
  }

  @override
  set produtoEstoqueAdd(ObservableList<Produtos> value) {
    _$produtoEstoqueAddAtom.reportWrite(value, super.produtoEstoqueAdd, () {
      super.produtoEstoqueAdd = value;
    });
  }

  final _$produtoEstoqueAddDisplayAtom =
      Atom(name: '_NovaVendaControllerBase.produtoEstoqueAddDisplay');

  @override
  ObservableList<Produtos> get produtoEstoqueAddDisplay {
    _$produtoEstoqueAddDisplayAtom.reportRead();
    return super.produtoEstoqueAddDisplay;
  }

  @override
  set produtoEstoqueAddDisplay(ObservableList<Produtos> value) {
    _$produtoEstoqueAddDisplayAtom
        .reportWrite(value, super.produtoEstoqueAddDisplay, () {
      super.produtoEstoqueAddDisplay = value;
    });
  }

  final _$_NovaVendaControllerBaseActionController =
      ActionController(name: '_NovaVendaControllerBase');

  @override
  dynamic listarClientes() {
    final _$actionInfo = _$_NovaVendaControllerBaseActionController.startAction(
        name: '_NovaVendaControllerBase.listarClientes');
    try {
      return super.listarClientes();
    } finally {
      _$_NovaVendaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic listarProdutos() {
    final _$actionInfo = _$_NovaVendaControllerBaseActionController.startAction(
        name: '_NovaVendaControllerBase.listarProdutos');
    try {
      return super.listarProdutos();
    } finally {
      _$_NovaVendaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clientesNovaVenda: ${clientesNovaVenda},
clientesDisplayNovaVenda: ${clientesDisplayNovaVenda},
produtoEstoqueAdd: ${produtoEstoqueAdd},
produtoEstoqueAddDisplay: ${produtoEstoqueAddDisplay}
    ''';
  }
}
