// ignore_for_file: file_names

// To Add -> Test that does not store the same email already in firebase
// To Integrate -> Integrate within the original program

class RegisterLoginManager {
  RegisterLoginManager() {}

  bool checkEmailValidity(final String email) {
    if (email.length >= 3 && email.length < 254 && email.contains('@')) {
      var atIndex = email.indexOf('@');
      // Split the email string by "@" and check if there are exactly two parts
      return atIndex >= 3 && email.split('@').length == 2;
    }
    return false;
  }

  bool checkNullEntry(String? stringOne, String? stringTwo) {
    // Check if both strings are not null and not empty
    return stringOne != null &&
        stringOne.isNotEmpty &&
        stringTwo != null &&
        stringTwo.isNotEmpty;
  }

  bool confirmPassword(final String passwordOne, final String passwordTwo) {
    if (samePassword(passwordOne, passwordTwo) &&
        passwordLengthCheck(passwordOne)) {
      return true;
    }
    return false;
  }

  bool samePassword(final String passwordOne, final String passwordTwo) {
    if (passwordOne == passwordTwo) {
      return true;
    }
    return false;
  }

  bool passwordLengthCheck(final String passwordOne) {
    if ((passwordOne.length >= 6 && passwordOne.length <= 200) &&
        containsSymbol(passwordOne)) {
      return true;
    }
    return false;
  }

  bool containsSymbol(String input) {
    // Converts input to unicode
    for (var char in input.runes) {
      if (!isAlphaNumeric(char) && !isWhitespace(char)) {
        return true;
      }
    }
    return false;
  }

  bool isAlphaNumeric(int charCode) {
    return (charCode >= 48 && charCode <= 57) || // 0-9
        (charCode >= 65 && charCode <= 90) || // A-Z
        (charCode >= 97 && charCode <= 122); // a-z
  }

  bool isWhitespace(int charCode) {
    return charCode == 32; // space
  }
}
