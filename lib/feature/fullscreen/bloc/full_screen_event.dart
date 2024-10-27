part of 'full_screen_bloc.dart';

@immutable
sealed class FullScreenEvent {}

class DownloadWallpaperEvent extends FullScreenEvent {}

class DownloadButtonClickEvent extends FullScreenEvent {
  final String url;

  DownloadButtonClickEvent({required this.url});
}
