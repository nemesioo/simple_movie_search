import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_movie_search/models/movies_model.dart';
import 'package:simple_movie_search/utils/strings.dart';

class MovieInfo extends StatefulWidget {
  final Result movie;

  MovieInfo({this.movie});
  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "${widget.movie.title}",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.black,
        ),
      ),
      body: _movieInfo(),
    );
  }

  Widget _movieInfo() {
    String _releaseDate;
    _releaseDate = widget.movie.releaseDate != null
        ? DateFormat("MMM dd, yyyy").format(widget.movie.releaseDate)
        : "";

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: widget.movie.posterPath != null
                        ? Image.network(
                            "$IMAGE_BASE_URL${widget.movie.posterPath}")
                        : Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 100,
                          ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.movie.title}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Release Date: $_releaseDate",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "${widget.movie.overview != "" ? widget.movie.overview : EMPTY_OVERVIEW}",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
