import 'package:expanse_tracker/widgets/expanses_list/expanses_list.dart';
import 'package:expanse_tracker/models/expanse.dart';
import 'package:expanse_tracker/widgets/new_expanse.dart';
import 'package:flutter/material.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() {
    return _ExpansesState();
  }
}

class _ExpansesState extends State<Expanses> {
  final List<Expanse> _expanses = [
    Expanse(
        date: DateTime.now(),
        titel: "flutter course",
        amount: 15.22,
        category: Category.work),
    Expanse(
        date: DateTime.now(),
        titel: "cinema",
        amount: 12.22,
        category: Category.leisure),
  ];

  void _addExpense() {
    //showModalBottomSheet
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpanse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _addExpense, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text("char"),
          Expanded(child: ExpansesList(_expanses))
        ],
      ),
    );
  }
}
