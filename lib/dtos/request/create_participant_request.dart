class CreateParticipantRequest {
  String name;

  CreateParticipantRequest({required this.name});

  Map<String, dynamic> toJson() => {
        'name': name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateParticipantRequest &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
