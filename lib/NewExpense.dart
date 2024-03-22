import "package:expense_tracker_app/models/Expense.dart";

import "package:flutter/material.dart";

class NewExpense extends StatefulWidget {
  const NewExpense(this._addNewExpense, {super.key});

  final void Function(Expense expense) _addNewExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _openCalendar(context) async {
    final nowDate = DateTime.now();
    final firstDate = DateTime(nowDate.year - 1, nowDate.month, nowDate.day);
    final currentDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: nowDate);

    setState(() {
      _selectedDate = currentDate;
    });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;

    if (_textController.text.isEmpty || amountIsValid) {
      showDialog(
        context: context,
        builder: (cxt) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please give correct Title, amount, category and date"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(cxt);
                },
                child: const Text("Okay"))
          ],
        ),
      );
      return;
    }

    widget._addNewExpense(Expense(_textController.text, enteredAmount,
        _selectedDate!, _selectedCategory));
    Navigator.pop(context);

  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16,16),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "No date selected"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: () {
                        _openCalendar(context);
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toString().toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      } else {
                        _selectedCategory = value;
                      }
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    submitExpenseData();
                  },
                  child: const Text("Save Response")),
            ],
          ),
        ],
      ),
    );
  }
}
