import 'package:flutter/material.dart';
import 'package:wallpaperapp/model/category.dart';

class CustomCategory extends StatelessWidget {
  final CategoryModel categoryModel;
  const CustomCategory({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
                height: 50,
                width: 100,
                fit: BoxFit.cover,
                categoryModel.catImgUrl),
          ),
          Center(
            child: Text(
              categoryModel.catName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
