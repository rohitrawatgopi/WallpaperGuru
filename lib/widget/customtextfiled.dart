// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapp/feature/home/bloc/home_bloc.dart';

class CustomSearch extends StatelessWidget {
  final TextEditingController search;
  const CustomSearch({
    Key? key,
    required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade400),
      child: TextField(
        controller: search,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Search Wallpaper... ",
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          suffixIcon: InkWell(
              onTap: () {
                BlocProvider.of<HomeBloc>(context)
                    .add(SearchEvent(search: search.text));
              },
              child: Icon(Icons.search)),
        ),
      ),
    );
  }
}
