import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expanse/calculator.dart';
import 'package:expanse/calendar.dart';
import 'package:expanse/expense_data.dart';
import 'package:expanse/expense_item.dart';
import 'package:expanse/expense_summary.dart';
import 'package:expanse/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load expenses when the page is initialized
    Provider.of<ExpenseData>(context, listen: false).loadFromLocalStorage();
  }
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
                labelText: "Expense name",
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: newExpenseAmountController,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text("Save"),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text("Cancel"),
          )
        ],
      ),
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text, // Convert to double
        dateTime: DateTime.now(),
      );
      Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          elevation: 0.0, // Remove shadow
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_active_outlined, color: Colors.black, size: 30), // Bell icon
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Bss krr"),
                    content: Text("Bht Kharcha ho gaya hai!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.grey.shade300,
          color: Colors.white30,
          items: [
            Icon(Icons.calendar_month_outlined),
            Icon(Icons.pie_chart),
            Icon(Icons.calculate_rounded),
          ],
          onTap: (index) {
            Future.delayed(Duration(seconds: 1),()
            {
              if (index == 0) {
                // Navigate to CalendarPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              } else if (index == 2) {
                // Navigate to CalculatorPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorApp()),
                );
              }
            });
          },
        ),
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add_circle_outline),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            SizedBox(height: 20),
            ExpenseSummary(startOfWeek: value.startOFWeekDate()),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add padding if needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "All Expenses",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_downward_outlined, // Arrow icon
                    size: 25,
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getallExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getallExpenseList()[index].name,
                amount: value.getallExpenseList()[index].amount,
                dateTime: value.getallExpenseList()[index].dateTime,
                deleteTapped: (p0) => deleteExpense(value.getallExpenseList()[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
