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
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(MediaQuery.of(context).size.width * 0.009)),
        side: new BorderSide(
            color: document['revealed'] ? Colors.blue : Colors.grey,
            width: MediaQuery.of(context).size.width * 0.007),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.09,
        height: MediaQuery.of(context).size.width * 0.15,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
          new Text(
            document['revealed'] ? document['estimate'].toString() : '?',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06),
          ),
          new Text(
            document.documentID,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.01),
          )
        ]),
      ),
    );
  }
}
