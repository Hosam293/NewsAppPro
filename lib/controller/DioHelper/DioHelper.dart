import 'package:dio/dio.dart';

class DioHelper
{
 static late Dio dio;
//https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=0414a5df728d45c6a28732845daa8f20
  static init()
  {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://newsapi.org/',
          receiveDataWhenStatusError: true
        )

    );
  }

 static Future<Response> getData(
      {required String url, required Map<String, dynamic> query})
  async {
  return await  dio.get(url,queryParameters: query

    );
  }

}