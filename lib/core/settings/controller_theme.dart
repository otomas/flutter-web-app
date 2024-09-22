import '../enums/enum_app.dart';
import '../resources/_r.dart';
import '../utils/general_data.dart';

class ThemeController {
  static ThemeController? _instance;
  static ThemeController getInstance() => _instance ??= ThemeController();
  
  ThemeApperance currentAppTheme = ThemeApperance.light;

  Future<void> setTheme(ThemeApperance theme) async {
    currentAppTheme = theme;
    if(GeneralData.getInstance().getDarkMode() != theme) {
      await GeneralData.getInstance().setDarkMode(theme);
    }
    R.refreshClass();
  }

  Future<void> getTheme() async {
    await setTheme(GeneralData.getInstance().getDarkMode());
  }
}
