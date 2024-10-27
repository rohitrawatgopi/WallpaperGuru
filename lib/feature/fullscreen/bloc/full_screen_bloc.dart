import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wallpaperapp/feature/fullscreen/repo/fullrepo.dart';

part 'full_screen_event.dart';
part 'full_screen_state.dart';

class FullScreenBloc extends Bloc<FullScreenEvent, FullScreenState> {
  FullScreenBloc() : super(FullScreenInitial()) {
    on<DownloadButtonClickEvent>(downloadButtonClickEvent);
  }

  FutureOr<void> downloadButtonClickEvent(
      DownloadButtonClickEvent event, Emitter<FullScreenState> emit) async {
    final response = await FullScreenRepo.downloadAndSaveImage(event.url);
    if (response.isNotEmpty) {
      print("response$response");

      emit(SucessfullyDownloadState(path: response));
    } else {
      emit(UnSuccessfullyDownloadState());
    }
  }
}
