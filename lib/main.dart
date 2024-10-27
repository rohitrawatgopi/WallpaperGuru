import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapp/feature/category/bloc/category_bloc.dart';
import 'package:wallpaperapp/feature/fullscreen/bloc/full_screen_bloc.dart';
import 'package:wallpaperapp/feature/home/bloc/home_bloc.dart';
import 'package:wallpaperapp/feature/home/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(),
          ),
          BlocProvider(create: (context) => FullScreenBloc())
        ],
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
  }
}
