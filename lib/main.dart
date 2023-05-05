import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/cubit_cahnnellist.dart';
import 'package:newsapp/firebase_options.dart';
import 'package:newsapp/Elements/master.dart';
import 'package:newsapp/Cubit/homepagearticles_cubit.dart';

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
