import 'group_creator.dart';
import 'group_participant.dart';

import 'bill_position.dart';

class Group {
  String? id;
  String title;
  GroupCreator creator;
  List<GroupParticipant>? participants;
  List<BillPosition>? bill;

  Group({
    this.id,
    required this.title,
    required this.creator,
    this.participants,
    this.bill,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Group &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          creator == other.creator &&
          participants == other.participants &&
          bill == other.bill;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      creator.hashCode ^
      participants.hashCode ^
      bill.hashCode;
}
