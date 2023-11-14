class GroupCreatorDto {
  int id;
  String requisites;

  GroupCreatorDto({required this.id, required this.requisites});

  factory GroupCreatorDto.fromJson(Map<String, dynamic> json) =>
      GroupCreatorDto(
        id: json['id'],
        requisites: json['requisites'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'requisites': requisites,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupCreatorDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
