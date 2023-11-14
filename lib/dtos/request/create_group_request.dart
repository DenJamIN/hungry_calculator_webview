import 'dart:convert';

import '../group_creator_dto.dart';
import 'create_group_request_group_participant.dart';

class CreateGroupRequest {
  String title;
  GroupCreatorDto creator;
  List<CreateGroupRequestGroupParticipant> participants;

  CreateGroupRequest({
    required this.title,
    required this.creator,
    required this.participants,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'creator': creator.toJson(),
        'participants':
            jsonEncode(participants.map((participant) => participant.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateGroupRequest &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          creator == other.creator &&
          participants == other.participants;

  @override
  int get hashCode => title.hashCode ^ creator.hashCode ^ participants.hashCode;
}
