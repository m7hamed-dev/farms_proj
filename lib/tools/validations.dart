class ValidatorClass {
  static String? validateEmail(String? value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value!.trim())) {
      return 'ادخل ايميل صحيح';
    }
    return null;
  }

  static String? emptyField(String? value) {
    if (value!.isEmpty) {
      return 'الحقل مطلوب';
    }
    return null;
  }
}
