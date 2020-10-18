part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMovies extends MoviesEvent {
  @override
  List<Object> get props => null;
}

class SwitchToHome extends MoviesEvent {
  @override
  List<Object> get props => null;
}

class SearchMovies extends MoviesEvent {
  final String query;
  SearchMovies({this.query});

  @override
  List<Object> get props => [query];
}
