// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editar.os.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditarOSController on _EditarOSControllerBase, Store {
  final _$tecnicosAtom = Atom(name: '_EditarOSControllerBase.tecnicos');

  @override
  ObservableList<Tecnico> get tecnicos {
    _$tecnicosAtom.reportRead();
    return super.tecnicos;
  }

  @override
  set tecnicos(ObservableList<Tecnico> value) {
    _$tecnicosAtom.reportWrite(value, super.tecnicos, () {
      super.tecnicos = value;
    });
  }

  final _$produtosOSAtom = Atom(name: '_EditarOSControllerBase.produtosOS');

  @override
  ObservableList<dynamic> get produtosOS {
    _$produtosOSAtom.reportRead();
    return super.produtosOS;
  }

  @override
  set produtosOS(ObservableList<dynamic> value) {
    _$produtosOSAtom.reportWrite(value, super.produtosOS, () {
      super.produtosOS = value;
    });
  }

  final _$clientesAtom = Atom(name: '_EditarOSControllerBase.clientes');

  @override
  ObservableList<EditPessoa> get clientes {
    _$clientesAtom.reportRead();
    return super.clientes;
  }

  @override
  set clientes(ObservableList<EditPessoa> value) {
    _$clientesAtom.reportWrite(value, super.clientes, () {
      super.clientes = value;
    });
  }

  final _$clientesDisplayAtom =
      Atom(name: '_EditarOSControllerBase.clientesDisplay');

  @override
  ObservableList<EditPessoa> get clientesDisplay {
    _$clientesDisplayAtom.reportRead();
    return super.clientesDisplay;
  }

  @override
  set clientesDisplay(ObservableList<EditPessoa> value) {
    _$clientesDisplayAtom.reportWrite(value, super.clientesDisplay, () {
      super.clientesDisplay = value;
    });
  }

  final _$_EditarOSControllerBaseActionController =
      ActionController(name: '_EditarOSControllerBase');

  @override
  dynamic listarTecnico() {
    final _$actionInfo = _$_EditarOSControllerBaseActionController.startAction(
        name: '_EditarOSControllerBase.listarTecnico');
    try {
      return super.listarTecnico();
    } finally {
      _$_EditarOSControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic listarProdutos() {
    final _$actionInfo = _$_EditarOSControllerBaseActionController.startAction(
        name: '_EditarOSControllerBase.listarProdutos');
    try {
      return super.listarProdutos();
    } finally {
      _$_EditarOSControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic listarClientes() {
    final _$actionInfo = _$_EditarOSControllerBaseActionController.startAction(
        name: '_EditarOSControllerBase.listarClientes');
    try {
      return super.listarClientes();
    } finally {
      _$_EditarOSControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getIdInfo() {
    final _$actionInfo = _$_EditarOSControllerBaseActionController.startAction(
        name: '_EditarOSControllerBase.getIdInfo');
    try {
      return super.getIdInfo();
    } finally {
      _$_EditarOSControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tecnicos: ${tecnicos},
produtosOS: ${produtosOS},
clientes: ${clientes},
clientesDisplay: ${clientesDisplay}
    ''';
  }
}
