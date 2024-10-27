// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState {}

class GetPhotosSuccessState extends HomeState {
  final List<PhotosModel> successList;
  final List<CategoryModel> categoryLsit;

  GetPhotosSuccessState({
    required this.successList,
    required this.categoryLsit,
  });
}

class GetPhotosLoadingState extends HomeState {}

class GetPhotosFailState extends HomeState {}

class SearchSuceessState extends HomeState {
  final List<PhotosModel> searchList;

  SearchSuceessState({required this.searchList});
}
