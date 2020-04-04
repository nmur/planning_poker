import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EstimationButtonBar extends StatelessWidget {
  const EstimationButtonBar({
    Key key,
    @required this.myController, this.estimate,
  }) : super(key: key);

  final TextEditingController myController;
  final int estimate;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      buttonPadding: EdgeInsets.all(0),
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
        GestureDetector(
          child: new Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              side: new BorderSide(color: Colors.red, width: 5),
            ),
            child: SizedBox(
                width: 60,
                height: 100,
                child: Center(
                    child: Icon(
                  Icons.delete,
                  size: 40.0,
                ))),
          ),
          onTap: () {
            Firestore.instance
                .collection('estimates')
                .document(myController.text)
                .delete();
          },
        ),
        GestureDetector(
          child: new Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              side: new BorderSide(color: Colors.red, width: 5),
            ),
            child: SizedBox(
                width: 60,
                height: 100,
                child: Column(children: <Widget>[
                  SizedBox(height: 30),
                  Icon(
                    Icons.delete,
                    size: 40.0,
                  ),
                  Text('ALL', style: TextStyle(fontSize: 18),),
                ])),
          ),
          onTap: () {
            Firestore.instance
                  .collection('estimates')
                  .getDocuments()
                  .then((snapshot) {
                for (DocumentSnapshot documentSnapshot in snapshot.documents) {
                  documentSnapshot.reference.delete();
                }
              });
          },
        ),
      ],
    );
  }

  Widget buildEstimationButton({int value}) {
    return GestureDetector(
      child: new Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          side: new BorderSide(color: value == estimate ? Colors.green : Colors.blue, width: 5),
        ),
        child: SizedBox(
            width: 60,
            height: 100,
            child: Center(
                child: Text(
              value.toString(),
              style: TextStyle(fontSize: 40),
            ))),
      ),
      onTap: () {
        Firestore.instance
            .collection('estimates')
            .document(myController.text)
            .setData({'estimate': value, 'revealed': false});
      },
    );
  }
}
