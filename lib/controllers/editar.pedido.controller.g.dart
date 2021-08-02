// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editar.pedido.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditarVendaController on _EditarVendaControllerBase, Store {
  final _$formasAtom = Atom(name: '_EditarVendaControllerBase.formas');

  @override
  ObservableList<FormaPagamento> get formas {
    _$formasAtom.reportRead();
    return super.formas;
  }

  @override
  set formas(ObservableList<FormaPagamento> value) {
    _$formasAtom.reportWrite(value, super.formas, () {
      super.formas = value;
    });
  }

  final _$_EditarVendaControllerBaseActionController =
      ActionController(name: '_EditarVendaControllerBase');

  @override
  dynamic listarPagamento() {
    final _$actionInfo = _$_EditarVendaControllerBaseActionController
        .startAction(name: '_EditarVendaControllerBase.listarPagamento');
    try {
      return super.listarPagamento();
    } finally {
      _$_EditarVendaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formas: ${formas}
    ''';
  }
}
