class Model {
  final bool createdAt;
  final bool updatedAt;
  final List<String> jsonIgnore;

  const Model({
    this.createdAt = false,
    this.updatedAt = false,
    this.jsonIgnore = const [],
  });
}

const model = Model();
