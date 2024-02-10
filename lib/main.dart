import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/App_Cubit.dart';
import 'package:hangman_game/Cache_Helper.dart';
import 'package:hangman_game/Game_Screen.dart';
import 'package:hangman_game/Main%20Menu.dart';
import 'package:hangman_game/dio_helper.dart';
import 'Bloc_Observer.dart';
import 'dio_helper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  if (CacheHelper.GetData(key: "highscore") == null){
    CacheHelper.PutData(key: "highscore", value: 0);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => LayoutCubit(),
      child: MaterialApp(
        title: 'Hangman Game',
        theme: ThemeData.dark(),
        home: Main_Menu(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
