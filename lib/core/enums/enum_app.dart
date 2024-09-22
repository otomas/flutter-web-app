enum ThemeApperance { light, dark, system }

enum ActivityState { isLoading, isLoaded, isError }

enum ActivityErrorActionState { none, gotoBack, logout, directLogout }

enum DialogTypes {
  warning('W'),
  error('E'),
  confirmation('C'),
  success('S');

  const DialogTypes(this.id);
  factory DialogTypes.fromId(String id) => values.firstWhere((e) => e.id == id);
  final String id;
}

enum ResultType { success, warning, error }

enum AppLanguage {
  locale(-1),
  en(0),
  tr(1);

  const AppLanguage(this.id);
  factory AppLanguage.fromId(int id) => values.firstWhere((e) => e.id == id);

  final int id;
}

enum Flavor {
  prod('prod'),
  dev('dev');

  const Flavor(this.value);
  final String value;
}

enum FileType {
  camera,
  gallery,
  videoGallery,
  videoCamera,
  voice,
  pdf,
  unkown,
}

enum AuthState {
  authenticated(1),
  unauthenticated(2);

  const AuthState(this.id);
  factory AuthState.fromId(int id) => values.firstWhere((e) => e.id == id);

  final int id;
}

enum AccountBookProcessType {
  create(0),
  update(1);

  const AccountBookProcessType(this.id);
  factory AccountBookProcessType.fromId(int id) => values.firstWhere((e) => e.id == id);
  final int id;
}

enum PageStyle {
  twoBox,
  threeBox,
  verticalBox,
}
