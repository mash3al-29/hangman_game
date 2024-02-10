import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/App_Cubit.dart';
import 'package:hangman_game/Cache_Helper.dart';
import 'package:hangman_game/Figure_Image.dart';
import 'package:hangman_game/Hidden_Letter.dart';
import 'package:hangman_game/Home_States.dart';
import 'package:hangman_game/Main%20Menu.dart';
import 'package:hangman_game/consts.dart';

String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
List<String> selected = [];
int count = 0;
int score = 0;
int xyzzz = 6;
class Game_Screen extends StatefulWidget {
  @override
  State<Game_Screen> createState() {
    return _Game_ScreenState();
  }
}

class _Game_ScreenState extends State<Game_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Hangman"),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                const Text("Score",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),),
                SizedBox(width: 10,),
                Text("$score",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),),

              ],
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<LayoutCubit,Home_States>(
        listener: (context,state){
          if (state is game_over){
            showDialog(context: context, builder: (context){
              return Dialog(
               child: WillPopScope(
                 onWillPop: () async => false,
                 child: Container(
                   width: 200,
                   height: 200,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(7),
                     color: AppColors.bgColor,
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Column(
                       children: [
                         const Center(child: Text("Game Over!",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                         const SizedBox(height: 7,),
                         Center(child: Text("The correct word was ${LayoutCubit.get(context).word_to_guess}",style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                         const SizedBox(height: 25,),
                         Expanded(
                           child: Column(
                             children: [
                               Expanded(
                                 child: Container(
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.black),
                                   height: 40,
                                   child: MaterialButton(
                                     shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(7)),
                                       onPressed: (){
                                         setState(() {
                                           LayoutCubit.get(context).getword();
                                           selected = [];
                                           LayoutCubit.get(context).tries = 0;
                                           count = 0;
                                           score = 0;
                                         });
                                         Navigator.pop(context);
                                       },
                                     height: 20,
                                     textColor: Colors.white,
                                     child: Center(child: Text("Try Again",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                                   ),
                                 ),
                               ),
                               SizedBox(height: 20,),
                               Expanded(
                                 child: Container(
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.black),
                                   height: 40,
                                   child: MaterialButton(
                                     shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(7)),
                                     onPressed: (){
                                       setState(() {
                                         if(score >= CacheHelper.GetData(key: "highscore")){
                                           CacheHelper.PutData(key: "highscore", value: score);
                                         }
                                       });
                                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Main_Menu()), (route) => false);
                                     },
                                     height: 20,
                                     textColor: Colors.white,
                                     child: Center(child: Text("Return To Menu",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
              );
            });
          }else if(state is correct_word){
            showDialog(context: context, builder: (context){
              return WillPopScope(
                onWillPop: () async => false,
                child: Dialog(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.bgColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const Center(child: Text("Nice!",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 7,),
                          Center(child: Text("Your Score is ${score}",style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 25,),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.black),
                                    height: 40,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(7)),
                                      onPressed: (){
                                        setState(() {
                                          LayoutCubit.get(context).getword();
                                          selected = [];
                                          LayoutCubit.get(context).tries = 0;
                                          count = 0;
                                        });
                                        Navigator.pop(context);
                                      },
                                      height: 20,
                                      textColor: Colors.white,
                                      child: const Center(child: Text("Next Level",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.black),
                                    height: 40,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(7)),
                                      onPressed: (){
                                        setState(() {
                                          if(score >= CacheHelper.GetData(key: "highscore")){
                                            CacheHelper.PutData(key: "highscore", value: score);
                                          }
                                        });
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Main_Menu()), (route) => false);
                                      },
                                      height: 20,
                                      textColor: Colors.white,
                                      child: const Center(child: Text("Return To Menu",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          }
        },
        builder: (context,state){
          if(state is !Succsess){
            return const Center(child: CircularProgressIndicator(color: Colors.white,));
          }else{
            return Column(
              children: [
                Expanded(
                  flex:4,
                  child: Column(
                    children: [
                      Expanded(flex: 4,child: Stack(
                        children: [
                          Figure_Image(GameUI.hang, LayoutCubit.get(context).tries>=0),
                          Figure_Image(GameUI.head, LayoutCubit.get(context).tries>=1),
                          Figure_Image(GameUI.body, LayoutCubit.get(context).tries>=2),
                          Figure_Image(GameUI.right_arm, LayoutCubit.get(context).tries>=3),
                          Figure_Image(GameUI.left_arm, LayoutCubit.get(context).tries>=4),
                          Figure_Image(GameUI.right_leg, LayoutCubit.get(context).tries>=5),
                          Figure_Image(GameUI.left_leg, LayoutCubit.get(context).tries>=6),
                        ],

                      ),),
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: LayoutCubit.get(context).word_to_guess.toUpperCase().split("").map((e) {
                          return HiddenLetter(selected.contains(e.toUpperCase()), e);
                        }).toList(),
                      ),
                      ),
                    ],
                  ),
                ) ,
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 7,
                        crossAxisSpacing: 4,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        mainAxisSpacing: 4,
                        children:
                        characters.split("").map((e) {
                          return ElevatedButton(
                            onPressed: selected.contains(e.toUpperCase()) ? null : (){
                              setState(() {
                                selected.add(e.toUpperCase());
                                if(!LayoutCubit.get(context).word_to_guess.toUpperCase().split("").contains(e.toUpperCase())){
                                  LayoutCubit.get(context).tries++;
                                }else{
                                  count++;
                                  print("count is: $count");
                                }
                                var chars = LayoutCubit.get(context).word_to_guess.toUpperCase().split('');
                                var dups = <String, int>{};
                                for (var char in chars) {
                                  dups[char] = (dups[char] ?? 0) + 1;
                                }
                                if(dups.containsValue(2)){
                                  xyzzz = 5;
                                }else if(dups.containsValue(3)){
                                  xyzzz = 4;
                                }else if(dups.containsValue(4)){
                                  xyzzz = 3;
                                }else if(dups.containsValue(5)){
                                  xyzzz = 2;
                                }else if(dups.containsValue(6)){
                                  xyzzz = 1;
                                }
                                LayoutCubit.get(context).checktries();
                                print(xyzzz);
                                if(count == xyzzz && LayoutCubit.get(context).tries <= 6){
                                  print("shitman killed me");
                                  score = score + 10;
                                  LayoutCubit.get(context).toggle();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black54,
                            ),
                            child: Text(e,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                          );
                        }).toList(),
                      )
                  ),
                ),
              ],
            );
          }
    }),
    );}
}
