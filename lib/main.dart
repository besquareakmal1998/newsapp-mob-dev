import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Elements/cubit_cahnnellist.dart';
import 'package:newsapp/firebase_options.dart';
import 'Elements/cubit_articles_screen.dart';
import 'package:newsapp/Elements/master.dart';
import 'package:newsapp/Elements/homepagearticles_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
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
