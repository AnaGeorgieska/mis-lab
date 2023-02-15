import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';
import '../Models/list_item.dart';
import 'adaptive_flat_button.dart';

class NovElement extends StatefulWidget {
  final Function addItem;

  NovElement(this.addItem);
  @override
  State<StatefulWidget> createState() => _NovElementState();
}

class _NovElementState extends State<NovElement> {
  final _naslovController = TextEditingController();
  final _vrednostController = TextEditingController();

  late String subject;
  late String date;

  void _submitData() {
    if (_vrednostController.text.isEmpty) {
      return;
    }
    final vnesenNaslov = _naslovController.text;
    final vnesenaVrednost = _vrednostController.text;

    if (vnesenNaslov.isEmpty || vnesenaVrednost.isEmpty) {
      return;
    }

    final newItem = ListItem(id: nanoid(5), subject: vnesenNaslov, date: vnesenaVrednost);
    widget.addItem(newItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _naslovController,
            decoration: InputDecoration(labelText: "Subject"),
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            controller: _vrednostController,
            decoration: InputDecoration(labelText: "Date"),
            // keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          AdaptiveFlatButton("Add", _submitData)
        ],
      ),
    );
  }
}
