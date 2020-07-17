import 'dart:convert';

import 'package:collection/collection.dart';

import 'block.dart';

class Message {
  static Function eq = const ListEquality().equals;
  static LineSplitter splitter = const LineSplitter();

  List<Block> blocks;

  Message() {
    this.blocks = new List();
  }

  Message.fromBlocks(List<Block> blocks) {
    this.blocks = blocks;
  }

  Message.copy(Message message) {
    this.blocks = new List();
    for (Block block in message.blocks) {
      blocks.add(Block.copy(block));
    }
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    var list = json['blocks'] as List;

    return Message.fromBlocks(
      list.map((i) => Block.fromJson(i)).toList()
    );
  }

  void clear() {
    this.blocks = new List();
  }

  void fromJson(Map<String, dynamic> json) {
    var list = json['blocks'] as List;

    for (int i=0; i < list.length; i++) {
      if (i<blocks.length) {
        blocks[i].fromJson(list[i]);
      } else {
        blocks.add(Block.fromJson(list[i]));
      }
    }
  }

  bool update(String text) {
    List<String> lines = splitter.convert(text);
    bool updated = false;

    for (int i=0; i<lines.length || i<blocks.length; i++) {
      String line = getLine(lines, i);
      updated = doUpdate(i, line, updated);
    }
    return updated;
  }

  String getLine(List<String> lines, int i) {
    if (i < lines.length) {
      return lines[i];
    } else {
      return '';
    }
  }

  String toText() {
    StringBuffer buffer = new StringBuffer();
    for (Block block in blocks) {
      buffer.write(block.text + "\n");
    }
    return buffer.toString();
  }

  bool doUpdate(int i, String line, bool updated) {
    if (blocks.length > i) {
      Block block = blocks[i];

      if (line != block.text) {
        block.text = line;
        block.version = block.version + 1;
        updated = true;
      }
    } else {
      blocks.add(new Block(line, 1));
      updated = true;
    }
    return updated;
  }

  Map<String, dynamic> toJson() => {
    'blocks': blocks.map((e) => e.toJson()).toList()
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          eq(blocks, other.blocks);

  @override
  int get hashCode => blocks.hashCode;

  @override
  String toString() {
    return 'Message{blocks: $blocks}';
  }
}