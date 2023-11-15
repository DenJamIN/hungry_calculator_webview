import 'dart:convert';

import '../dtos/dtos.dart';
import '../models/hungry_calculator/models.dart';
import 'network.dart';

class GroupHttp {
  final String path = 'groups';

  Future<Group> save(Group group) async {
    final response =
        await Network(path: '$path/create/').post(jsonEncode(CreateGroupRequest(
      title: group.title,
      creator: GroupCreatorDto(id: group.creator.id!),
      requisites: group.requisites,
      participants: group.participants!
          .map((participant) =>
              CreateGroupRequestGroupParticipant(name: participant.name))
          .toList(),
    ).toJson()));
    final decodedResponse =
        CreateGroupResponse.fromJson(jsonDecode(response.body));

    group.id = decodedResponse.id;

    return group;
  }
}
