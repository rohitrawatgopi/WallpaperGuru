part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class GetPhotosEvent extends CategoryEvent {
  final String query;

  GetPhotosEvent({required this.query});
}
