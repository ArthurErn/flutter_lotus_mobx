// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consulta.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConsultaProdutosController on _ConsultaProdutosControllerBase, Store {
  final _$produtoEstoqueAtom =
      Atom(name: '_ConsultaProdutosControllerBase.produtoEstoque');

  @override
  ObservableList<Produtos> get produtoEstoque {
    _$produtoEstoqueAtom.reportRead();
    return super.produtoEstoque;
  }

  @override
  set produtoEstoque(ObservableList<Produtos> value) {
    _$produtoEstoqueAtom.reportWrite(value, super.produtoEstoque, () {
      super.produtoEstoque = value;
    });
  }

  final _$produtoEstoqueDisplayAtom =
      Atom(name: '_ConsultaProdutosControllerBase.produtoEstoqueDisplay');

  @override
  ObservableList<Produtos> get produtoEstoqueDisplay {
    _$produtoEstoqueDisplayAtom.reportRead();
    return super.produtoEstoqueDisplay;
  }

  @override
  set produtoEstoqueDisplay(ObservableList<Produtos> value) {
    _$produtoEstoqueDisplayAtom.reportWrite(value, super.produtoEstoqueDisplay,
        () {
      super.produtoEstoqueDisplay = value;
    });
  }

  final _$_ConsultaProdutosControllerBaseActionController =
      ActionController(name: '_ConsultaProdutosControllerBase');

  @override
  dynamic listarProdutos() {
    final _$actionInfo = _$_ConsultaProdutosControllerBaseActionController
        .startAction(name: '_ConsultaProdutosControllerBase.listarProdutos');
    try {
      return super.listarProdutos();
    } finally {
      _$_ConsultaProdutosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
produtoEstoque: ${produtoEstoque},
produtoEstoqueDisplay: ${produtoEstoqueDisplay}
    ''';
  }
}
