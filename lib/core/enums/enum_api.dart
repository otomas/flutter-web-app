enum PaymentType {
  cash(1),
  creditCard(2),
  bankTransfer(3),
  prepaidCard(4);

  const PaymentType(this.id);
  factory PaymentType.fromId(int id) => values.firstWhere((e) => e.id == id);

  final int id;
}

enum QueryType {
  plate(1),
  chassis(2);

  const QueryType(this.id);
  factory QueryType.fromId(int id) => values.firstWhere((e) => e.id == id);

  final int id;
}

enum VehicleStatus {
  archived('archived'),
  sold('sold'),
  onTheAir('on-the-air'),
  discontinuePublication('discontinue-publication'),
  readyForPublication('ready-for-publication'),
  consignee('consignee'),
  inventory('inventory'),
  rejected('rejected'),
  waiting('waiting_approve'),
  expired('expired');

  const VehicleStatus(this.id);
  factory VehicleStatus.fromId(String id) => values.firstWhere((e) => e.id == id);

  final String id;
}
