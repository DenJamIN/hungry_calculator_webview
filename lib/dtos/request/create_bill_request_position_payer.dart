class CreateBillRequestPositionPayer {
  int id;
  int pricePerPart;

  CreateBillRequestPositionPayer({
    required this.id,
    required this.pricePerPart,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'pricePerPart': pricePerPart,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateBillRequestPositionPayer &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
