import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lotus_erp/model/charts/chart.model.dart';
import 'package:lotus_erp/model/charts/chart.pagos.model.dart';
import 'package:lotus_erp/model/consulta_produtos/construtor_consulta.dart';
import 'package:lotus_erp/repository/charts/contas.pagar.rep.dart';
import 'package:lotus_erp/repository/charts/contas.pagas.rep.dart';
import 'package:lotus_erp/repository/charts/contas.receber.rep.dart';
import 'package:lotus_erp/repository/charts/venda.anual.rep.dart';
import 'package:lotus_erp/repository/login/login_auth.dart';
import 'package:lotus_erp/views/homepage/functions/bottom_homepage.dart';
import 'package:lotus_erp/views/homepage/layout/logo_homepage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<Produtos> product = [];
List<Produtos> produtoVendas = [];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChartModel> vendasAnual;
  List<ChartModel> contasPagar;
  List<ContasPagas> contasPagas;
  List<ChartModel> contasReceber;

  @override
  void initState() {
    getListarVendaAnual().then((_value) {
      setState(() {
        vendasAnual = _value;
      });
    });
    getListarContasPagas().then((_value) {
      setState(() {
        contasPagas = _value;
      });
    });
    getListarContasPagar().then((_value) {
      setState(() {
        contasPagar = _value;
      });
    });
    getListarContasReceber().then((_value) {
      setState(() {
        contasReceber = _value;
      });
    });
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
              Colors.black.withOpacity(0.4), BlendMode.dstOver),
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
            mobDashboard == 0
                ? PageView(
                    children: [
                      Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.9,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SfCartesianChart(
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    legend: Legend(
                                        isVisible: false, isResponsive: true),
                                    title: ChartTitle(
                                        text: "Vendas Mensais",
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    series: <ChartSeries>[
                                      ColumnSeries<ChartModel, String>(
                                          name: "Vendas Mensais",
                                          color: Colors.blue[200],
                                          yAxisName: "Valores",
                                          xAxisName: "Meses",
                                          dataSource: vendasAnual,
                                          xValueMapper: (ChartModel data, _) =>
                                              data.mes,
                                          yValueMapper: (ChartModel data, _) =>
                                              num.parse(
                                                  data.totLiquido.toString()),
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: false),
                                          enableTooltip: true),
                                    ],
                                    primaryXAxis: CategoryAxis(
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift)),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          )
                        ],
                      )),
                      Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.9,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SfCartesianChart(
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    legend: Legend(
                                        isVisible: false, isResponsive: true),
                                    title: ChartTitle(
                                        text: "Contas Pagas",
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    series: <ChartSeries>[
                                      ColumnSeries<ContasPagas, String>(
                                          name: "Contas Pagas",
                                          color: Colors.purple[200],
                                          yAxisName: "Valores",
                                          xAxisName: "Meses",
                                          dataSource: contasPagas,
                                          xValueMapper: (ContasPagas data, _) =>
                                              data.mes,
                                          yValueMapper: (ContasPagas data, _) =>
                                              data.totPago,
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: false),
                                          enableTooltip: true),
                                    ],
                                    primaryXAxis: CategoryAxis(
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.none)),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      )),
                      Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.9,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SfCartesianChart(
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    legend: Legend(
                                        isVisible: true, isResponsive: true),
                                    title: ChartTitle(
                                        text: "Contas Pendentes",
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    series: <ChartSeries>[
                                      StackedBarSeries<ChartModel, String>(
                                          name: "Contas a Pagar",
                                          color:
                                              Colors.blue[900].withOpacity(.7),
                                          yAxisName: "Valores",
                                          xAxisName: "Meses",
                                          dataSource: contasPagar,
                                          xValueMapper: (ChartModel data, _) =>
                                              data.mes,
                                          yValueMapper: (ChartModel data, _) =>
                                              num.parse(
                                                  data.totLiquido.toString()),
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: false),
                                          enableTooltip: true),
                                      StackedBarSeries<ChartModel, String>(
                                          name: "Contas a Receber",
                                          yAxisName: "Valores",
                                          xAxisName: "Meses",
                                          dataSource: contasReceber,
                                          xValueMapper: (ChartModel data, _) =>
                                              data.mes,
                                          yValueMapper: (ChartModel data, _) =>
                                              num.parse(
                                                  data.totLiquido.toString()),
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: false),
                                          enableTooltip: true),
                                    ],
                                    primaryXAxis: CategoryAxis(
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift)),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          )
                        ],
                      )),
                      // Center(
                      //     child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SizedBox(
                      //       height: 70,
                      //     ),
                      //     Container(
                      //       height: MediaQuery.of(context).size.height / 2,
                      //       width: MediaQuery.of(context).size.width - 30,
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(40)),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           SfCartesianChart(
                      //               tooltipBehavior: TooltipBehavior(enable: true),
                      //               legend:
                      //                   Legend(isVisible: false, isResponsive: true),
                      //               title: ChartTitle(
                      //                   text: "Contas a Receber (PENDENTES)",
                      //                   textStyle: TextStyle(
                      //                       fontWeight: FontWeight.bold,
                      //                       fontSize: 18)),
                      //               series: <ChartSeries>[
                      //                 StackedBarSeries<ChartModel, String>(
                      //                     name: "Contas a Receber",
                      //                     color: Colors.green[200],
                      //                     yAxisName: "Valores",
                      //                     xAxisName: "Meses",
                      //                     dataSource: contasReceber,
                      //                     xValueMapper: (ChartModel data, _) =>
                      //                         data.mes,
                      //                     yValueMapper: (ChartModel data, _) =>
                      //                         num.parse(data.totLiquido.toString()),
                      //                     dataLabelSettings: const DataLabelSettings(
                      //                         isVisible: true),
                      //                     enableTooltip: true),
                      //               ],
                      //               primaryXAxis: CategoryAxis(
                      //                   edgeLabelPlacement:
                      //                       EdgeLabelPlacement.shift)),
                      //           SizedBox(
                      //             width: 15,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 25,
                      //     )
                      //   ],
                      // )),
                    ],
                  )
                : Center(),
            //LIST VIEW HORIZONTAL ESTILO NUBANK (BOTTOM)
            BottomHomePage()
          ],
        ),
      ),
    );
  }
}
