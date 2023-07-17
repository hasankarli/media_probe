import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_probe/models/popular_response.dart';
import 'package:media_probe/repositories/network_repository.dart';

part 'popular_list_state.dart';

class PopularListCubit extends Cubit<PopularListState> {
  PopularListCubit(this.networkRepository) : super(const PopularListState());

  final NetworkRepository networkRepository;

  var _popularList = <Popular>[];

  Future<void> fetchPopularList() async {
    try {
      emit(state.copyWith(status: PopularListStatus.loading));
      final response = await networkRepository.getPopularRespone();
      _popularList = response.populars ?? [];
      _popularList.sort((a, b) {
        if (a.publishedDate == null || b.publishedDate == null) {
          return 0;
        }
        return b.publishedDate!.compareTo(a.publishedDate!);
      });
      emit(state.copyWith(
        status: PopularListStatus.loaded,
        popularList: _popularList,
      ));
    } catch (e) {
      emit(state.copyWith(status: PopularListStatus.error));
    }
  }
}
