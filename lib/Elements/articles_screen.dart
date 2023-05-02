import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/key.dart';

class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
    );
  }
}

class ArticlesScreen extends StatelessWidget {
  final String channelId;
  final String channelName;
  final String description;
  const ArticlesScreen({
    Key? key,
    required this.channelId,
    required this.channelName,
    required this.description,
  }) : super(key: key);

  Future<List<Article>> getArticlesForChannel() async {
    String articlesWeblink =
        "$url/everything?sources=$channelId&apiKey=$apiKey";
    final response = await http.get(Uri.parse(articlesWeblink));
    if (response.statusCode == 200) {
      final articlesJson = json.decode(response.body)['articles'];
      return articlesJson
          .map<Article>((articleJson) => Article.fromJson(articleJson))
          .toList();
    } else {
      throw Exception('Failed to load news articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter News - $channelName'),
      ),
      body: FutureBuilder<List<Article>>(
        future: getArticlesForChannel(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            final articles = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                              NetworkImage(getChannelImageUrl(channelId)),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          channelName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: articles[index].urlToImage != null
                            ? SizedBox(
                                width: 150,
                                height: 130,
                                child: Image.network(
                                  articles[index].urlToImage,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.article),
                        title: Text(
                          articles[index].title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              articles[index].publishedAt.substring(0, 10),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              articles[index].publishedAt.substring(11, 16),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        onTap: () {
                          // TODO: Implement article detail screen
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

String getChannelImageUrl(String channelId) {
  return 'https://logo.clearbit.com/${channelId.replaceAll(' ', '').toLowerCase()}.com';
}
