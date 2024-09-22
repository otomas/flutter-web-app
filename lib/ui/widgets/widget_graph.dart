import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../core/resources/_r.dart';
import 'widgets_text.dart';

class WidgetCustomGraph<T> extends StatelessWidget {
  const WidgetCustomGraph({
    required this.data,
    required this.xValueMapper,
    required this.yValueMapper,
    required this.seconYValueMapper,
    required this.buyLabelText,
    required this.sellLabelText,
    required this.header,
    required this.firstBarColor,
    required this.secondBarColor,
    required this.borderColor,
    super.key,
  });
  final List<T> data;
  final String Function(T) xValueMapper;
  final double Function(T) yValueMapper;
  final double Function(T) seconYValueMapper;
  final String buyLabelText;
  final String sellLabelText;
  final String? header;
  final Color firstBarColor;
  final Color secondBarColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
          child: SizedBox(
            width: size.width,
            child: header != null
                ? TextBasic(
                    text: header!,
                    color: R.themeColor.smoke,
                    fontFamily: R.fonts.displayBold,
                    fontSize: 16,
                  )
                : Container(),
          ),
        ),
        Container(
          width: size.width,
          height: 350,
          margin: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: R.themeColor.borderLight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  title: ChartTitle(
                    alignment: ChartAlignment.near,
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  margin: const EdgeInsets.all(10),
                  legend: const Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(),
                  plotAreaBorderColor: Colors.transparent,
                  series: <ChartSeries>[
                    BarSeries<T, String>(
                      name: '',
                      dataSource: data,
                      xValueMapper: (data, _) => xValueMapper(data),
                      yValueMapper: (data, _) => yValueMapper(data),
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      color: firstBarColor,
                      width: 0.2,
                      spacing: 0.2,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    BarSeries<T, String>(
                      name: '',
                      dataSource: data,
                      xValueMapper: (data, _) => xValueMapper(data),
                      yValueMapper: (data, _) => seconYValueMapper(data),
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      width: 0.2,
                      spacing: 0.2,
                      color: secondBarColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ],
                  primaryXAxis: CategoryAxis(
                    majorTickLines: const MajorTickLines(size: 0),
                    majorGridLines: const MajorGridLines(color: Colors.transparent),
                    axisLine: const AxisLine(
                      color: Colors.white,
                    ),
                    axisBorderType: AxisBorderType.withoutTopAndBottom,
                  ),
                  primaryYAxis: NumericAxis(
                    plotOffset: 20,
                    axisLine: const AxisLine(
                      color: Colors.white,
                    ),
                    labelAlignment: LabelAlignment.center,
                    majorTickLines: const MajorTickLines(size: 0),
                    majorGridLines: MajorGridLines(color: borderColor),
                    axisBorderType: AxisBorderType.withoutTopAndBottom,
                  ),
                  isTransposed: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle_rounded,
                          size: 20,
                          color: firstBarColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextBasic(
                          text: buyLabelText,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle_rounded,
                          size: 20,
                          color: secondBarColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextBasic(
                          text: sellLabelText,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
