class ValidatorUtils {
  static String? validateURL(String? value) {
    if (value!.isEmpty) {
      return "Please add a link here";
    } else {
      return null;
    }
  }
}
