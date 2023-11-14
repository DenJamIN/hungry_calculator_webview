import 'group_participant.dart';

class GroupCreator extends GroupParticipant {
  String? requisites;

  GroupCreator({
    super.id,
    required super.name,
    this.requisites,
  });

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'requisites': requisites,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is GroupCreator &&
          runtimeType == other.runtimeType &&
          requisites == other.requisites;

  @override
  int get hashCode => super.hashCode ^ requisites.hashCode;
}
