import 'package:simple_movie_search/models/response_model.dart';
import 'package:simple_movie_search/repository/service_provider.dart';
import 'package:simple_movie_search/utils/strings.dart';

class MoviesRepository {
  Future<ResponseModel> getMovies({String type}) async {
    final _res = await ServiceProvider().getRequestToNetwork(
      url: "$URL/movie/$type$API_KEY",
    );

    return _res;
  }

  Future<ResponseModel> searchMovies({String query}) async {
    final _res = await ServiceProvider().getRequestToNetwork(
      url: "$URL/search/movie$API_KEY&query=$query",
    );

    return _res;
  }
}
