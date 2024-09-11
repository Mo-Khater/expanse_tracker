import 'package:flutter/material.dart';
import 'package:expanse_tracker/models/expanse.dart';

class NewExpanse extends StatefulWidget {
  final void Function(Expanse) addExpanse;
  const NewExpanse(this.addExpanse, {super.key});
  @override
  State<NewExpanse> createState() {
    return _NewExpanseState();
  }
}

class _NewExpanseState extends State<NewExpanse> {
  final _titleController = TextEditingController(); // Fixed the typo here
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    DateTime firstDate = DateTime(now.year - 1, now.month);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void submitChanges() {
    bool emtpyTitle = _titleController.text.trim().isEmpty;
    double? amount = double.tryParse(_amountController.text);
    bool notValidAmount = amount == null || amount < 0;
    if (emtpyTitle || notValidAmount || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text("plz make sure you enter valid data"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okey"))
            ],
          );
        },
      );
      return;
    }
    final Expanse newExpanse = Expanse(
        date: _selectedDate!,
        titel: _titleController.text,
        amount: amount,
        category: _selectedCategory);
    Navigator.pop(context);
    widget.addExpanse(newExpanse);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, contrains) {
      double width = contrains.maxHeight;
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              if (width > 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController, // Fixed the typo here
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text("Amount"),
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: _titleController, // Fixed the typo here
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Title')),
                ),
              if (width > 600)
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map((e) => DropdownMenuItem(
                                value: e, child: Text(e.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? 'No Date is selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          )
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
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text("Amount"),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 10), // Add some space between the widgets
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? 'No Date is selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  if (width < 600)
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map((e) => DropdownMenuItem(
                                value: e, child: Text(e.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: submitChanges,
                    child: const Text('Save Changes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
