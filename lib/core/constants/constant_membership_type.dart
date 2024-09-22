import '../models/model_dropdown.dart';

class ConstantMemberShipType {

  ConstantMemberShipType() {
    _types.addAll([
      realEntity,
      legalEntity,
    ]);
  }
  static ConstantMemberShipType? _instance;
  static ConstantMemberShipType getInstance() => _instance ??= ConstantMemberShipType();
  List<ModelDropdown> get types => _types;
  static void refresh() => _instance = null;

  final ModelDropdown realEntity = const ModelDropdown(id: 2, title: 'Gerçek Kişi');
  final ModelDropdown legalEntity = const ModelDropdown(id: 1, title: 'Tüzel Kişi');

  final List<ModelDropdown> _types = [];

  ModelDropdown getMembershipTypeForId(int id) {
    for (final item in _types) {
      if (item.id == id) {
        return item;
      }
    }
    return _types.first;
  }
}
