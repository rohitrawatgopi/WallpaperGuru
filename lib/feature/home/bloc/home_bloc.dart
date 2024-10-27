import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaperapp/feature/home/repo/repository.dart';
import 'package:wallpaperapp/model/category.dart';
import 'package:wallpaperapp/model/photos.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetPhotosEvent>(getPhotosEvent);
    on<SearchEvent>(searchEvent);
  }

  FutureOr<void> getPhotosEvent(
      GetPhotosEvent event, Emitter<HomeState> emit) async {
    emit(GetPhotosLoadingState());

    final List<PhotosModel> mainList = await WallpaperRepo.getPhotos();
    final List<CategoryModel> catList = await WallpaperRepo.getCategoriesList();

    if (mainList.isNotEmpty) {
      emit(GetPhotosSuccessState(successList: mainList, categoryLsit: catList));
    } else {
      emit(GetPhotosFailState());
    }
  }

  FutureOr<void> searchEvent(SearchEvent event, Emitter<HomeState> emit) async {
    emit(GetPhotosLoadingState());

    final List<PhotosModel> searchList =
        await WallpaperRepo.searchPhotos(event.search);
    final List<CategoryModel> catList = await WallpaperRepo.getCategoriesList();
    if (searchList.isNotEmpty) {
      emit(GetPhotosSuccessState(
          successList: searchList, categoryLsit: catList));
    } else {
      emit(GetPhotosFailState());
    }
  }
}
