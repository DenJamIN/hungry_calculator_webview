class GetGroupResponseGroupParticipant {
  int id;
  String name;

  GetGroupResponseGroupParticipant({required this.id, required this.name});

  factory GetGroupResponseGroupParticipant.fromJson(
          Map<String, dynamic> json) =>
      GetGroupResponseGroupParticipant(
        id: json['id'],
        name: json['name'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetGroupResponseGroupParticipant &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
