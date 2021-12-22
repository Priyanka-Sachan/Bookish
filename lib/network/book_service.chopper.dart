// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$BookService extends BookService {
  _$BookService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = BookService;

  @override
  Future<Response<Result<APIBookQuery>>> queryBooks(int page) {
    final $url = 'books';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Result<APIBookQuery>, APIBookQuery>($request);
  }
}
