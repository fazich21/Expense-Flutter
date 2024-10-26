import 'package:expanse/expense_data.dart';
import 'package:expanse/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{

  await Hive.openBox("expense_database");
  runApp(Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ChangeNotifierProvider(create: (context)=> ExpenseData(),
    builder:(context, child)=>const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ) ,
    );
  }
}
