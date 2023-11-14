class GetGroupResponseBillPositionPayer {
  int id;
  int pricePerPart;

  GetGroupResponseBillPositionPayer({
    required this.id,
    required this.pricePerPart,
  });

  factory GetGroupResponseBillPositionPayer.fromJson(
          Map<String, dynamic> json) =>
      GetGroupResponseBillPositionPayer(
        id: json['id'],
        pricePerPart: json['pricePerPart'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetGroupResponseBillPositionPayer &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
