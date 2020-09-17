import 'package:flutter/material.dart';

class AnimalDetailListTile extends StatelessWidget {
  final String leadingText;
  final String trailingText;
  AnimalDetailListTile({this.leadingText, this.trailingText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 10,
          child: Text(leadingText, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500)),
        ),
        Expanded(
          flex: 1,
          child: Text(':'),
        ),
        Expanded(
          flex: 19,
          child: Text(trailingText, style: TextStyle(color: Colors.grey[800])),
        ),
      ],
    );
  }
}
