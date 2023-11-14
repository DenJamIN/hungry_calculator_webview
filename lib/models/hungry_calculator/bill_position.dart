import 'group_participant.dart';

class BillPosition {
  String title;
  Map<GroupParticipant, int> parts;

  BillPosition({
    required this.title,
    required this.parts,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillPosition &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          parts == other.parts;

  @override
  int get hashCode => title.hashCode ^ parts.hashCode;
}
