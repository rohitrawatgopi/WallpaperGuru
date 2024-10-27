import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaperapp/feature/home/repo/repository.dart';
import 'package:wallpaperapp/model/photos.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetPhotosEvent>(getPhotosEvent);
  }

  FutureOr<void> getPhotosEvent(
      GetPhotosEvent event, Emitter<CategoryState> emit) async {
    List<PhotosModel> photosList =
        await WallpaperRepo.searchPhotos(event.query);
    emit(GetPhotosSuccessCategoryState(photosList: photosList));
  }
}
