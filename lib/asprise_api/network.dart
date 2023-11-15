import 'package:http/http.dart' as http;

class AspriseAPI {
  final String scheme = 'https';
  final String host = 'ocr.asprise.com';
  final String path = '/api/v1/receipt';
  final Map<String, dynamic> queryParameters = {
    'api_key': 'TEST',
    'recognizer': 'auto',
    'file': '',
    'ref_no': '',
    'mapping_rule_set': ''
  };

  late Uri url;
  late String file;

  AspriseAPI({
    required this.file,
  }){
    queryParameters['file']=file;

    url = Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: queryParameters,
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