import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_dairy/shared/my_bloc_observer.dart';
import 'cubit/app_cubit.dart';
import 'layout/start-page/start_page.dart';

void main() {
  Bloc.observer=MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..CreateDataBase()..IconAppChange(x: false),
      child: MaterialApp(
        theme: ThemeData(
          //useMaterial3: true
        ),
        debugShowCheckedModeBanner: false,
        home: StartPage(),
      ),
    );
  }
}