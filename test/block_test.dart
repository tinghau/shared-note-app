import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/block.dart';

void main() {
  Block block = new Block("hello", 1);
  Map<String, dynamic> map = {'text':'hello', 'version':1};

  test('Block should be created by fromJson() constructor', () {
    expect(Block.fromJson(map), block);
  });

  test('Block should be a copy', () {
    expect(Block.copy(block), block);
  });

  test('Json should be created by toJson()', () {
    expect(block.toJson(), map);
  });

  test('Block should be created by fromJson() constructor', () {
    Map<String, dynamic> newMap = {'text':'hi', 'version':2};
    Block actual = Block.fromJson(map);
    actual.fromJson(newMap);

    expect(actual, Block('hi', 2));
  });
}