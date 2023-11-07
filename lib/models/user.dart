class User {
  final String login;
  final String avatarUrl;
  final String? name;

  User(this.login, this.avatarUrl, this.name);

  factory User.fromJson(Map json) {
    return User(
      json['login'],
      json['avatar_url'],
      json['name'],
    );
  }
}
