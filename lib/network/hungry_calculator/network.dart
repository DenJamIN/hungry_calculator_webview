
import 'package:http/http.dart' as http;

class Network{
  final String scheme = 'http';
  final String host = 'localhost';
  final int port = 8080;
  String path;

  late Uri url;

  Network({
    required this.path,
  }){
    url = Uri(
        scheme: scheme,
        host: host,
        port: port,
        path: path,
    );
  }

  Future<http.Response> get() {
    return http.get(Uri.parse(url.toString()));
  }

  Future<http.Response> post(String jsonEncode){
    return http.post(
        Uri.parse(url.toString()),
        headers: <String, String>{"Content-Type": "application/json;charset=UTF-8"},
        body: jsonEncode
    );
  }
}