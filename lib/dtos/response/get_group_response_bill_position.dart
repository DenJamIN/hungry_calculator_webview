import 'get_group_response_bill_position_payer.dart';

class GetGroupResponseBillPosition {
  String title;
  int price;
  List<GetGroupResponseBillPositionPayer> payers;

  GetGroupResponseBillPosition({
    required this.title,
    required this.price,
    required this.payers,
  });

  factory GetGroupResponseBillPosition.fromJson(Map<String, dynamic> json) =>
      GetGroupResponseBillPosition(
        title: json['title'],
        price: json['price'],
        payers: (json['payers'] as List<Map<String, dynamic>>)
            .map((payerJson) =>
                GetGroupResponseBillPositionPayer.fromJson(payerJson))
            .toList(),
      );
}
