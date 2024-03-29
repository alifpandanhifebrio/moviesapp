import 'package:flutter/material.dart';
import 'package:moviesapp/details/movies_detail.dart';
import 'package:moviesapp/details/tvseries_detail.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;
  descriptioncheckui({super.key, this.newid, this.newtype});

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    if (widget.newtype == 'movie') {
      return MoviesDetails(widget.newid);
    } else if (widget.newid == 'tv') {
      return TVSeriesDetails(widget.newid);
    } else {
      Errorui();
    }
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget Errorui() {
  return const Scaffold(
    body: Center(
      child: Text('Error'),
    ),
  );
}
