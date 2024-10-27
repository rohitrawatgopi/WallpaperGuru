// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapp/feature/category/bloc/category_bloc.dart';
import 'package:wallpaperapp/feature/fullscreen/ui/fulllscreen.dart';
import 'package:wallpaperapp/model/category.dart';
import 'package:wallpaperapp/model/photos.dart';
import 'package:wallpaperapp/widget/customappbar.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel cat;

  const CategoryScreen({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<PhotosModel> listPhotos = [];
  CategoryBloc _categoryBloc = CategoryBloc();
  @override
  void initState() {
    getPhotos();
  }

  getPhotos() async {
    _categoryBloc.add(GetPhotosEvent(query: widget.cat.catName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: CustomAppBar(word1: "Wallpaper ", word2: "Guru")),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        bloc: _categoryBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case GetPhotosSuccessCategoryState:
              final getPhotosSuccessCategoryState =
                  state as GetPhotosSuccessCategoryState;

              listPhotos = getPhotosSuccessCategoryState.photosList;
              return Column(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image.network(
                            colorBlendMode: BlendMode.color,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            widget.cat.catImgUrl),
                        Container(
                            height: 120,
                            width: double.infinity,
                            color: Colors.black26),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "CATEGORY",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.cat.catName,
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: listPhotos.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 5,
                                  crossAxisCount: 3,
                                  mainAxisExtent: 200),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                            src: listPhotos[index].url)));
                              },
                              child: Hero(
                                tag: listPhotos[index].url,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(11),
                                  child: Image.network(
                                      fit: BoxFit.cover, listPhotos[index].url),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
