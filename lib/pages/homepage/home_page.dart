import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotus_erp/model/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/pages/homepage/functions/bottom_homepage.dart';
import 'package:lotus_erp/pages/homepage/layout/logo_homepage.dart';
List<Produtos> product = [];
List<Produtos> produtoVendas = [];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    ]);
    return Container(
      decoration: BoxDecoration(

        //BACKGROUND COM OPACIDADE
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.dstATop),
          image: AssetImage(
            'lib/assets/images/background.png',
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.blue[100].withOpacity(0.1),
        body: Stack(
          children: [

            //LOGO HOMEPAGE
            LogoHomePage(),
            //LIST VIEW HORIZONTAL ESTILO NUBANK (BOTTOM)
            BottomHomePage()
          ],
        ),
      ),
    );
  }
}
