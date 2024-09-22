class ModelCreditRequest {

  const ModelCreditRequest({
    required this.photoUrl,
    required this.plate,
    required this.brand,
    required this.model,
    required this.clientName,
    required this.clientSurname,
    required this.creditAmount,
  });
  final String? photoUrl;
  final String plate;
  final String brand;
  final String model;
  final String clientName;
  final String clientSurname;
  final double creditAmount;
}
