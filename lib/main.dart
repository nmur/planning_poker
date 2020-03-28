import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'poker_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planning Poker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Planning Poker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Firestore.instance.collection('estimates').document('Gary').setData({'estimate': 3});
          },
          child: Text(widget.title)
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: myController,
                  style: TextStyle(fontSize: 30),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              StreamBuilder(
                stream: Firestore.instance.collection('estimates').snapshots(),
                builder: (context, snapshot)
                {
                  if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: 
                      return new Text('Loading...');
                    default:
                      return new Wrap(
                        alignment: WrapAlignment.center,
                        children: snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
                          return PokerCard(document: document);
                        }).toList()
                      );
                  }
                }
              ),
              ButtonBar(
                children: <Widget>[
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
                    color: Colors.blue,
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
                    color: Colors.blue,
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
              )
            ]
          ),
        ],
      )
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
        .setData({'estimate': value});
      },
    );
  }
}

