class Repository {
  final String name;
  final String private;

  Repository(this.name, this.private);

  factory Repository.fromJson(Map json) {
    return Repository(
      json['login'],
      json['avatar_url'],
    );
  }
}
