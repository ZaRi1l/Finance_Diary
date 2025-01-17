

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';

import '../data/diaryListData.dart';

ListAddData lad = ListAddData();

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;



  text = Text(value.toInt().toString(), style: style);
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;

  return Text(value.toInt().toString(), style: style, textAlign: TextAlign.left);
}

LineChartData ChartData(int index, tum) {
  List tumList = [20, 4, 0.8, 0.16];

  var yIndex = int.parse(ListAddData.analData[2])/tumList[tum];
  var xIndex = lad.getFilterData().length~/5;
  if (xIndex == 0) {
    xIndex += 1;
  }
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: yIndex,
      verticalInterval: xIndex * 1.0,
      getDrawingHorizontalLine: (value) {
        // if ((value % yIndex).toInt() == 0) {
          return FlLine(
            color: Colors.black26,
            strokeWidth: 2,
          );
        // } else {
        //   return FlLine(
        //     color: Colors.transparent,
        //     strokeWidth: 0,
        //   );
        // }
      },
      getDrawingVerticalLine: (value) {
        // if (xIndex != 0) {
        //   if ((value % xIndex).toInt() == 0) {
        //     return FlLine(
        //       color: Colors.black,
        //       strokeWidth: 1,
        //     );
        //   } else {
        //     return FlLine(
        //       color: Colors.transparent,
        //       strokeWidth: 0,
        //     );
        //   }
        // } else {
          return const FlLine(
            color: Colors.black26,
            strokeWidth: 2,
          );
        // }
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: xIndex * 1.0,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: yIndex,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: yIndex.toString().length * 8 ,


        ),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.green, width: 3),
    ),
    lineBarsData: [
      LineChartBarData(
        spots: spotDivide(index),
        isCurved: false,
        color: Colors.black,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
            color: Color(0x4C00FF23),
            applyCutOffY: true,
        ),
        aboveBarData: BarAreaData(
          show: true,
          color: Color(0x7CFF0000),
          applyCutOffY: true
        )
      ),
    ],
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.white,
      ),

    )
  );
}

spotDivide(index) {
  print(lad.getAllProfit());
  if(index == 0) {
    lad.calAllProfit();
    return spotData2(lad.getAllProfit());
  } else if (index == 1) {
    return spotData(lad.getFilterData2());
  }
}

spotData(data) {
  List<FlSpot> sd = [];

  for (var i = 0; i < data.length; i++) {
    sd.add(FlSpot((i+1).toDouble(), data[i][5]));
  }

  return sd;
}

spotData2(data) {
  List<FlSpot> sd = [];

  for (var i = 0; i < data.length; i++) {
    sd.add(FlSpot((i+1).toDouble(), data[i]));
  }

  return sd;
}