import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'http://192.168.0.100:5000')
abstract class RhymerApiClient {
  factory RhymerApiClient(Dio dio, {String baseUrl}) = _RhymerApiClient;

  factory RhymerApiClient.create({String? apiUrl}) {
    // final apiUrl = dotenv.env['API_URL'] ?? 'http://192.168.0.100:5000';
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));

    if (apiUrl != null) {
      return RhymerApiClient(dio, baseUrl: apiUrl);
    }
    return RhymerApiClient(dio);
  }

// POST запрос для получения списка рифм
  @POST('/api/rhyme')
  Future<List<String>> getRhymesList(@Body() Map<String, dynamic> word);
}
