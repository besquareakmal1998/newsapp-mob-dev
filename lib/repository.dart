import 'package:dio/dio.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2/";
  final String apiKey = "7a2036d273524925b937fddb814623c5";

  final Dio _dio = Dio();

  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeaadlinesUrl = "$mainUrl/top-headlines";
  var geteverythingUrl = "$mainUrl/everything";
}
