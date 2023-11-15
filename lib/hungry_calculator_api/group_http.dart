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

  Future<Group> getById(String id) async {
    final response = await Network(path: '$path/$id').get();
    final decodedResponse =
        GetGroupResponse.fromJson(jsonDecode(response.body));

    final participants = decodedResponse.participants
        .map((participantDto) => GroupParticipant(
              id: participantDto.id,
              name: participantDto.name,
            ))
        .toList();

    return Group(
      id: id,
      title: decodedResponse.title,
      creator: GroupCreator(
        id: decodedResponse.creator.id,
        name: participants
            .firstWhere(
                (participant) => participant.id == decodedResponse.creator.id)
            .name,
        requisites: decodedResponse.creator.requisites,
      ),
      participants: decodedResponse.participants
          .map((participantDto) => GroupParticipant(
                id: participantDto.id,
                name: participantDto.name,
              ))
          .toList(),
      bill: decodedResponse.bill.positions
          .map((positionDto) => BillPosition(
                title: positionDto.title,
                parts: Map.fromEntries(positionDto.payers.map((payer) =>
                    MapEntry(
                        participants.firstWhere(
                            (participant) => participant.id == payer.id),
                        payer.pricePerPart))),
              ))
          .toList(),
    );
  }
}
