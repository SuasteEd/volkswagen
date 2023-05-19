// import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class PChartExpediente extends StatefulWidget {
//   PChartExpediente({Key? key}) : super(key: key);
//   List<Cita> Citas = PCitaSortbyDate;
//   @override
//   State<PChartExpediente> createState() => _PChartExpedienteState();
// }

// class _PChartExpedienteState extends State<PChartExpediente> {
//   ScrollController scrollChartController = ScrollController();
//   List<ChartData> chartData = [
//     ChartData(Cita.Empty(), '22/5/21'),
//   ];

//   void getCitas() {
//     widget.Citas = PCitaSortbyDate;
//     if (widget.Citas.isEmpty) return;
//     widget.Citas = widget.Citas.where((element) =>
//         element.detalleCita.categoriaProductos == 2 &&
//         element.dataGeneral.revisado == 1).toList();

//     chartData = [];

//     widget.Citas.forEach((element) {
//       chartData.add(ChartData(
//           element,
//           PDateToStringDDMMAA(PStringToDateAAAAMMDD(
//               element.dataGeneral.fechaInicio!,
//               splitChar: "-"))));
//     });
//     setState(() {});
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     getCitas();
//     return AdaptiveScrollbar(
//       underDecoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: Colors.grey)),
//       controller: scrollChartController,
//       underSpacing: EdgeInsets.only(bottom: 60, top: 60, right: 300),
//       width: 30,
//       sliderDefaultColor: Colors.transparent,
//       underColor: Colors.transparent,
//       sliderActiveColor: Colors.transparent,
//       sliderHeight: 30,
//       sliderChild: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(shape: BoxShape.circle, color: Pazulshiny),
//       ),
//       position: ScrollbarPosition.bottom,
//       child: SingleChildScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         controller: scrollChartController,
//         scrollDirection: Axis.horizontal,
//         child: Container(
//           width: 200,
//           child: SfCartesianChart(
//               tooltipBehavior: TooltipBehavior(
//                   tooltipPosition: TooltipPosition.auto,
//                   builder: (dynamic data, dynamic point, dynamic series,
//                       int pointIndex, int seriesIndex) {
//                     return Container(
//                       padding: EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Colors.grey,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             height: 10,
//                             width: 10,
//                             decoration: BoxDecoration(
//                               color: IMCColor(IMC(
//                                   (data as ChartData).y.dataGeneral.altura ??
//                                       0.0,
//                                   (data as ChartData)
//                                           .y
//                                           .dataGeneral
//                                           .pesoActual ??
//                                       0.0)),
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "${(data as ChartData).y.dataGeneral.pesoActual ?? 0.0} Kg",
//                             style: PtextstyleButton(),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   enable: true,
//                   color: Pazuldark,
//                   shouldAlwaysShow: true,
//                   canShowMarker: true,
//                   shared: true,
//                   header: "",
//                   format: "point.y "),
//               selectionType: SelectionType.point,
//               zoomPanBehavior: ZoomPanBehavior(
//                   enablePinching: false,
//                   enablePanning: false,
//                   zoomMode: ZoomMode.x),
//               borderColor: Colors.transparent,
//               plotAreaBorderColor: Colors.transparent,
//               primaryXAxis: CategoryAxis(
//                 interactiveTooltip: InteractiveTooltip(),
//                 plotOffset: 5,
//                 axisLine: AxisLine(width: 0),
//                 majorTickLines: MajorTickLines(width: 0),
//                 majorGridLines: MajorGridLines(width: 0),
//               ),
//               primaryYAxis: NumericAxis(
//                   majorGridLines: MajorGridLines(width: .5, color: Pacua),
//                   majorTickLines: MajorTickLines(width: 0),
//                   axisLine: AxisLine(width: 0),
//                   numberFormat: NumberFormat.simpleCurrency(
//                       name: 'Kg ', decimalDigits: 0)),
//               series: <ChartSeries>[
//                 // Renders line chart
//                 LineSeries<ChartData, String>(
//                     enableTooltip: true,
//                     dataSource: chartData,
//                     xValueMapper: (ChartData data, _) => data.x,
//                     yValueMapper: (ChartData data, _) =>
//                         data.y.dataGeneral.pesoActual ?? 0.0,
//                     color: Pacua,
//                     markerSettings: MarkerSettings(
//                         isVisible: true,
//                         color: Pblanco,
//                         shape: DataMarkerType.image,
//                         image: AssetImage("assets/images/iconimg/mas.png"),
//                         borderColor: null,
//                         borderWidth: 0))
//               ]),
//         ),
//       ),
//     );
//   }
// }

// class ChartData {
//   ChartData(this.y, this.x);
//   final Cita y;
//   final String x;
// }
