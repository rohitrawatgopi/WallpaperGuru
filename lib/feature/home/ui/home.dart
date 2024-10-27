import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapp/feature/category/ui/category.dart';
import 'package:wallpaperapp/feature/fullscreen/ui/fulllscreen.dart';
import 'package:wallpaperapp/feature/home/bloc/home_bloc.dart';
import 'package:wallpaperapp/model/category.dart';
import 'package:wallpaperapp/model/photos.dart';
import 'package:wallpaperapp/widget/customappbar.dart';
import 'package:wallpaperapp/widget/customcategory.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  List<PhotosModel> photosList = [];
  List<CategoryModel> catList = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    get();
  }

  get() async {
    homeBloc.add(GetPhotosEvent());
    //homeBloc.add(GetCategoriesSuccessEvent());
  }

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is GetPhotosFailState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load photos')),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case GetPhotosSuccessState:
            final getPhotosSuccessState = state as GetPhotosSuccessState;
            photosList = getPhotosSuccessState.successList;
            catList = getPhotosSuccessState.categoryLsit;
            return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: CustomAppBar(word1: "Wallpaper ", word2: "Guru")),
              body: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search Wallpaper... ",
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                                onTap: () {
                                  homeBloc.add(SearchEvent(
                                      search: searchController.text));
                                },
                                child: Icon(Icons.search)),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: catList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 3),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryScreen(
                                            cat: catList[index])));
                              },
                              child: CustomCategory(
                                categoryModel: catList[index],
                              ),
                            ),
                          );
                        }),
                  ),
                  photosList.isEmpty
                      ? Text("No data")
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                itemCount: photosList.length,
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
                                                  src: photosList[index].url)));
                                    },
                                    child: Hero(
                                      tag: photosList[index].url,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(11),
                                        child: Image.network(
                                            fit: BoxFit.cover,
                                            photosList[index].url),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                ],
              ),
            );

          case GetPhotosLoadingState:
            {
              print("njdjkfsfgd");
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

          default:
            return Scaffold(
              body: Center(child: Text("Check Internet Connection")),
            );
        }
      },
    );
  }
}
