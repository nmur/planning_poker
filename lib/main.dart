import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                        child: Center(
                          child: new Text(
                            document['estimate'].toString(),
                            style: TextStyle(fontSize: 180),
                            ),
                        ),
                      ),
                    );
                  }).toList()
                );
            }
          }
        ),
      )
    );
  }
}
