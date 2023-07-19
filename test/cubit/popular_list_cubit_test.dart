import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_probe/cubit/popular_list_cubit.dart';
import 'package:media_probe/models/popular_response.dart';
import 'package:media_probe/repositories/network_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/data.dart';

class MockNetworkRepository extends Mock implements NetworkRepository {}

void main() {
  late MockNetworkRepository mockNetworkRepository;
  late PopularListCubit popularListCubit;
  final popularResponse = PopularRespone.fromJson(mockData);

  setUpAll(() => {
        mockNetworkRepository = MockNetworkRepository(),
        popularListCubit = PopularListCubit(mockNetworkRepository),
      });

  group('PopularListCubit', () {
    test(
        'initial state is correct',
        () => {
              expect(popularListCubit.state.status, PopularListStatus.initial),
            });

    test(
        'initial state correct when popular list status is null',
        () => {
              popularListCubit
                  .emit(popularListCubit.state.copyWith(status: null)),
              expect(popularListCubit.state.status, PopularListStatus.initial),
            });

    group('fetch popularList', () {
      blocTest<PopularListCubit, PopularListState>('calls get popular respone',
          build: () {
            when(() => mockNetworkRepository.getPopularRespone())
                .thenAnswer((_) async => popularResponse);
            return popularListCubit;
          },
          act: (cubit) => cubit.fetchPopularList(),
          expect: () => [
                const PopularListState(status: PopularListStatus.loading),
                PopularListState(
                    status: PopularListStatus.loaded,
                    popularList: popularResponse.populars!),
              ]);
    });
  });
}
