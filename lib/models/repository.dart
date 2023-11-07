class Repository {
  final String name;
  final bool private;
  final String? language;

  Repository(this.name, this.private, this.language);

  factory Repository.fromJson(Map json) {
    return Repository(
      json['name'],
      json['private'],
      json['language'],
    );
  }
}
