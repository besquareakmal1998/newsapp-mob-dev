import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Elements/cubit_cahnnellist.dart';
import 'package:newsapp/Elements/master.dart';
import 'package:newsapp/Elements/homepagearticles_cubit.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter News',
    home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CubitChannelList()),
        BlocProvider<HomePageArticlesCubit>(
          create: (context) => HomePageArticlesCubit(InitialArticlesState()),
        )
      ],
      child: const MyHomePage(),
    ),
  ));
}
