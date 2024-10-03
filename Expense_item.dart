
class ExpenseItem {
  final String name;
  final String amount;
  final DateTime dateTime;

  ExpenseItem({
    required this.name,
    required this.amount,
    required this.dateTime,
  });

  // Convert ExpenseItem to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'amount': amount,
    'dateTime': dateTime.toIso8601String(),
  };

  // Convert JSON to ExpenseItem
  factory ExpenseItem.fromJson(Map<String, dynamic> json) {
    return ExpenseItem(
      name: json['name'],
      amount: json['amount'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
