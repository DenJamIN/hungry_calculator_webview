class CreateGroupResponse {
  String id;

  CreateGroupResponse({required this.id});

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) =>
      CreateGroupResponse(
        id: json['groupId'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateGroupResponse &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
