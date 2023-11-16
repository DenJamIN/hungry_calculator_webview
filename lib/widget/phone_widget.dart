import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:collection/collection.dart';
import 'package:tuple/tuple.dart';

import '../hungry_calculator_api/bill_http.dart';
import '../hungry_calculator_api/group_http.dart';
import '../hungry_calculator_api/group_participant_http.dart';
import '../models/hungry_calculator/models.dart';

class PhoneWidget extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final Map<String, List<Map<String, dynamic>>> receipts;

  const PhoneWidget({super.key, required this.receipts, required this.items});

  @override
  State<StatefulWidget> createState() => _PhoneWidget();
}

class _PhoneWidget extends State<PhoneWidget> {
  String phone = '';
  bool enabled = false;
  String code = '';
  String event = 'Тестовый';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        phoneField(),
        const SizedBox(height: 30),
        button(),
        const SizedBox(height: 30),
        group(),
      ],
    );
  }

  Widget phoneField() {
    return IntlPhoneField(
      decoration: const InputDecoration(
        labelText: 'Номер телефона',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      initialCountryCode: 'RU',
      style: const TextStyle(fontFamily: 'Montserrat', fontSize: 18),
      onChanged: (phone) {
        setState(() {
          this.phone = '8${phone.number}';
          if (this.phone.length > 9) {
            enabled = true;
          } else {
            enabled = false;
          }
        });
      },
      onSaved: (phone) {
        setState(() {
          this.phone = phone!.number;
          enabled = true;
        });
      },
    );
  }

  Widget button() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromRGBO(46, 46, 229, 100),
      ),
      child: InkWell(
        onTap: enabled ? () => sendToAPI() : null,
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            'Создать группу',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22),
          ),
        ),
      ),
    );
  }

  void sendToAPI() async {
    List<GroupParticipant> participants =
        widget.receipts.keys.map((e) => GroupParticipant(name: e)).toList();

    final groupCreator = participants.first;

    Group group = Group(
      title: event,
      creator: groupCreator,
      requisites: phone,
      participants: participants,
    );

    await GroupParticipantHttp().save(groupCreator);
    await GroupHttp().save(group);

    group.bill = widget.items
        .map(
          (item) => BillPosition(
            title: item['name'],
            price: calculateTotalCost(item),
            parts: item['quantity'],
            personalParts: Map.fromEntries(
              widget.receipts.entries
                  .where((entry) =>
                      entry.value.any((pos) => compareMaps(pos, item)))
                  .map(
                (entry) {
                  final posG = entry.value.firstWhere(
                      (itemG) => compareMapsWithoutQTY(itemG, item));
                  return MapEntry(
                    participants.firstWhere(
                        (participant) => participant.name == entry.key),
                    Tuple2(
                      calculateTotalCost(posG),
                      posG['quantity'],
                    ),
                  );
                },
              ),
            ),
          ),
        )
        .toList();

    await BillHttp().save(group);

    setState(() {
      code = "${group.id}";
    });
  }

  Widget group() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white),
      ),
      child: ListTile(
        tileColor: const Color.fromRGBO(46, 46, 229, 100),
        contentPadding: const EdgeInsets.all(8.0),
        leading: const Text(
          'Код: ',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        enabled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              code,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
            IconButton(
              onPressed: () => copyToClipboard(),
              icon: const Icon(
                Icons.content_copy,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Код скопирован в буфер обмена'),
      ),
    );
  }
}

int calculateTotalCost(Map<String, dynamic> item) {
  return makeInteger(item['quantity'] * item['price']);
}

List<Map<String, dynamic>> combineItems(List<Map<String, dynamic>> items) {
  Map<String, List<Map<String, dynamic>>> groupedItems =
      groupBy(items, (item) => item['name']);

  List<Map<String, dynamic>> combinedItems = [];

  groupedItems.forEach((name, itemList) {
    var totalQuantity = 0;
    var delta = 0.0;

    itemList.forEach((item) {
      totalQuantity++;
      delta += item['price'];
    });

    var combinedItem = {
      'name': name,
      'quantity': totalQuantity,
      'price': delta,
    };

    combinedItems.add(combinedItem);
  });

  return combinedItems;
}

int makeInteger(num number) {
  while (number % 1 != 0) {
    number *= 10;
  }
  return int.tryParse(number.toString()) ?? 0;
}

bool compareMaps(Map<String, dynamic> map1, Map<String, dynamic> map2) {
  return map1['name'] == map2['name'] &&
      map1['price'] == map2['price'] &&
      map1['quantity'] == map2['quantity'];
}

bool compareMapsWithoutQTY(
    Map<String, dynamic> map1, Map<String, dynamic> map2) {
  return map1['name'] == map2['name'] &&
      map1['price'] == map2['price'] &&
      map1['quantity'] == map2['quantity'];
}
