import 'package:flutter_test/flutter_test.dart';
import 'package:hungry_calculator/hungry_calculator_api/http_helper.dart';
import 'package:hungry_calculator/models/hungry_calculator/models.dart';
import 'package:tuple/tuple.dart';

void main() {
  GroupParticipant nastya = GroupParticipant(name: 'Nastya');
  GroupParticipant anna = GroupParticipant(name: 'Anna');
  GroupParticipant ian = GroupParticipant(name: 'Ian');
  GroupParticipant vasya = GroupParticipant(name: 'Vasya');
  Group group = Group(
    title: 'Pizza Day',
    creator: nastya,
    requisites: '+1 (984) 123-8234',
    participants: List.of({anna, ian, vasya}),
  );

  test('Save group', () async {
    await GroupParticipantHttp().save(nastya);
    await GroupHttp().save(group);

    group.bill = List.of({
      BillPosition(
          title: 'Margherita',
          price: 299,
          parts: 3,
          personalParts: Map.fromEntries({
            MapEntry(nastya, Tuple2(199, 2)),
            MapEntry(ian, Tuple2(100, 1)),
          })),
      BillPosition(
        title: 'Quattro Formaggi',
        price: 499,
        parts: 1,
        personalParts: Map.fromEntries({MapEntry(anna, Tuple2(499, 1))}),
      ),
      BillPosition(
        title: 'Vitello Tonnato',
        price: 199,
        parts: 2,
        personalParts: Map.fromEntries({
          MapEntry(nastya, Tuple2(100, 1)),
          MapEntry(vasya, Tuple2(99, 1)),
        }),
      ),
    });
    await BillHttp().save(group);

    expect(
        group.bill!.map((position) => position.id).toSet().length, equals(3));
  });
}
