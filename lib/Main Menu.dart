import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangman_game/App_Cubit.dart';
import 'package:hangman_game/Cache_Helper.dart';
import 'package:hangman_game/Figure_Image.dart';
import 'package:hangman_game/Game_Screen.dart';
import 'package:hangman_game/consts.dart';

class Main_Menu extends StatefulWidget {
  const Main_Menu({Key? key}) : super(key: key);

  @override
  State<Main_Menu> createState() => _Main_MenuState();
}

class _Main_MenuState extends State<Main_Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      elevation: 0.0,
      actions: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              const Text("HighScore",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
              const SizedBox(width: 7,),
              Text("${CacheHelper.GetData(key: "highscore")}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
            ],
          ),
        )
      ],
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
            children: [
              Figure_Image(GameUI.hang, true),
              Figure_Image(GameUI.head, true),
              Figure_Image(GameUI.body, true),
              Figure_Image(GameUI.right_arm, true),
              Figure_Image(GameUI.left_arm, true),
              Figure_Image(GameUI.right_leg, true),
              Figure_Image(GameUI.left_leg, true),
            ],
            ),
            Center(child: Text("HANGMAN",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w800,),)),
            SizedBox(height: 80,),
            Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(7),
                color: Colors.grey.shade700,
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)),
                elevation: 7,
                height: 30,
                onPressed: (){
                  setState(() {
                    LayoutCubit.get(context).getword();
                    selected = [];
                    LayoutCubit.get(context).tries = 0;
                    count = 0;
                    score = 0;
                  });
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Game_Screen()), (route) => false);
                },
                child: Text(
                    "PLAY NOW !",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                )
            ),
          ),
        ),
            SizedBox(height: 50,),
            Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(7),
                color: Colors.grey.shade700,
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                elevation: 7,
                height: 30,
                onPressed: (){
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text(
                    "Quit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                    )
                ),
              ),
            ),
            SizedBox(height: 30,),
            Spacer(),
            Center(child: Text("Made By Abdelrahman Mashaal",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),))
          ],
        ),
      ),
    );
  }
}
