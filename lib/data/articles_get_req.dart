import 'package:newsapp/Elements/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticlesGetReq {
  Future<List<Article>?> getArticles(int page) async {
    List<Article> articles = [];
    const String apikey = '1cab568c1f2e4000861b3346517590bd';
    https: //newsapi.org/v2/top-headlines?language=en&apiKey=$e9041acfdfd94aef9a4713586aec923f
    String apiUrl =
        'https://newsapi.org/v2/top-headlines?language=en&apiKey=$apikey';
    try {
      final response =
          await http.get(Uri.parse('$apiUrl&page=$page&pageSize=10'));
      final jsonData = json.decode(response.body)['articles'] as List;
      final newArticles =
          jsonData.map((article) => Article.fromJson(article)).toList();

      if (page == 1) {
        articles = newArticles;
      } else {
        articles.addAll(newArticles);
      }
      print('articles : ${articles.toString()}');
    } catch (e) {
      print(e.toString());
    }
    return articles;
  }
}
