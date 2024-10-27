import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:wallpaperapp/feature/fullscreen/bloc/full_screen_bloc.dart';

// var file = await DefaultCacheManager().getSingleFile(url);
class FullScreen extends StatelessWidget {
  String src;
  FullScreen({super.key, required this.src});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FullScreenBloc fullScreenBloc = FullScreenBloc();

  /// main download wallpaper handling with the help of path provider package

  Future<void> saveImageLocally(Uint8List imageData) async {}

  // downloadImage(String imageUrl, context) async {
  //   try {
  //     String devicePathToSaveImage = "";
  //     var time = DateTime.now().microsecondsSinceEpoch;
  //     if (Platform.isAndroid) {
  //       devicePathToSaveImage = "/storage/emulated/0/Download/image-$time.jpg";
  //     } else {
  //       var downloadDirectoryPath = await getApplicationDocumentsDirectory();
  //       devicePathToSaveImage = "${downloadDirectoryPath.path}/image-$time.jpg";
  //     }
  //
  //     File file = File(devicePathToSaveImage);
  //     print('File path: $devicePathToSaveImage');
  //     // Make the HTTP GET request
  //     var res = await get(Uri.parse(imageUrl));
  //     if (res.statusCode == 200) {
  //       // Save the image
  //       await file.writeAsBytes(res.bodyBytes);
  //       await ImageGallerySaver.saveFile(devicePathToSaveImage);
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Yay! Downloading Completed'),
  //       ));
  //     }
  //   } catch (error) {
  //     print("Error: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FullScreenBloc, FullScreenState>(
      bloc: fullScreenBloc,
      listenWhen: (previous, current) => current is FullScreenActionState,
      buildWhen: (previous, current) => current is! FullScreenActionState,
      listener: (context, state) {
        if (state is SucessfullyDownloadState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Image downloaded and saved locally!'),
              action: SnackBarAction(
                  label: 'Open',
                  onPressed: () {
                    OpenFile.open(state.path);
                  })));
        } else if (state is UnSuccessfullyDownloadState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to download image.'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('An error occurred while downloading.'),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          floatingActionButton: ElevatedButton(
              onPressed: () async {
                fullScreenBloc.add(DownloadButtonClickEvent(url: src));
              },
              child: Text("Download Wallpaper")),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(src), fit: BoxFit.cover)),
          ),
        );
      },
    );
  }
}
