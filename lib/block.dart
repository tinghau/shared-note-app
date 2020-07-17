class Block {
  String text;
  int version;

  Block(this.text, this.version);

  Block.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        version = json['version'];

  Block.copy(Block block)
      : text = block.text,
        version = block.version;

  Map<String, dynamic> toJson() => {
    'text': text,
    'version': version,
  };

  void fromJson(Map<String, dynamic> json) {
    text = json['text'];
    version = json['version'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Block &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          version == other.version;

  @override
  int get hashCode => text.hashCode ^ version.hashCode;

  @override
  String toString() {
    return 'Block{text: $text, version: $version}';
  }
}