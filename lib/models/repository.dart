class Repository {
  final String name;
  final bool private;
  final String language;
  final String description;
  final String htmlUrl;
  final int stars;
  final int forks;

  Repository(this.name, this.private, this.language, this.description,
      this.htmlUrl, this.stars, this.forks);

  factory Repository.fromJson(Map json) {
    return Repository(
      json['name'] ?? 'None',
      json['private'],
      json['language'] ?? 'Sem linguagem',
      json['description'] ?? 'Sem descrição',
      json['html_url'] ?? '',
      json['stargazers_count'] ?? 0,
      json['forks_count'] ?? 0,
    );
  }
}
