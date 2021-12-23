import 'package:bookish/network/book_model.dart';
import 'package:chopper/chopper.dart';

import 'model_converter.dart';
import 'model_response.dart';

part 'book_service.chopper.dart';

const String apiUrl = 'https://gutendex.com';

@ChopperApi()
abstract class BookService extends ChopperService {
  @Get(path: 'books')
  Future<Response<Result<APIBookQuery>>> queryBooks(@Query('page') int page);

  @Get(path: 'books')
  Future<Response<Result<APIBookQuery>>> queryBooksByGenre(
      @Query('page') int page, @Query('topic') String topic);

  static BookService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$BookService(),
      ],
    );
    return _$BookService(client);
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  return req.copyWith(parameters: params);
}
