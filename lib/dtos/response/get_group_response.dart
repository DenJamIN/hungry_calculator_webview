import 'dart:convert';

import '../group_creator_dto.dart';

import 'get_group_response_bill.dart';
import 'get_group_response_group_participant.dart';

class GetGroupResponse {
  String title;
  GroupCreatorDto creator;
  List<GetGroupResponseGroupParticipant> participants;
  GetGroupResponseBill bill;

  GetGroupResponse({
    required this.title,
    required this.creator,
    required this.participants,
    required this.bill,
  });

  factory GetGroupResponse.fromJson(Map<String, dynamic> json) =>
      GetGroupResponse(
        title: json['title'],
        creator: GroupCreatorDto.fromJson(json['creator']),
        participants:
            (jsonDecode(json['participants']) as List<Map<String, dynamic>>)
                .map((participantJson) =>
                    GetGroupResponseGroupParticipant.fromJson(participantJson))
                .toList(),
        bill: GetGroupResponseBill.fromJson(json['bill']),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetGroupResponse &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          creator == other.creator &&
          participants == other.participants &&
          bill == other.bill;

  @override
  int get hashCode =>
      title.hashCode ^ creator.hashCode ^ participants.hashCode ^ bill.hashCode;
}
