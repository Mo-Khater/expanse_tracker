import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expanse {
  Expanse(
      {required this.date,
      required this.titel,
      required this.amount,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String titel;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatDate {
    return formatter.format(date);
  }
}

class ExpanseBacket {
  final Category category;
  final List<Expanse> expanses;

  ExpanseBacket(this.expanses,this.category);

  ExpanseBacket.forCategory(
      List<Expanse> allExpanses, this.category)
      : expanses = allExpanses
            .where((expanse) => expanse.category == category)
            .toList();

  double get categoryAmount{
    double sum=0;
    for(final expanse in expanses){
      sum+=expanse.amount;
    }
    return sum;
  }

  
}
