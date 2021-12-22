import 'package:http/http.dart';

const String apiUrl = 'https://gutendex.com/books/';

class BookService {
  Future getData(String url) async {
    print('Calling url: $url');
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getBooks(int page) async {
    final bookData = await getData('$apiUrl?page=$page');
    return bookData;
  }
}
