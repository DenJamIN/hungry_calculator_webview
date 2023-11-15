import 'dart:convert';

import 'package:hungry_calculator/dtos/dtos.dart';
import 'package:hungry_calculator/models/hungry_calculator/group_participant.dart';

import 'network.dart';

class GroupParticipantHttp {
  final String path = 'participants';

  Future<GroupParticipant> save(GroupParticipant participant) async {
    final response = await Network(path: path).post(
        jsonEncode(CreateGroupParticipantRequest(name: participant.name)));
    final decodedResponse =
        CreateGroupParticipantResponse.fromJson(jsonDecode(response.body));

    participant.id = decodedResponse.id;

    return participant;
  }
}
