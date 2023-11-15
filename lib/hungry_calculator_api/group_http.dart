import 'dart:convert';

import '../dtos/dtos.dart';
import '../models/hungry_calculator/models.dart';
import 'network.dart';

class GroupHttp {
  final String path = 'groups';

  Future<Group> save(Group group) async {
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
