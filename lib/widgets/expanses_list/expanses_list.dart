import 'package:expanse_tracker/widgets/expanses_list/expanses_card.dart';
import 'package:expanse_tracker/models/expanse.dart';
import 'package:flutter/material.dart';

class ExpansesList extends StatelessWidget {
  final List<Expanse> expanses;
  final void Function(Expanse expanse) onDismissed;
  const ExpansesList(this.expanses, this.onDismissed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expanses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          color: Theme.of(context).colorScheme.surfaceTint, 
        ),
        key: ValueKey(expanses[index]),
        child: ExpansesCard(expanses[index]),
        onDismissed: (direction) => {onDismissed(expanses[index])},
      ),
    );
  }
}
