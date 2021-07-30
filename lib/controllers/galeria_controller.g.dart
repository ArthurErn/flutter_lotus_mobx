// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'galeria_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GaleriaOS on _GaleriaOSBase, Store {
  final _$imageAtom = Atom(name: '_GaleriaOSBase.image');

  @override
  File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$imagePickerAtom = Atom(name: '_GaleriaOSBase.imagePicker');

  @override
  ImagePicker get imagePicker {
    _$imagePickerAtom.reportRead();
    return super.imagePicker;
  }

  @override
  set imagePicker(ImagePicker value) {
    _$imagePickerAtom.reportWrite(value, super.imagePicker, () {
      super.imagePicker = value;
    });
  }

  final _$getImageAsyncAction = AsyncAction('_GaleriaOSBase.getImage');

  @override
  Future<dynamic> getImage() {
    return _$getImageAsyncAction.run(() => super.getImage());
  }

  @override
  String toString() {
    return '''
image: ${image},
imagePicker: ${imagePicker}
    ''';
  }
}
