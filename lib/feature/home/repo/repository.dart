import 'dart:math';

import 'package:dio/dio.dart';
import 'package:wallpaperapp/model/category.dart';
import 'package:wallpaperapp/model/photos.dart';

class WallpaperRepo {
  static List<CategoryModel> categoryModelList = [];
  static const String _apiKey =
      "6bbLCV8D62JK3etnaF8yR6LERs2BKoq8ol5TYPtnba6ubQw02tKgnanf";

  static Future<List<PhotosModel>> getPhotos() async {
    Dio dio = Dio();
    List<PhotosModel> mainList = [];
    try {
      final res = await dio.get(
        "https://api.pexels.com/v1/curated",
        options: Options(
          headers: {"Authorization": _apiKey},
        ),
      );

      Map<String, dynamic> jsonData = res.data;
      List photosList = jsonData["photos"];

      for (var e in photosList) {
        mainList.add(PhotosModel.fromMap(e));
      }

      return mainList;
    } catch (e) {
      print('Error fetching curated photos: $e');
      return mainList;
    }
  }

  static Future<List<PhotosModel>> searchPhotos(String query) async {
    Dio dio = Dio();
    List<PhotosModel> mainList = [];
    try {
      final res = await dio.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1",
        options: Options(headers: {"Authorization": _apiKey}),
      );

      Map<String, dynamic> jsonData = res.data;
      List photosList = jsonData["photos"];

      for (var e in photosList) {
        mainList.add(PhotosModel.fromMap(e));
      }

      return mainList;
    } catch (e) {
      print('Error searching photos: $e');
      return mainList;
    }
  }

  static Future<List<CategoryModel>> getCategoriesList() async {
    try {
      List<String> categoryNames = [
        "Cars",
        "Nature",
        "Bikes",
        "Street",
        "City",
        "Flowers"
      ];

      for (String catName in categoryNames) {
        List<PhotosModel> photos = await searchPhotos(catName);
        if (photos.isNotEmpty) {
          final _random = Random();
          PhotosModel photoModel = photos[_random.nextInt(photos.length)];

          categoryModelList.add(
            CategoryModel(catImgUrl: photoModel.url, catName: catName),
          );
        }
      }

      print(categoryModelList);
      return categoryModelList;
    } catch (e) {
      print('Error fetching categories: $e');
      return categoryModelList;
    }
  }
}
