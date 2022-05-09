class Model {
  final bool createdAt;
  final bool updatedAt;
  final List<String> toJsonIgnore;
  final List<String> fromJsonIgnore;
  final Map<String, String> defaultValues;

  const Model({
    this.createdAt = false,
    this.updatedAt = false,
    this.toJsonIgnore = const [],
    this.fromJsonIgnore = const [],
    this.defaultValues = const {},
  });
}

const model = Model();
