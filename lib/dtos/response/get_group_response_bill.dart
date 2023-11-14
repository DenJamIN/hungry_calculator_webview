import 'dart:convert';

import 'get_group_response_bill_position.dart';

class GetGroupResponseBill {
  List<GetGroupResponseBillPosition> positions;

  GetGroupResponseBill({required this.positions});

  factory GetGroupResponseBill.fromJson(json) => GetGroupResponseBill(
        positions: (jsonDecode(json['positions']) as List<Map<String, dynamic>>)
            .map((positionJson) =>
                GetGroupResponseBillPosition.fromJson(json['position']))
            .toList(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetGroupResponseBill &&
          runtimeType == other.runtimeType &&
          positions == other.positions;

  @override
  int get hashCode => positions.hashCode;
}
