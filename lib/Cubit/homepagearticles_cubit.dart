import 'package:bloc/bloc.dart';
import 'package:newsapp/data/articles_get_req.dart';
import '../Declaration/article.dart';

class HomePageArticlesCubit extends Cubit<HomePageArticlesState> {
  final ArticlesGetReq getReq = ArticlesGetReq();
  int page = 1;
  bool loading = false;

  HomePageArticlesCubit(super.initialState);

  void getArticles() async {
    List<Article> articles = [];

    emit(LoadingArticlesState());
    articles = (await getReq.getArticles(page) ?? []).cast<Article>();
    if (articles.isEmpty) {
      emit(FailedToLoadArticlesState());
    } else {
      page++;
      emit(LoadedArticlesState(articles: articles, hasReachedMax: false));
    }
  }

  void loadMoreArticles(List<Article> currentArticles) async {
    if (loading) return;
    loading = true;

    List<Article> oldArticles = [];

    if (state is LoadedArticlesState) {
      oldArticles.addAll((state as LoadedArticlesState).articles ?? []);
    }
    List<Article> newArticles = [];

    newArticles = (await getReq.getArticles(page) ?? []).cast<Article>();
    if (newArticles.isEmpty) {
      emit(LoadedArticlesState(articles: currentArticles, hasReachedMax: true));
    } else {
      page++;
      final List<Article> updatedArticles = List.from(currentArticles)
        ..addAll(oldArticles.isNotEmpty ? oldArticles : [])
        ..addAll(newArticles);
      emit(
          LoadedArticlesState(articles: updatedArticles, hasReachedMax: false));
    }

    loading = false;
  }
}

abstract class HomePageArticlesState {}

class InitialArticlesState extends HomePageArticlesState {}

class LoadingArticlesState extends HomePageArticlesState {}

class LoadedArticlesState extends HomePageArticlesState {
  List<Article>? articles;
  bool? hasReachedMax;

  LoadedArticlesState({required this.articles, required this.hasReachedMax});
}

class FailedToLoadArticlesState extends HomePageArticlesState {}

// class HomePageArticlesBloc
//     extends Bloc<HomePageArticlesEvent, HomePageArticlesState> {
//   late final _dataService = HomePageState();
//
//   HomePageArticlesBloc() : super(LoadingArticlesState()) {
//     on((event, emit) async {
//       try {
//         if (event is LoadArticlesEvent) {
//           final data = await _dataService.getArticles(event.page);
//
//           print('COMING HERE 2');
//
//           emit(LoadedArticlesState(articles: data));
//         }
//       } on Error catch (e) {
//         emit(FailedToLoadArticlesState());
//       }
//     });
//   }
// }
