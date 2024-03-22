import "package:expense_tracker_app/NewExpense.dart";
import "package:expense_tracker_app/models/Expense.dart";
import "package:expense_tracker_app/widgets/ExpenseList.dart";
import "package:flutter/material.dart";

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {


  final List<Expense> _expenseList = [
    Expense("Rajbhog Kachori", 120, DateTime.now(), Category.food),
    Expense("Sinhagad", 220, DateTime.now(), Category.travel),
    Expense("Earphones", 450, DateTime.now(), Category.work),
  ];

  void _onAddNewExpense(Expense expense){
    setState(() {
      _expenseList.add(expense);
    });
  }

  void _onRemoveExpense(Expense expense){
    int expenseIndex = _expenseList.indexOf(expense);
    setState(() {
      _expenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Expense Deleted !"),action: SnackBarAction(label: "Undo", onPressed: (){
      setState(() {
         _expenseList.insert(expenseIndex,expense);
      });
    }),),);
  }

  void _openAddExpenseOverlay(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(_onAddNewExpense);
        });
  }


  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(
      child: Text("No Expense found. Start adding some !"),
    );

    if(_expenseList.isNotEmpty){
      mainContent = ExpenseList(_expenseList,_onRemoveExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: (){_openAddExpenseOverlay(context);},
              icon: const Icon(
                Icons.add,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text("The Chart"),
            Expanded(
              child: mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
