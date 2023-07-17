import 'package:flutter_test/flutter_test.dart';
import 'package:media_probe/core/helpers/api_helpers.dart';
import 'package:media_probe/cubit/popular_list_cubit.dart';
import 'package:media_probe/repositories/network_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockApiBaseHelper extends Mock implements ApiBaseHelper {}

void main() {
  late MockApiBaseHelper mockApiBaseHelper;
  late NetworkRepository networkRepository;
  late PopularListCubit popularListCubit;

  setUpAll(() => {
        mockApiBaseHelper = MockApiBaseHelper(),
        networkRepository = NetworkRepository(apiBaseHelper: mockApiBaseHelper),
        popularListCubit = PopularListCubit(networkRepository),
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

    // group('fetch popularList', () {
    //   blocTest<PopularListCubit, PopularListState>('calls get popular respone',
    //       build: () {
    //         when(() => networkRepository.getPopularRespone()).thenAnswer(
    //             (_) async => PopularRespone.fromJson(Map.from(mockData)));
    //         return popularListCubit;
    //       },
    //       act: (cubit) => cubit.fetchPopularList(),
    //       expect: () => [
    //             const PopularListState(status: PopularListStatus.loading),
    //             const PopularListState(
    //                 status: PopularListStatus.loaded, popularList: []),
    //           ]);
    // });
  });
}
