import 'package:flutter/material.dart';
import 'package:hangman_game/consts.dart';

Widget HiddenLetter(bool visible,String char){
  return Container(
    width: 50,
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      color: Colors.white,
    ),
    child: Visibility(
        visible: visible,
        child: Text(
          char,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: AppColors.bgColor),
        ),
    ),
  );
}