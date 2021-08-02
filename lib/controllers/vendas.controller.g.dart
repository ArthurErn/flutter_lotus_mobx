// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendas.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VendasController on _VendasControllerBase, Store {
  final _$pedidosAtom = Atom(name: '_VendasControllerBase.pedidos');

  @override
  ObservableList<ListaPedidos> get pedidos {
    _$pedidosAtom.reportRead();
    return super.pedidos;
  }

  @override
  set pedidos(ObservableList<ListaPedidos> value) {
    _$pedidosAtom.reportWrite(value, super.pedidos, () {
      super.pedidos = value;
    });
  }

  final _$pedidosDisplayAtom =
      Atom(name: '_VendasControllerBase.pedidosDisplay');

  @override
  ObservableList<ListaPedidos> get pedidosDisplay {
    _$pedidosDisplayAtom.reportRead();
    return super.pedidosDisplay;
  }

  @override
  set pedidosDisplay(ObservableList<ListaPedidos> value) {
    _$pedidosDisplayAtom.reportWrite(value, super.pedidosDisplay, () {
      super.pedidosDisplay = value;
    });
  }

  final _$_VendasControllerBaseActionController =
      ActionController(name: '_VendasControllerBase');

  @override
  dynamic listarPedidos() {
    final _$actionInfo = _$_VendasControllerBaseActionController.startAction(
        name: '_VendasControllerBase.listarPedidos');
    try {
      return super.listarPedidos();
    } finally {
      _$_VendasControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pedidos: ${pedidos},
pedidosDisplay: ${pedidosDisplay}
    ''';
  }
}
