import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/key.dart';
import 'articles_screen.dart';

class CubitArticlesScreen extends Cubit<ArticleScreenState> {
  final String channelId;

  CubitArticlesScreen(this.channelId) : super(ArticleScreenStateLoading()) {
    getArticlesForChannel();
  }

  Future<void> getArticlesForChannel() async {
    try {
      String articlesWeblink =
          "$url/everything?sources=$channelId&apiKey=$apiKey";
      final response = await http.get(Uri.parse(articlesWeblink));
      if (response.statusCode == 200) {
        final articlesJson = json.decode(response.body)['articles'];
        final articlesChannel = articlesJson
            .map<Article>((articleJson) => Article.fromJson(articleJson))
            .toList();
        emit(ArticleScreenStateLoaded(articlesChannel));
      } else {
        emit(ArticleScreenStateError());
      }
    } catch (e) {
      emit(ArticleScreenStateError());
    }
  }
}

class ArticleScreenStateInitial extends ArticleScreenState {}

class ArticleScreenStateLoading extends ArticleScreenState {}

class ArticleScreenStateLoaded extends ArticleScreenState {
  final List<Article> articlesChannel;

  ArticleScreenStateLoaded(this.articlesChannel);

  List<Article> get getChannels => articlesChannel;
}

class ArticleScreenStateError extends ArticleScreenState {}

abstract class ArticleScreenState {}
