import 'dart:convert';

import 'package:hungry_calculator/dtos/dtos.dart';

import '../models/hungry_calculator/models.dart';
import 'network.dart';

class BillHttp {
  final String path = 'bills';

  Future<Group> save(Group groupWithBill) async {
    final response =
        await Network(path: path).post(jsonEncode(CreateBillRequest(
      groupId: groupWithBill.id!,
      positions: groupWithBill.bill!
          .map((position) => CreateBillRequestPosition(
                title: position.title,
                price: position.price,
                parts: position.parts,
                payers: position.personalParts.entries
                    .map((payerToPriceAndParts) =>
                        CreateBillRequestPositionPayer(
                          id: payerToPriceAndParts.key.id!,
                          personalPrice: payerToPriceAndParts.value.item1,
                          personalParts: payerToPriceAndParts.value.item2,
                        ))
                    .toList(),
              ))
          .toList(),
    )));
    final decodedResponse =
        CreateBillResponse.fromJson(jsonDecode(response.body));

    final responsePositions = decodedResponse.positions.toSet();
    for (var position in groupWithBill.bill!) {
      final positionInResponse =
          responsePositions.firstWhere((p) => p.title == position.title);
      responsePositions.remove(positionInResponse);

      position.id = positionInResponse.id;
    }

    return groupWithBill;
  }
}
