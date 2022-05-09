class Model {
  final bool createdAt;
  final bool updatedAt;
  final List<String> fromJsonIgnore;
  final List<String> toJsonIgnore;

  const Model({
    this.createdAt = false,
    this.updatedAt = false,
    this.fromJsonIgnore = const [],
    this.toJsonIgnore = const [],
  });
}

const model = Model();
