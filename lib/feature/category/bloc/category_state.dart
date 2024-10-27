part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class GetPhotosSuccessCategoryState extends CategoryState {
  final List<PhotosModel> photosList;

  GetPhotosSuccessCategoryState({required this.photosList});
}
