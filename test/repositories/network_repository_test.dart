import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:media_probe/core/constants/secrets.dart';
import 'package:media_probe/core/helpers/api_helpers.dart';

import 'package:media_probe/repositories/network_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/data.dart';

class MockApiBaseHelper extends Mock implements ApiBaseHelper {}

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  dio.httpClientAdapter = dioAdapter;

  late MockApiBaseHelper mockApiBaseHelper;
  late NetworkRepository networkRepository;

  setUpAll(() => {
        mockApiBaseHelper = MockApiBaseHelper(),
        networkRepository = NetworkRepository(apiBaseHelper: mockApiBaseHelper),
        when(() => mockApiBaseHelper.get(url: '/7.json', queryParameters: {
              'api-key': apiKey,
            })).thenAnswer((_) async => mockData)
      });

  group('Network Test', () {
    test('getPopularRespone', () async {
      final resp = await networkRepository.getPopularRespone();
      expect(resp.numResults, 1);
    });
  });
}
