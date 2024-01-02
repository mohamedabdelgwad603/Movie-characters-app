// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:breaking_bad_app/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: const Duration(seconds: 20),
      // receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }
  Future<Map<String, dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print(response.data);
      return response.data;
    } catch (error) {
      print(error.toString());
      return {};
    }
  }

  Future<Map<String, dynamic>> getEpisode() async {
    try {
      Response response = await dio.get('episode/28');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
