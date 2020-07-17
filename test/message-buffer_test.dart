
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/block.dart';
import 'package:myapp/message-buffer.dart';
import 'package:myapp/message.dart';

void main() {
  final MessageBuffer buffer = new MessageBuffer();

  final Message message = Message.fromBlocks([new Block("hello", 1), new Block("world", 1)]);

  test('Message should be added to the buffer', () {
    buffer.add(message);

    expect(1, buffer.get().length);
  });

  test('Message is expected', () {
    buffer.add(message);

    expect(true, buffer.isLocalChange(message));
  });

  test('Message is unexpected', () {
    Message newMessage = Message.fromBlocks([new Block("hi", 2), new Block("there", 2)]);

    buffer.add(message);

    expect(false, buffer.isLocalChange(newMessage));
  });
}