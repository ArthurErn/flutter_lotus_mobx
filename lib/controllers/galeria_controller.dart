import 'package:mobx/mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
part 'galeria_controller.g.dart';

String imagePath;
class GaleriaOS = _GaleriaOSBase with _$GaleriaOS;

abstract class _GaleriaOSBase with Store {
  @observable
  File image;

  @observable
  var imagePicker = ImagePicker();

  @action
  Future getImage() async {
    final imagem = await imagePicker.pickImage(source: ImageSource.camera);
    print(imagem.path);
    image = File(imagem.path);
    imagePath = imagem.path;
  }
}
