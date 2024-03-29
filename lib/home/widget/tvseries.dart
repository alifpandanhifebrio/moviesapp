import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapp/apikey/apikey.dart';
import 'package:moviesapp/reusable_slider/slider.dart';

class Tvseries extends StatefulWidget {
  const Tvseries({super.key});

  @override
  State<Tvseries> createState() => _TvseriesState();
}

class _TvseriesState extends State<Tvseries> {
  List<Map<String, dynamic>> populartvseries = [];
  List<Map<String, dynamic>> onairtvseries = [];
  List<Map<String, dynamic>> topratedtvseries = [];
  var populartvseriesurl =
      'https://api.themoviedb.org/3/tv/popular?api_key=$apikey';
  var topratedtvseriesurl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=$apikey';
  var onairtvseriesurl =
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apikey';

  Future<void> tvseriesfunction() async {
    var populartvresponse = await http.get(Uri.parse(populartvseriesurl));
    if (populartvresponse.statusCode == 200) {
      var tempdata = jsonDecode(populartvresponse.body);
      var populartvjson = tempdata['results'];
      for (var i = 0; i < populartvjson.length; i++) {
        populartvseries.add({
          "name": populartvjson[i]["name"],
          "poster_path": populartvjson[i]["poster_path"],
          "vote_average": populartvjson[i]["vote_average"],
          "Date": populartvjson[i]["first_air_date"],
          "id": populartvjson[i]["id"],
        });
      }
    } else {
      print(populartvresponse.statusCode);
    }

    var onairtvresponse = await http.get(Uri.parse(onairtvseriesurl));
    if (onairtvresponse.statusCode == 200) {
      var tempdata = jsonDecode(onairtvresponse.body);
      var onairtvjson = tempdata['results'];
      for (var i = 0; i < onairtvjson.length; i++) {
        onairtvseries.add({
          "name": onairtvjson[i]["name"],
          "poster_path": onairtvjson[i]["poster_path"],
          "vote_average": onairtvjson[i]["vote_average"],
          "Date": onairtvjson[i]["first_air_date"],
          "id": onairtvjson[i]["id"],
        });
      }
    } else {
      print(onairtvresponse.statusCode);
    }

    var topratedtvresponse = await http.get(Uri.parse(topratedtvseriesurl));
    if (topratedtvresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedtvresponse.body);
      var topratedtvjson = tempdata['results'];
      for (var i = 0; i < topratedtvjson.length; i++) {
        topratedtvseries.add({
          "name": topratedtvjson[i]["name"],
          "poster_path": topratedtvjson[i]["poster_path"],
          "vote_average": topratedtvjson[i]["vote_average"],
          "Date": topratedtvjson[i]["first_air_date"],
          "id": topratedtvjson[i]["id"],
        });
      }
    } else {
      print(topratedtvresponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tvseriesfunction(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xff12cdd9)),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                sliderList(
                    listname: populartvseries,
                    title: 'Popular Tv Series',
                    type: 'tv',
                    itemcount: 20,
                    titleapi: 'name',
                    date: "Date"),
                sliderList(
                    listname: onairtvseries,
                    title: 'On Air Tv Series',
                    type: 'tv',
                    itemcount: 20,
                    titleapi: 'name',
                    date: "Date"),
                sliderList(
                    listname: topratedtvseries,
                    title: 'Top Rated Tv Series',
                    type: 'tv',
                    itemcount: 20,
                    titleapi: 'name',
                    date: "Date"),
                // sliderList(populartvseries, 'Popular TV Series', 'TV', 20),
                // sliderList(onairtvseries, 'On Air TV Series', 'TV', 20),
                // sliderList(topratedtvseries, 'Top Rated TV Series', 'TV', 20)
              ],
            ),
          );
        }
      }),
    );
  }
}
