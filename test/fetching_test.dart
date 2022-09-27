import 'package:http/http.dart' as http;

void main() {
  print('Hello, World!');
  var res = fetchPost();

  print(res);
}

Future<http.Response> fetchPost() async {
  var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));

  return response;
}