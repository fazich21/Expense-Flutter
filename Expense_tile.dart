import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteTapped,
                icon: Icons.delete_outline_outlined,
                backgroundColor: Colors.redAccent,
              ),
            ],
          ),
          child: ListTile(
            title: Text(name),
            subtitle: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
            trailing: Text('\Rs $amount'),
          ),
        ),
        // Divider to separate each tile
        Divider(
          color: Colors.black.withOpacity(0.2), // Light black color
          thickness: 1, // Adjust thickness as needed
        ),
      ],
    );
  }
}
