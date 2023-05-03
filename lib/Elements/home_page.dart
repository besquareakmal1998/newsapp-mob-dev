import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:dots_indicator/dots_indicator.dart';
import 'package:newsapp/Elements/homepagearticles_cubit.dart';
import 'articles_screen.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String getChannelLogoUrl(String sourceName) {
    return 'https://logo.clearbit.com/${sourceName.replaceAll(' ', '').toLowerCase()}.com';
  }

  late final HomePageArticlesCubit homePageArticlesCubit;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // homePageArticlesCubit = context.read<HomePageArticlesCubit>();
    homePageArticlesCubit = BlocProvider.of<HomePageArticlesCubit>(context);
    homePageArticlesCubit.getArticles();
    //_scrollController.addListener(_onScroll);
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     homePageArticlesCubit.getArticles();
    //   }
    // });
    // _scrollController.addListener(_onScroll);
    super.initState();
  }

  // void _onScroll() {
  //   if (_scrollController.position.atEdge &&
  //       _scrollController.position.pixels != 0) {
  //     // if the user has scrolled to the end of the list
  //     homePageArticlesCubit
  //         .loadMoreArticles(articles); // load the next page of articles
  //   }
  // }

  int _currentSlideIndex = 0;
  Set<String> displayedNames = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<HomePageArticlesCubit, HomePageArticlesState>(
            builder: (context, state) {
      Widget widget = const SizedBox();
      if (state is LoadingArticlesState) {
        widget = const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is FailedToLoadArticlesState) {
        widget = const Center(
          child: Text('Failed to load articles'),
        );
      } else if (state is LoadedArticlesState) {
        widget = Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Expanded(
              flex: 2,
              child: CarouselSlider.builder(
                itemCount: state.articles!.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  final articles = state.articles![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailView(article: articles),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(articles.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(1.0),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Text(
                              articles.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentSlideIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            // child: DotsIndicator(
            //   dotsCount: _articles.length,
            //   position: _currentSlideIndex.toDouble(),
            //   decorator: DotsDecorator(
            //     activeColor: Colors.black,
            //     color: Colors.grey,
            //     size: const Size.square(8),
            //     activeSize: const Size(16, 8),
            //     spacing: const EdgeInsets.symmetric(horizontal: 4),
            //     activeShape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //   ),
            // ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 15.0),
            child: Text(
              'News Channels',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 150.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(state.articles!.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticlesScreen(
                            channelId: state.articles![index].sourceName
                                .replaceAll(' ', '-')
                                .toLowerCase(),
                            channelName: state.articles![index].sourceName,
                            description: state.articles![index].description,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80.0,
                            // set the height to a value greater than or equal to 80.0
                            child: ClipOval(
                              child: Image.network(
                                getChannelLogoUrl(
                                    state.articles![index].sourceName),
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.network(
                                    'https://t3.ftcdn.net/jpg/01/79/14/62/360_F_179146215_NEoBhSC2oKw9hwX7K3hAkAPLZueAeGEs.jpg',
                                    height: 80.0,
                                    width: 80.0,
                                  );
                                },
                                height: 80.0,
                                width: 80.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                state.articles![index].sourceName,
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 0.0),
            child: Text(
              'Breaking News',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: state.articles!.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == state.articles!.length) {
                  if (state.articles!.length % 10 == 0) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container();
                  }
                }

                final article = state.articles![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailView(
                          article: article,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            article.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.network(
                                'https://cdn.sanity.io/images/cxgd3urn/production/3241e32fac3321c3bdffacdbe1fabc51852fe343-828x315.jpg?rect=152,0,525,315&w=1200&h=720&q=85&fit=crop&auto=format',
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'By ${article.author}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]);
      }
      return widget;
    }));
  }
}
