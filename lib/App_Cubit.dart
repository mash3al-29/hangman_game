import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/Game_Screen.dart';
import 'package:hangman_game/Home_States.dart';
import 'package:hangman_game/dio_helper.dart';


class LayoutCubit extends Cubit<Home_States> {

  LayoutCubit() : super(Initial_State());

  static LayoutCubit get(context) => BlocProvider.of(context);

  late String word_to_guess = "";
  bool game_overr = true;
/*  int count = 0;
  bool game_overr = true;*/
  int tries = 0;

   void getword(){
    DioHelper.GetData(url: "word?length=6").then((value) {
      word_to_guess = (value!.data[0]).toString();
      print(word_to_guess);
      emit(betweensucsess());
      emit(Succsess());
    }).catchError((error){
      print(error.toString());
      emit(Error());
    });
  }


  bool checktries(){
     if (tries == 6 && count < 6){
       print("khalas game over");
       emit(game_over());
       return true;
     }else{
       return false;
     }
  }

  void toggle(){
    bool game_overr = false;
    emit(correct_word());
  }
/*  void checkingword(){
    word_to_guess.toUpperCase().split("pattern").forEach((element) {
      if (selected.contains(element) == true){
        count++;
      }
    });
    if(count == 6 && tries <= 6){
      game_overr = false;
    }
  }*/

}