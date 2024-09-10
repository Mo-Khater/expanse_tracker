import 'package:expanse_tracker/models/expanse.dart';
import 'package:flutter/material.dart';

class ExpansesCard extends StatelessWidget {
  final Expanse expanse;
  const ExpansesCard(this.expanse, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expanse.titel,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('\$${expanse.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expanse.category]),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(expanse.formatDate)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
