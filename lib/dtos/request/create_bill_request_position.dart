import 'dart:convert';

import 'create_bill_request_position_payer.dart';

class CreateBillRequestPosition {
  String title;
  int price;
  List<CreateBillRequestPositionPayer> payers;

  CreateBillRequestPosition({
    required this.title,
    required this.price,
    required this.payers,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'price': price,
    'payers': jsonEncode(payers.map((payer) => payer.toJson())),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateBillRequestPosition &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          price == other.price &&
          payers == other.payers;

  @override
  int get hashCode => title.hashCode ^ price.hashCode ^ payers.hashCode;
}
