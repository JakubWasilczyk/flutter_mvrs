class Model {
  final bool createdAt;
  final bool updatedAt;
  final List<String> toJsonIgnore;
  final List<String> fromJsonIgnore;
  final Map<String, String> toJsonAdditional;
  //final Map<String, String> fromJsonAdditional;

  const Model({
    this.createdAt = false,
    this.updatedAt = false,
    this.toJsonIgnore = const [],
    this.fromJsonIgnore = const [],
    this.toJsonAdditional = const {},
    //this.fromJsonAdditional = const {},
  });
}

const model = Model();
