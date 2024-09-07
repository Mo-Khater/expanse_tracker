import 'package:flutter/material.dart';

class NewExpanse extends StatefulWidget {
  const NewExpanse({super.key});
  @override
  State<NewExpanse> createState() {
    return _NewExpanseState();
  }
}

class _NewExpanseState extends State<NewExpanse> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          )
        ],
      ),
    );
  }
}
