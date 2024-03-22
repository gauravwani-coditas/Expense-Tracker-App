import 'package:expense_tracker_app/models/Expense.dart';
import 'package:expense_tracker_app/widgets/ExpenseItem.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this._expenseList,this.onRemoveExpense, {super.key});

  final List<Expense> _expenseList;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _expenseList.length,
        itemBuilder: (cxt, index) => Dismissible(
          key: ValueKey(_expenseList[index]),
          onDismissed: (direction) => onRemoveExpense(_expenseList[index]),
          child: ExpenseItem(_expenseList[index])));
  }
}
