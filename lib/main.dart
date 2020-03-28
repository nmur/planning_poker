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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
          stream: Firestore.instance.collection('estimates').snapshots(),
          builder: (context, snapshot)
          {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: 
                return new Text('Loading...');
              default:
                return new Wrap(
                  children: snapshot.data.documents.map<Widget>((DocumentSnapshot document) {
                    return PokerCard(document: document);
                  }).toList()
                );
            }
          }
        ),
      )
    );
  }
}

