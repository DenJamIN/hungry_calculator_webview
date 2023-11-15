import 'dart:convert';

import 'package:http/http.dart' hide Client;
import 'package:hungry_calculator/dtos/dtos.dart';
import '../models/hungry_calculator/models.dart';
import 'network.dart';

class GroupHttp {
  String path = 'groups';

  Future<Group> saveGroup(Group group) async {
    final response =
        await Network(path: path).post(jsonEncode(CreateGroupRequest(
      title: group.title,
      creator: GroupCreatorDto(
        id: group.creator.id!,
        requisites: group.creator.requisites!,
      ),
      participants: group.participants!
          .map((participant) =>
              CreateGroupRequestGroupParticipant(name: participant.name))
          .toList(),
    )));
    final decodedResponse =
        CreateGroupResponse.fromJson(jsonDecode(response.body));

    group.id = decodedResponse.id;

    return group;
  }
}
