class CreateParticipantResponse {
  int id;

  CreateParticipantResponse({required this.id});

  factory CreateParticipantResponse.fromJson(Map<String, dynamic> json) =>
      CreateParticipantResponse(id: json['id']);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateParticipantResponse &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
