// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balanco.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BalancoEstoqueController on _BalancoEstoqueControllerBase, Store {
  final _$balancoEstoqueAtom =
      Atom(name: '_BalancoEstoqueControllerBase.balancoEstoque');

  @override
  ObservableList<Balanco> get balancoEstoque {
    _$balancoEstoqueAtom.reportRead();
    return super.balancoEstoque;
  }

  @override
  set balancoEstoque(ObservableList<Balanco> value) {
    _$balancoEstoqueAtom.reportWrite(value, super.balancoEstoque, () {
      super.balancoEstoque = value;
    });
  }

  final _$balancoEstoqueDisplayAtom =
      Atom(name: '_BalancoEstoqueControllerBase.balancoEstoqueDisplay');

  @override
  ObservableList<Balanco> get balancoEstoqueDisplay {
    _$balancoEstoqueDisplayAtom.reportRead();
    return super.balancoEstoqueDisplay;
  }

  @override
  set balancoEstoqueDisplay(ObservableList<Balanco> value) {
    _$balancoEstoqueDisplayAtom.reportWrite(value, super.balancoEstoqueDisplay,
        () {
      super.balancoEstoqueDisplay = value;
    });
  }

  final _$_BalancoEstoqueControllerBaseActionController =
      ActionController(name: '_BalancoEstoqueControllerBase');

  @override
  dynamic getListaBalanco() {
    final _$actionInfo = _$_BalancoEstoqueControllerBaseActionController
        .startAction(name: '_BalancoEstoqueControllerBase.getListaBalanco');
    try {
      return super.getListaBalanco();
    } finally {
      _$_BalancoEstoqueControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
balancoEstoque: ${balancoEstoque},
balancoEstoqueDisplay: ${balancoEstoqueDisplay}
    ''';
  }
}
