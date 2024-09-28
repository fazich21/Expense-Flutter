import 'package:expanse/bar_graph.dart';
import 'package:expanse/date_time_helper.dart';
import 'package:expanse/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key,required this.startOfWeek});

  double calculateMax(ExpenseData value,String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String Thursday,
      String Friday,
      String Saturday,
      ){
    double? max=100;
    List<double>values=[
      value.calculateDailyExpenseSummary()[sunday]??0,
      value.calculateDailyExpenseSummary()[monday]??0,
      value.calculateDailyExpenseSummary()[tuesday]??0,
      value.calculateDailyExpenseSummary()[wednesday]??0,
      value.calculateDailyExpenseSummary()[Thursday]??0,
      value.calculateDailyExpenseSummary()[Friday]??0,
      value.calculateDailyExpenseSummary()[Saturday]??0,

    ];
    values.sort();
    max=values.last*1.1;
    return max==0?100:max;

  }
//calculate the total week
  String calculateWeekTotal(
      ExpenseData value,String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String Thursday,
      String Friday,
      String Saturday,
      ){
    List<double>values=[
      value.calculateDailyExpenseSummary()[sunday]??0,
      value.calculateDailyExpenseSummary()[monday]??0,
      value.calculateDailyExpenseSummary()[tuesday]??0,
      value.calculateDailyExpenseSummary()[wednesday]??0,
      value.calculateDailyExpenseSummary()[Thursday]??0,
      value.calculateDailyExpenseSummary()[Friday]??0,
      value.calculateDailyExpenseSummary()[Saturday]??0,
    ];
    double total=0;
    for(int i=0;i<values.length;i++){
      total +=values[i];
    }
    return total.toStringAsFixed(2);
  }


  @override
  Widget build(BuildContext context) {
    String sunday= convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday= convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday= convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday= convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String Thursday= convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String Friday= convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String Saturday= convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(builder: (context,value,child)=> Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0,left: 25.0,right: 20.0,bottom: 25.0),
          child: Row(
            children: [
              const Text("Total Expense:-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
              ),
              Text(' \Rs ${calculateWeekTotal(value, sunday, monday, tuesday,
                  wednesday, Thursday, Friday, Saturday)}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: MyBarGraph(maxY: calculateMax(value,
              sunday, monday, tuesday, wednesday, Thursday, Friday, Saturday),
            sunAmount: value.calculateDailyExpenseSummary()[sunday]??0,
            monAmount: value.calculateDailyExpenseSummary()[monday]??0,
            tueAmount: value.calculateDailyExpenseSummary()[tuesday]??0,
            wedAmount: value.calculateDailyExpenseSummary()[wednesday]??0,
            thurAmount: value.calculateDailyExpenseSummary()[Thursday]??0,
            friAmount: value.calculateDailyExpenseSummary()[Friday]??0,
            satAmount: value.calculateDailyExpenseSummary()[Saturday]??0,
          ),
        ),
      ],
    )
    );
  }
}
