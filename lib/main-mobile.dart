// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/message-buffer.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'message.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Note',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SharedForm(),
    );
  }
}

class SharedForm extends StatefulWidget {
  @override
  SharedFormState createState() => SharedFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class SharedFormState extends State<SharedForm> {

  static final IP = '35.230.15.201';
//  static final IP = '10.0.2.2';

  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final message = Message();
  final messageBuffer = MessageBuffer();

  WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    controller.addListener(printLatestValue);
  }

  void initStream() {
    channel.stream.listen(
      (data) {
        handleMessage(data);
      },
      onError: (error) {
        print('Error!');
      },
      onDone: () {
        print('Done!');
      },
    );
  }

  void handleMessage(Object data) {
    Message incoming = Message.fromJson(jsonDecode(data));
    print("Incoming data: " + message.toText());
    if (!messageBuffer.isLocalChange(incoming)) {
      message.fromJson(jsonDecode(data));
      TextEditingValue editingValue = controller.value.copyWith(
          text: message.toText());
      controller.value = editingValue;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Note'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 440,
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            getSessionField(),
            getTextField(),
          ],
        ),
      ),
    );
  }

  Widget getSessionField() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Session Id',
            ),
            maxLines: 1,
            onFieldSubmitted: (value) {
              print('onFieldSubmitted $value');
              setSessionId(value);
            },
            onSaved: (value) {
              print('onSaved $value');
              setSessionId(value);
            },
            validator: (value) {
              Pattern pattern = r'^[A-Za-z0-9]+(?:[A-Za-z0-9]+)*$';
              RegExp regex = new RegExp(pattern);
              if (!regex.hasMatch(value)) {
                return 'Invalid session Id, use alpha-numeric values only.';
              } else {
                return null;
              }
            }
          ),
          RaisedButton(
            child: Text(
              'Connect',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getTextField() {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter text',
      ),
      maxLines: 10,
    );
  }

  printLatestValue() {
    bool updated = message.update(controller.text);
    if (updated) {
      print("Publishing message: $message");
      messageBuffer.add(Message.copy(message));
      channel.sink.add(jsonEncode(message.toJson()));
    }
  }

  setSessionId(String sessionId) {
    String url = 'ws://' + IP + ':8080/shared/' + sessionId;

    print('Updating channel: ' + url);
    if (channel != null && channel.sink != null) {
      channel.sink.close();
    }
    channel = IOWebSocketChannel.connect(url);
    message.clear();
    initStream();
  }
}