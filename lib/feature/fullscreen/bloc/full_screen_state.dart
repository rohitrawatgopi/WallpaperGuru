part of 'full_screen_bloc.dart';

@immutable
sealed class FullScreenState {}

final class FullScreenInitial extends FullScreenState {}

abstract class FullScreenActionState extends FullScreenState {}

class SucessfullyDownloadState extends FullScreenActionState {
  final String path;

  SucessfullyDownloadState({required this.path});
}

class UnSuccessfullyDownloadState extends FullScreenActionState {}
