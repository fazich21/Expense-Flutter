import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph({super.key,
  required this.maxY,
  required this.sunAmount,
  required this.monAmount,
  required this.tueAmount,
  required this.wedAmount,
  required this.thurAmount,
  required this.friAmount,
  required this.satAmount,

  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData=BarData(sunAmount:sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );
     myBarData.intializeBarData();
    return BarChart(BarChartData(
      maxY: maxY,
      minY: 0,
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
             getTitlesWidget: getBottomTitles,
          )
        )
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: myBarData.barData.map((data) => BarChartGroupData(x: data.x,barRods: [
        BarChartRodData(toY: data.y,
        color: Colors.grey[800],
          width: 25,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxY,
            color: Colors.grey[200],
          )
        ),
      ]
      )).toList(),
    ));
  }
}
Widget getBottomTitles(double value,TitleMeta meta){
   const Style =TextStyle(color:
   Colors.grey,
     fontWeight: FontWeight.bold,
     fontSize: 15,
   );
   Widget text;
   switch(value.toInt()){
     case 0:
       text= const Text('Sun',style: Style);
       break;
     case 1:
       text= const Text('Mon',style: Style);
       break;
     case 2:
       text= const Text('Tue',style: Style);
       break;
     case 3:
       text= const Text('Wed',style: Style);
       break;
     case 4:
       text= const Text('Thu',style: Style);
       break;
     case 5:
       text= const Text('Fri',style: Style);
       break;
     case 6:
       text= const Text('Sat',style: Style);
       break;
     default:
       text= const Text('',style: Style);
   break;
   }
   return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
