import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import '../layout/adicionar_produto.dart';
import '../../login/layout/login_dropdown.dart';

var valorCodigoBarrasProduto = '';


//SCANNER CODIGO DE BARRAS
class ConsultaBalancoController extends GetxController {
  void escanearCodigoBarras() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancelar', true, ScanMode.BARCODE);

    if (barcodeScanRes == '-1') {
      return null;
    } else {
      String valor = barcodeScanRes;
      valorCodigoBarrasProduto = valor;
      Navigator.push(formKey.currentContext,
          MaterialPageRoute(builder: (context) => AdicionarProduto()));
    }
    print(valorCodigoBarrasProduto);
  }
}
