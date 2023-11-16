import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneWidget extends StatefulWidget {
  final Map<String, List<Map<String, dynamic>>> receipts;

  const PhoneWidget({super.key, required this.receipts});

  @override
  State<StatefulWidget> createState() => _PhoneWidget();
}

class _PhoneWidget extends State<PhoneWidget> {
  late String phone;
  bool enabled = false;
  String code = '';

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
    print('кнопка нажата');
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
