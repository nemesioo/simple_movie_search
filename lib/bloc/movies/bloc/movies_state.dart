part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final bool loading;
  final bool empty;
  final bool error;
  final bool loadSearch;
  final bool switchToSearchList;
  final Movies searchMovies;
  final Movies popular;
  final Movies topRated;
  final Movies upcoming;

  MoviesState({
    this.loading,
    this.empty,
    this.error,
    this.loadSearch,
    this.switchToSearchList,
    this.searchMovies,
    this.popular,
    this.topRated,
    this.upcoming,
  });

  factory MoviesState.init() => MoviesState(loading: true);

  MoviesState update({
    bool loading,
    bool empty,
    bool error,
    bool switchToSearchList,
    Movies popular,
    bool loadSearch,
    Movies searchMovies,
    Movies topRated,
    Movies upcoming,
  }) {
    return MoviesState(
      loading: loading ?? false,
      empty: empty ?? false,
      error: error ?? false,
      loadSearch: loadSearch ?? false,
      switchToSearchList: switchToSearchList ?? false,
      popular: popular ?? this.popular,
      searchMovies: searchMovies ?? this.searchMovies,
      topRated: topRated ?? this.topRated,
      upcoming: upcoming ?? this.upcoming,
    );
  }

  @override
  List<Object> get props => [
        loading,
        empty,
        error,
        switchToSearchList,
        popular,
        searchMovies,
        loadSearch,
        topRated,
        upcoming,
      ];
}
