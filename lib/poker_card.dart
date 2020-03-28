import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PokerCard extends StatelessWidget {
  const PokerCard({
    Key key,
    @required this.document,
  }) : super(key: key);

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.all(20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: new BorderSide(color: Colors.blue, width: 15),
      ),
      child: SizedBox(
        width: 270,
        height: 460,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 30),
            new Text(
              document['estimate'].toString(),
              style: TextStyle(fontSize: 180),
            ),
            new Text(
              document['name'],
              style: TextStyle(fontSize: 30),
            )
          ]
        ),
      ),
    );
  }
}