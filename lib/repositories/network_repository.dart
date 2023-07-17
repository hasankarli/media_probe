import 'package:media_probe/core/helpers/api_helpers.dart';
import 'package:media_probe/models/popular_response.dart';
import 'package:media_probe/core/constants/secrets.dart';

class NetworkRepository {
  final ApiBaseHelper apiBaseHelper;

  NetworkRepository._(this.apiBaseHelper);

  static final NetworkRepository _instance =
      NetworkRepository._(ApiBaseHelper());

  factory NetworkRepository({ApiBaseHelper? apiBaseHelper}) {
    // Return the existing instance if it's already created
    if (apiBaseHelper == null) {
      return _instance;
    }

    // Create a new instance with the provided ApiBaseHelper
    return NetworkRepository._(apiBaseHelper);
  }
  Future<PopularRespone> getPopularRespone() async {
    final response = await apiBaseHelper.get(url: '/7.json', queryParameters: {
      'api-key': apiKey,
    });
    return PopularRespone.fromJson(response);
  }
}
