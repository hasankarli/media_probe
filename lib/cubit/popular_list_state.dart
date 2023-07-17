part of 'popular_list_cubit.dart';

enum PopularListStatus { initial, loading, loaded, error }

class PopularListState extends Equatable {
  const PopularListState({
    this.status = PopularListStatus.initial,
    this.popularList = const <Popular>[],
  });

  final PopularListStatus status;
  final List<Popular> popularList;

  @override
  List<Object> get props => [
        status,
        popularList,
      ];

  PopularListState copyWith({
    PopularListStatus? status,
    List<Popular>? popularList,
  }) {
    return PopularListState(
      status: status ?? this.status,
      popularList: popularList ?? this.popularList,
    );
  }
}
