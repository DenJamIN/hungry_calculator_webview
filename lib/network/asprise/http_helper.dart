import 'dart:convert';

import 'package:http/http.dart' hide Client;
import '../../models/asprise/models.dart';
import 'network.dart';

abstract class HttpHelper<T> {
  Future<List<T>> get();

  Future<Response> post(T item);
}

class ReceiptHttp extends HttpHelper<Receipt> {
  @override
  Future<Receipt> get() async {
    final response = await AspriseAPI().get();
    return _convertJson(response);
  }

  @override
  Future<Response> post(Receipt item) async {
    final response = await AspriseAPI().post();
    return response;
  }

  List<Receipt> _convertJsonArray(Response response) {
    final jsonData = jsonDecode(response.body);
    return jsonData
        .map<Receipt>((i) => Receipt.fromJson(i))
        .toList();
  }
}