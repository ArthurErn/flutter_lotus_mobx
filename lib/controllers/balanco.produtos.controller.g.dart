// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balanco.produtos.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BalancoEstoqueProdutosController
    on _BalancoEstoqueProdutosControllerBase, Store {
  final _$balancoEstoqueProdutosAtom = Atom(
      name: '_BalancoEstoqueProdutosControllerBase.balancoEstoqueProdutos');

  @override
  ObservableList<ProdutosBalanco> get balancoEstoqueProdutos {
    _$balancoEstoqueProdutosAtom.reportRead();
    return super.balancoEstoqueProdutos;
  }

  @override
  set balancoEstoqueProdutos(ObservableList<ProdutosBalanco> value) {
    _$balancoEstoqueProdutosAtom
        .reportWrite(value, super.balancoEstoqueProdutos, () {
      super.balancoEstoqueProdutos = value;
    });
  }

  final _$balancoEstoqueProdutosDisplayAtom = Atom(
      name:
          '_BalancoEstoqueProdutosControllerBase.balancoEstoqueProdutosDisplay');

  @override
  ObservableList<ProdutosBalanco> get balancoEstoqueProdutosDisplay {
    _$balancoEstoqueProdutosDisplayAtom.reportRead();
    return super.balancoEstoqueProdutosDisplay;
  }

  @override
  set balancoEstoqueProdutosDisplay(ObservableList<ProdutosBalanco> value) {
    _$balancoEstoqueProdutosDisplayAtom
        .reportWrite(value, super.balancoEstoqueProdutosDisplay, () {
      super.balancoEstoqueProdutosDisplay = value;
    });
  }

  final _$_BalancoEstoqueProdutosControllerBaseActionController =
      ActionController(name: '_BalancoEstoqueProdutosControllerBase');

  @override
  dynamic getLista() {
    final _$actionInfo = _$_BalancoEstoqueProdutosControllerBaseActionController
        .startAction(name: '_BalancoEstoqueProdutosControllerBase.getLista');
    try {
      return super.getLista();
    } finally {
      _$_BalancoEstoqueProdutosControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
balancoEstoqueProdutos: ${balancoEstoqueProdutos},
balancoEstoqueProdutosDisplay: ${balancoEstoqueProdutosDisplay}
    ''';
  }
}
