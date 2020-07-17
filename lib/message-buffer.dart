
import 'dart:collection';

import 'message.dart';

class MessageBuffer {
  List<Message> removeBuffer = new List();
  ListQueue<Message> messages = new ListQueue();

  void add(Message message) {
    messages.add(message);
    print("Added " + message.toString());
    if (messages.length > 100) {
      messages.removeFirst();
    }
  }

  bool isLocalChange(Message newMessage) {
    for (Message bufferedMessage in messages) {
      if (bufferedMessage == newMessage) {
        return true;
      }
    }
    return false;
  }

  Queue<Message> get() {
    return messages;
  }
}