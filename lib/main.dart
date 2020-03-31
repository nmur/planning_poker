import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'poker_card.dart';
import 'estimation_button_bar.dart';

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
        body: Container(
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 60,
              child: TextField(
                controller: myController,
                style: TextStyle(fontSize: 25),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            StreamBuilder(
                stream: Firestore.instance.collection('estimates').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Column(
                          children: <Widget>[
                            new Wrap(
                                alignment: WrapAlignment.center,
                                children: snapshot.data.documents
                                    .map<Widget>((DocumentSnapshot document) {
                                  return PokerCard(document: document);
                                }).toList()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new FlatButton(
                                  child: Text('Reveal All'),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    for (DocumentSnapshot document in snapshot.data.documents) {
                                      document.reference.updateData({'revealed': true});
                                    }
                                  },
                                ),
                                SizedBox(width: 20),
                                new FlatButton(
                                  child: Text('Hide All'),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    for (DocumentSnapshot document in snapshot.data.documents) {
                                      document.reference.updateData({'revealed': false});
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                  }
                }),
            EstimationButtonBar(myController: myController)
          ]),
    ));
  }
}
