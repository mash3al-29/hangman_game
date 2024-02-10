import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hangman_game/consts.dart';

class DioHelper{
  static Dio? dio;
  static init()
  {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://random-word-api.herokuapp.com/',
          receiveDataWhenStatusError: true,
        )
    );
  }

  static Future<Response?> GetData ({
     required String url,
  })async {
    return await dio?.get
      (
      url,
    );
  }
}