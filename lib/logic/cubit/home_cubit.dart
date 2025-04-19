import 'package:bilheteria_panucci/models/movie.dart';
import 'package:bilheteria_panucci/services/movies_api.dart';
import 'package:bloc/bloc.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  final HomeService homeService = HomeService();

  Future<void> getMovies() async {
    emit(HomeLoading());
    try {
      final movies = await homeService.fetchMovies();

      movies.length > 0 ? emit(HomeSuccess(movies)) : emit(HomeNoDataFound());

    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> findMovies(String genre) async {
    emit(HomeLoading());
    try{
      final movies = await homeService.fetchMoviesByGenre(genre);
      movies.length > 0 ? emit(HomeSuccess(movies)) : emit(HomeNoDataFound());
    }catch(e){
      emit(HomeError(e.toString()));
    }
  }



}
