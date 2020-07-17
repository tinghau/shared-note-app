// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Small Steps',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: NextSteps(),
    );
  }
}

class NextStepsState extends State<NextSteps> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Small Steps'),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(10,10,10,0),
          height: 220,
        width: double.maxFinite,
        child: buildCard(),
    ),
    );
  }

  Widget buildCard() {
    return Card(
      child: Column(
        children: <Widget>[
          Text("Item 1a"),
          Text("Item 1b"),
          Text("Item 1c"),
          Text("Item 1d"),
          Text("Item 2a"),
          Text("Item 2b"),
          Text("Item 3a"),
        ],
      )
    );
  }
}

class NextSteps extends StatefulWidget {
  @override
  NextStepsState createState() => NextStepsState();
}