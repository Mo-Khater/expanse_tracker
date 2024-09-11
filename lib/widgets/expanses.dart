import 'package:expanse_tracker/widgets/chart/chart.dart';
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

  void addExpanse(Expanse newExpanse) {
    setState(() {
      _expanses.add(newExpanse);
    });
  }

  void _addExpense() {
    //showModalBottomSheet
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpanse(addExpanse));
  }

  void _removeExpense(Expanse expanse) {
    final expanseIndex = _expanses.indexOf(expanse);
    setState(() {
      _expanses.remove(expanse);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('expanse deleted'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _expanses.insert(expanseIndex, expanse);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('no expanses found start add some'),
    );

    if (_expanses.isNotEmpty) {
      mainContent = ExpansesList(_expanses, _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter expanse tracker"),
        actions: [
          IconButton(onPressed: _addExpense, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _expanses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _expanses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
