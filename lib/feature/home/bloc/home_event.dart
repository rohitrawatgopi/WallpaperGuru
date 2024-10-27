part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetPhotosEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  final String search;

  SearchEvent({required this.search});
}
