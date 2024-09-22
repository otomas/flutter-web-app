import '../enums/enum_app.dart';

extension ExtensionDialogType on DialogTypes? {
  String getSvg() {
    return '';
    //   switch (this) {
    //     case DialogTypes.confirmation:
    //       return R.drawable.svg.iconQuestion;
    //     case DialogTypes.error:
    //       return R.drawable.svg.iconError;
    //     case DialogTypes.warning:
    //       return R.drawable.svg.iconWarning;
    //     case DialogTypes.success:
    //       return R.drawable.svg.iconSuccess;
    //     case DialogTypes.delete:
    //         return R.drawable.svg.iconEdit;
    //     default:
    //       return R.drawable.svg.iconInformation;
    //   }
    // }
  }
}
