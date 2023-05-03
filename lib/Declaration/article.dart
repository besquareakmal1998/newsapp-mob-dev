class Article {
  final String title;
  final String description;
  final String link;
  final String urlToImage;
  final String publishedAt;
  final String author;
  String imageUrl;
  String sourceName;

  Article(
      {required this.title,
      required this.description,
      required this.link,
      required this.urlToImage,
      required this.publishedAt,
      required this.author,
      required this.imageUrl,
    required this.sourceName,});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      link: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      author: json['author'] ?? "Unknown Author",
      imageUrl: json['urlToImage'] ?? '',
      sourceName: json['source']['name'] ?? 'Unknown',
      // channelId: json['source']['id'] ?? "",
    );
  }
}