import 'package:flutter_log/pages/login/registerManager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RegisterManager registerManager;

  setUp(() {
    registerManager = RegisterManager();
  });

  group('Register Manager confirmPassword()  Test', () {
    test('Correct Password Match, Length and Symbol', () {
      final result = registerManager.confirmPassword('jam!es123', 'jam!es123');
      expect(result, true);
    });
    test('Correct Password Match, Length and Symbol', () {
      final result =
          registerManager.confirmPassword('johndoe12*', 'johndoe12*');
      expect(result, true);
    });
    test('Correct Password Match, Symbol but not Length', () {
      final result = registerManager.confirmPassword('ja!23', 'ja!23');
      expect(result, false);
    });
    test('Correct Password Match, Symbol but not Length', () {
      final result = registerManager.confirmPassword('j£a23', 'j£a23');
      expect(result, false);
    });
    test('Correct Password Match, Length but not symbol', () {
      final result = registerManager.confirmPassword('jam23', 'jam23');
      expect(result, false);
    });

    test('Correct Password Match, Length but not symbol', () {
      final result = registerManager.confirmPassword('jafjhsf', 'jafjhsf');
      expect(result, false);
    });
    test('No Match Confirmation', () {
      final result = registerManager.confirmPassword('jam!es123', 'dhsdjshgf');
      expect(result, false);
    });
  });

  group('Register Manager passwordLengthCheck() Test', () {
    test('Valid Password', () {
      expect(registerManager.passwordLengthCheck("GoodPassword123!"), true);
    });

    test('Short Password', () {
      expect(registerManager.passwordLengthCheck("Short"), false);
    });

    test('Long Password', () {
      expect(
          registerManager.passwordLengthCheck(
              "ThisIsAVeryLongPasswordThatExceedsTheLimitOfAllowedCharactersAndIsDefinitelyNotValid"),
          false);
    });

    test('Valid Password Without Symbol', () {
      expect(registerManager.passwordLengthCheck("NoSymbolPassword123"), false);
    });

    test('Null Password', () {
      expect(registerManager.passwordLengthCheck(""), false);
    });

    test('Null Password', () {
      expect(registerManager.passwordLengthCheck(''), false);
    });
  });

  group('Register Manager samePassword() Test', () {
    test('Testing Same Passwords', () {
      final result = registerManager.samePassword('jam!es123', 'jam!es123');
      expect(result, true);
    });
    test('Testing Same Passwords', () {
      final result = registerManager.samePassword('johndoe12*', 'johndoe12*');
      expect(result, true);
    });
    test('Testing Same Passwords', () {
      final result = registerManager.samePassword('SHDSHD^', 'SHDSHD^');
      expect(result, true);
    });
    test('Testing Same Passwords', () {
      final result = registerManager.samePassword('#james123', '#james123');
      expect(result, true);
    });
  });

  group('Register Manager containSymbols() Test', () {
    test('Symbol Present', () {
      final result =
          registerManager.containsSymbol("#"); // Testing with different symbols
      expect(result, isTrue);
    });

    test('Symbol Present', () {
      final result = registerManager
          .containsSymbol("#fheqhdwjif"); // Testing with different symbols
      expect(result, isTrue);
    });

    test('Symbol Present', () {
      final result = registerManager
          .containsSymbol("fhdfsqfef^"); // Testing with different symbols
      expect(result, isTrue);
    });

    test('Symbol Present', () {
      final result = registerManager
          .containsSymbol("fdfvnnfu64*"); // Testing with different symbols
      expect(result, isTrue);
    });

    test('Symbol Not Present', () {
      final result = registerManager
          .containsSymbol("password"); // Testing with a string without symbols
      expect(result, isFalse);
    });

    test('Symbol Not Present', () {
      final result = registerManager.containsSymbol(
          "hfbwdbfdwnf"); // Testing with a string without symbols
      expect(result, isFalse);
    });

    test('Symbol Not Present', () {
      final result = registerManager
          .containsSymbol("rteywui"); // Testing with a string without symbols
      expect(result, isFalse);
    });

    test('Symbol Not Present', () {
      final result = registerManager
          .containsSymbol("a"); // Testing with a string without symbols
      expect(result, isFalse);
    });
  });

  group('Register Manager isAlphaNumeric() Test', () {
    test('Test digits', () {
      expect(registerManager.isAlphaNumeric(48), isTrue); // '0'
      expect(registerManager.isAlphaNumeric(57), isTrue); // '9'
    });

    test('Test uppercase letters', () {
      expect(registerManager.isAlphaNumeric(65), isTrue); // 'A'
      expect(registerManager.isAlphaNumeric(90), isTrue); // 'Z'
    });

    test('Test lowercase letters', () {
      expect(registerManager.isAlphaNumeric(97), isTrue); // 'a'
      expect(registerManager.isAlphaNumeric(122), isTrue); // 'z'
    });

    test('Test special characters', () {
      expect(registerManager.isAlphaNumeric(33), isFalse); // '!'
      expect(registerManager.isAlphaNumeric(64), isFalse); // '@'
      expect(registerManager.isAlphaNumeric(91), isFalse); // '['
      expect(registerManager.isAlphaNumeric(96), isFalse); // '`'
      expect(registerManager.isAlphaNumeric(123), isFalse); // '{'
    });
  });

  group('Register Manager isWhitespace() Test', () {
    test('Test space character', () {
      expect(registerManager.isWhitespace(32), isTrue);
    });

    test('Test non-space characters', () {
      expect(registerManager.isWhitespace(33), isFalse); // '!'
      expect(registerManager.isWhitespace(65), isFalse); // 'A'
      expect(registerManager.isWhitespace(97), isFalse); // 'a'
      expect(registerManager.isWhitespace(126), isFalse); // '~'
      expect(registerManager.isWhitespace(0), isFalse); // null character
      expect(registerManager.isWhitespace(10), isFalse); // newline character
    });
  });
}
