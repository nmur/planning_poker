import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EstimationButtonBar extends StatelessWidget {
  const EstimationButtonBar({
    Key key,
    @required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        buildEstimationButton(value: 0),
        buildEstimationButton(value: 1),
        buildEstimationButton(value: 2),
        buildEstimationButton(value: 3),
        buildEstimationButton(value: 5),
        buildEstimationButton(value: 8),
        buildEstimationButton(value: 13),
        buildEstimationButton(value: 20),
        buildEstimationButton(value: 40),
        FlatButton(
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 24.0,
          ),
          color: Colors.red,
          onPressed: () {
            Firestore.instance
            .collection('estimates')
            .document(myController.text)
            .delete();
          },
        ),
        FlatButton(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 24.0,
              ),
              Text('ALL'),
            ],
          ),
          color: Colors.red,
          onPressed: () {
            Firestore.instance
            .collection('estimates')
            .getDocuments()
            .then((snapshot) {
              for (DocumentSnapshot documentSnapshot in snapshot.documents) {
                documentSnapshot.reference.delete();
              }
            });
          }
        ),
      ],
    );
  }

  FlatButton buildEstimationButton({int value}) {
    return FlatButton(
      child: Text(value.toString()),
      color: Colors.blue,
      onPressed: () {
        Firestore.instance
        .collection('estimates')
        .document(myController.text)
        .setData({'estimate': value, 'revealed': false});
      },
    );
  }
}

