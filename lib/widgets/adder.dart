import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class QuickMenu extends StatefulWidget {
  const QuickMenu({required this.addExpense, super.key});

  final void Function(Expense expense) addExpense;

  @override
  State<QuickMenu> createState() => QuickMenuState();
}

class QuickMenuState extends State<QuickMenu> {
  //var title = '';

  /*void inputTitle(String givenTitle) {
    title = givenTitle;
  }*/

  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime? _picked;
  Category _selected = Category.food;

  @override
  void dispose() {
    _titleInput.dispose();
    _amountInput.dispose();
    super.dispose();
  }

  void _datePicker() async {
    final now = DateTime.now();
    final first = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );
    var date =
        await showDatePicker(context: context, firstDate: first, lastDate: now);

    setState(() {
      _picked = date;
    });
  }

  void _validate() {
    final amountNumeric = double.tryParse(_amountInput.text);
    final amountInvalid = amountNumeric == null || amountNumeric <= 0;

    if (amountInvalid || _picked == null || _titleInput.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Problem with data"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Ok"),
            ),
          ],
          content: const Text("Please enter valid data"),
        ),
      );
      return;
    } else {
      widget.addExpense(
        Expense(
            amount: amountNumeric,
            category: _selected,
            date: _picked!,
            title: _titleInput.text),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              10,
              10,
              10,
              10 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleInput,
                          //onChanged: inputTitle,
                          maxLength: 30,
                          decoration: const InputDecoration(
                            label: Text("Enter expense name"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountInput,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            label: Text("Expense amount"),
                            prefixText: '\$ ',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleInput,
                    //onChanged: inputTitle,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      label: Text("Enter expense name"),
                    ),
                  ),
                if (width > 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selected,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selected = value;
                          });
                        },
                      ),
                      const Spacer(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _picked == null
                                  ? "No date selected"
                                  : formatter.format(_picked!),
                            ),
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountInput,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            label: Text("Expense amount"),
                            prefixText: '\$ ',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _picked == null
                                  ? "No date selected"
                                  : formatter.format(_picked!),
                            ),
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (width > 600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _validate,
                        child: const Text("Save expense"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //print(MediaQuery.of(context).viewPadding.bottom);
                        },
                        child: const Text("Cancel"),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selected,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selected = value;
                          });
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _validate,
                        child: const Text("Save expense"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //print(MediaQuery.of(context).viewPadding.bottom);
                        },
                        child: const Text("Cancel"),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
