import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import '../consulta_produtos.dart';
import '../../login/layout/login_dropdown.dart';

var valorCodigoBarras = '';

class ConsultaController extends GetxController {
  void escanearCodigoBarras() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancelar', true, ScanMode.BARCODE);

    if (barcodeScanRes == '-1') {
      return null;
    } else {
      String valor = barcodeScanRes;
      valorCodigoBarras = valor;
      //valorController.text = barcodeScanRes;
      Navigator.pushReplacement(formKey.currentContext,
          MaterialPageRoute(builder: (context) => ConsultaProduto()));
    }
    print(valorCodigoBarras);
  }
}
