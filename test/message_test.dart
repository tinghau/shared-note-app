import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/block.dart';
import 'package:myapp/message.dart';

void main() {
  final Message message = Message.fromBlocks([new Block("hello", 1), new Block("world", 1)]);
  Map<String, dynamic> map = {'blocks':[{'text':'hello', 'version':1}, {'text':'world', 'version':1}]};

  test('Json should be created from message', () {
    expect(message.toJson(), map);
  });

  test('Message should be created from Json', () {
    expect(Message.fromJson(map), message);
  });

  test('Message should be a copy', () {
    expect(Message.copy(message), message);
  });

  test('Message should be created from blocks', () {
    Message actual = Message.fromBlocks([new Block("hello", 1), new Block("world", 1)]);
    actual.update("hi\nthere");

    Message expected = Message.fromBlocks([new Block("hi", 2), new Block("there", 2)]);
    expect(actual, expected);
  });

  test('Message should be updated from Json', () {
    Message actual = Message.fromBlocks([new Block("hello", 1), new Block("world", 1)]);
    Map<String, dynamic> newMap = {'blocks':[{'text':'hi', 'version':2}, {'text':'there', 'version':2}]};
    actual.fromJson(newMap);

    Message expected = Message.fromBlocks([new Block("hi", 2), new Block("there", 2)]);
    expect(actual, expected);
  });

  test('Message should be updated from init', () {
    Message actual = Message();
    actual.update("hello\nworld");

    expect(actual, message);
  });

  test('Message toText() transform', () {
    expect(message.toText(), "hello\nworld\n");
  });

  test('Message should be cleared', () {
    message.clear();
    expect(true, message.blocks.isEmpty);
  });
}