import 'package:expanse/date_time_helper.dart';
import 'package:expanse/hive_database.dart';
import 'package:flutter/material.dart';
import 'package:expanse/expense_item.dart';
import 'expense_item.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpenseList = [];

  // Get expense list
  List<ExpenseItem> getallExpenseList() {
    return overallExpenseList;
  }

  // Add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    saveToLocalStorage();  // Save after adding
    notifyListeners();
  }

  // Delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    saveToLocalStorage();  // Save after deletion
    notifyListeners();
  }

  // Save the list of expenses to local storage as JSON
  void saveToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = overallExpenseList.map((expense) => jsonEncode(expense.toJson())).toList();
    prefs.setStringList('expenses', jsonList);
  }

  // Load the list of expenses from local storage
  void loadFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('expenses');

    if (jsonList != null) {
      overallExpenseList = jsonList.map((item) => ExpenseItem.fromJson(jsonDecode(item))).toList();
    }
    notifyListeners();
  }

  // Get the start of the week
  DateTime startOFWeekDate() {
    DateTime? startOFWeek;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOFWeek = today.subtract(Duration(days: i));
      }
    }
    return startOFWeek!;
  }

  // Helper functions for weekly summary
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
