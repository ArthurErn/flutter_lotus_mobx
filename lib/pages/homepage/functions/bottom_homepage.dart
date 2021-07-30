import 'package:flutter/material.dart';
import 'package:lotus_erp/pages/balanco_estoque/balanco_estoque.dart';

import 'package:lotus_erp/pages/clientes/clientes_page.dart';
import 'package:lotus_erp/pages/consulta_produtos/consulta_produtos.dart';
import 'package:lotus_erp/pages/ordem_servico/ordem_oficina.dart';
import 'package:lotus_erp/pages/vendas/vendas_page.dart';

import '../layout/item_bottom_homepage.dart';

class BottomHomePage extends StatelessWidget {
  const BottomHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0 + MediaQuery.of(context).size.height * 0.010,
      left: 0,
      right: 0,
      height: 110,
      child: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            ItemMenuBottom(
                icon: Icons.group,
                text: 'Cadastro Clientes',
                route: ClientesPage()),
            ItemMenuBottom(
              icon: Icons.view_list_sharp,
              text: 'Consulta Produtos',
              route: ConsultaProduto(),
            ),
            ItemMenuBottom(
              icon: Icons.storage_rounded,
              text: 'Balanço Estoque',
              route: BalancoEstoque(),
            ),
            ItemMenuBottom(
              icon: Icons.mobile_friendly_outlined,
              text: 'Vendas',
              route: VendasPage(),
            ),
            ItemMenuBottom(
              icon: Icons.filter_frames,
              text: 'Ordem Serviços',
              route: OrdemServicoOficina(),
            ),
          ],
        ),
      ),
    );
  }
}
