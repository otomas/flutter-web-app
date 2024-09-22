extension ExtensionBool on bool? {
  String? getOrderDirection(String? orderByField) => orderByField == null ? null : this ?? false ? 'ASC' : 'DESC';
}

extension  ExtensionStringBool on String? {
  bool isValidEmail() {
    final value = this;
    if (value == null) {
      return false;
    }
    if (value.isNotEmpty) {
      const pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
      final regex = RegExp(pattern);
      return regex.hasMatch(value);
    } else {
      return false;
    }
  }

  bool isValidPhone() {
    final value = this;
    if (value == null) {
      return false;
    }
    if (value.isNotEmpty) {
      const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      final regex = RegExp(pattern);
      return regex.hasMatch(value);
    } else {
      return false;
    }
  }

  bool isValidIBAN(String iban) {
    iban = iban.replaceAll(' ', '').replaceAll('-', '');
    final regex = RegExp(r'^TR\d{2}\d{4}\d{1}[0-9A-Z]{16}$');

    if (!regex.hasMatch(iban)) {
      return false;
    }

    final ibanDigits = iban.substring(4) + iban.substring(0, 4);
    var ibanValue = 0;

    for (var i = 0; i < ibanDigits.length; i++) {
      final digit = int.parse(ibanDigits[i], radix: 36);
      ibanValue = (ibanValue * 10 + digit) % 97;
    }

    return ibanValue == 1;
  }

  bool isValidPassword() {
    final value = this;
    if (value == null) {
      return false;
    }
    if (value.isNotEmpty) {
      const pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
      final regExp = RegExp(pattern);
      return regExp.hasMatch(value);
    } else {
      return false;
    }
  }

  bool isValidTCIdentityNumber() {
    if (this == null || this!.isEmpty) {
      return false;
    }
    final identitiyNumber = int.parse(this!);
    if (identitiyNumber.toString().length == 11) {
      if (identitiyNumber.toString().substring(0, 1) != '0') {
        var top = 0;
        for (var i = 0; i < 10; i++) {
          final val = identitiyNumber.toString().substring(i, i + 1);
          top = top + int.parse(val);
        }
        top = top % 10;
        if (top == int.parse(identitiyNumber.toString().substring(10))) {
          return true;
        }
      }
    }
    return false;
  }

  bool isValidTaxNumber() => this != null && this!.length >= 10;
}
