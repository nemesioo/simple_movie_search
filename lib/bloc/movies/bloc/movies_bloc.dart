import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_movie_search/models/movies_model.dart';
import 'package:simple_movie_search/models/response_model.dart';
import 'package:simple_movie_search/repository/movies_repository.dart';
import 'package:simple_movie_search/utils/misc.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesRepository _moviesRepository = MoviesRepository();

  MoviesBloc() : super(MoviesState.init());

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if (event is GetMovies) {
      yield* _mapGetMoviesToState();
    }
    if (event is SearchMovies) {
      yield* _mapSearchMoviesToState(event.query);
    }
    if (event is SwitchToHome) {
      yield* _mapSwitchToHomeToState();
    }
  }

  Stream<MoviesState> _mapSwitchToHomeToState() async* {
    yield state.update(switchToSearchList: false);
  }

  Stream<MoviesState> _mapGetMoviesToState() async* {
    yield state.update(loading: true);

    try {
      ResponseModel _res;
      Movies _popular;
      Movies _topRated;
      Movies _upcoming;

      _res = await _moviesRepository.getMovies(type: "popular");
      _popular = moviesFromJson(_res.response);
      _res = await _moviesRepository.getMovies(type: "top_rated");
      _topRated = moviesFromJson(_res.response);
      _res = await _moviesRepository.getMovies(type: "upcoming");
      _upcoming = moviesFromJson(_res.response);

      yield state.update(
        popular: _popular,
        topRated: _topRated,
        upcoming: _upcoming,
      );
    } catch (_) {
      Misc.debugP(tag: this, message: _);
      yield state.update(error: true);
    }
  }

  Stream<MoviesState> _mapSearchMoviesToState(String query) async* {
    yield state.update(loadSearch: true);

    try {
      ResponseModel _res;
      Movies _searchMovies;

      _res = await _moviesRepository.searchMovies(
          query: query.replaceAll(RegExp('\\s+'), "%20"));
      _searchMovies = moviesFromJson(_res.response);

      yield state.update(
        searchMovies: _searchMovies,
        switchToSearchList: true,
      );
    } catch (_) {
      Misc.debugP(tag: this, message: _);
      yield state.update(error: true);
    }
  }
}
