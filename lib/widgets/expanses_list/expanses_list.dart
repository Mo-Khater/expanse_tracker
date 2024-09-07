import 'package:expanse_tracker/widgets/expanses_list/expanses_card.dart';
import 'package:expanse_tracker/models/expanse.dart';
import 'package:flutter/material.dart';

class ExpansesList extends StatelessWidget {
  final List<Expanse> expanses;

  const ExpansesList(this.expanses, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expanses.length,
        itemBuilder: (ctx, index) => ExpansesCard(expanses[index]));
  }
}
