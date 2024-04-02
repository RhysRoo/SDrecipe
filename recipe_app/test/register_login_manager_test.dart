import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_log/pages/login/register_login_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late RegisterLoginManager registerLoginManager;
  late FirebaseFirestore fakefirestore;
  late MockFirebaseAuth mockAuth;

  setUp(() {
    fakefirestore = FakeFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    registerLoginManager = RegisterLoginManager();
  });

  group('Registration Login Manager', () {});

  group('Registration Login Manager checkEmailValidity() Tests', () {
    test('Valid Email', () {
      expect(registerLoginManager.checkEmailValidity("example@example.com"),
          isTrue);
    });

    test('Valid Short Email', () {
      expect(registerLoginManager.checkEmailValidity("a@b.c"), isFalse);
    });

    test('Invalid Short Email', () {
      expect(registerLoginManager.checkEmailValidity("a@b"), isFalse);
    });

    test('Invalid Long Email', () {
      expect(
          registerLoginManager.checkEmailValidity(
              "12345678901234567890123456789012345678901234567890123456789012345@example.com"),
          isTrue);
    });

    test('Invalid No At Symbol', () {
      expect(registerLoginManager.checkEmailValidity("example.com"), isFalse);
    });

    test('Invalid as @ symbol is duplicated', () {
      expect(registerLoginManager.checkEmailValidity("exa@mple@example.com"),
          isFalse);
    });
  });

  group('Login and Register Manager confirmPassword()  Test', () {
    test('Correct Password Match, Length and Symbol', () {
      final result =
          registerLoginManager.confirmPassword('jam!es123', 'jam!es123');
      expect(result, true);
    });
    test('Correct Password Match, Length and Symbol', () {
      final result =
          registerLoginManager.confirmPassword('johndoe12*', 'johndoe12*');
      expect(result, true);
    });
    test('Correct Password Match, Symbol but not Length', () {
      final result = registerLoginManager.confirmPassword('ja!23', 'ja!23');
      expect(result, false);
    });
    test('Correct Password Match, Symbol but not Length', () {
      final result = registerLoginManager.confirmPassword('j£a23', 'j£a23');
      expect(result, false);
    });
    test('Correct Password Match, Length but not symbol', () {
      final result = registerLoginManager.confirmPassword('jam23', 'jam23');
      expect(result, false);
    });

    test('Correct Password Match, Length but not symbol', () {
      final result = registerLoginManager.confirmPassword('jafjhsf', 'jafjhsf');
      expect(result, false);
    });
    test('No Match Confirmation', () {
      final result =
          registerLoginManager.confirmPassword('jam!es123', 'dhsdjshgf');
      expect(result, false);
    });
  });

  group('Login and Register Manager passwordLengthCheck() Test', () {
    test('Valid Password', () {
      expect(
          registerLoginManager.passwordLengthCheck("GoodPassword123!"), true);
    });

    test('Short Password', () {
      expect(registerLoginManager.passwordLengthCheck("Short"), false);
    });

    test('Long Password', () {
      expect(
          registerLoginManager.passwordLengthCheck(
              "ThisIsAVeryLongPasswordThatExceedsTheLimitOfAllowedCharactersAndIsDefinitelyNotValid"),
          false);
    });

    test('Valid Password Without Symbol', () {
      expect(registerLoginManager.passwordLengthCheck("NoSymbolPassword123"),
          false);
    });

    test('Null Password', () {
      expect(registerLoginManager.passwordLengthCheck(""), false);
    });

    test('Null Password', () {
      expect(registerLoginManager.passwordLengthCheck(''), false);
    });
  });

  group('Login and Register Manager samePassword() Test', () {
    test('Testing Same Passwords', () {
      final result =
          registerLoginManager.samePassword('jam!es123', 'jam!es123');
      expect(result, true);
    });
    test('Testing Same Passwords', () {
      final result =
          registerLoginManager.samePassword('johndoe12*', 'johndoe12*');
      expect(result, true);
    });
    test('Testing Same Passwords', () {
      final result = registerLoginManager.samePassword('SHDSHD^', 'SHDSHD^');
      expect(result, true);
    });
    test('Testing Same Passwords', () {
      final result =
          registerLoginManager.samePassword('#james123', '#james123');
      expect(result, true);
    });
  });

  group('Login and Register Manager containSymbols() Test', () {
    test('Symbol Present', () {
      final result = registerLoginManager
          .containsSymbol("#"); // Testing with different symbols
      expect(result, isTrue);
    });

    test('Symbol Present', () {
      final result = registerLoginManager
          .containsSymbol("#fheqhdwjif"); // Testing with different symbols
      expect(result, isTrue);
    });

    test('Symbol Present', () {
      final result = registerLoginManager
          .containsSymbol("fhdfsqfef^"); // Testing with different symbols
      expect(result, isTrue);
    });

    test('Symbol Present', () {
      final result = registerLoginManager
          .containsSymbol("fdfvnnfu64*"); // Testing with different symbols
      expect(result, isTrue);
    });

    test('Symbol Not Present', () {
      final result = registerLoginManager
          .containsSymbol("password"); // Testing with a string without symbols
      expect(result, isFalse);
    });

    test('Symbol Not Present', () {
      final result = registerLoginManager.containsSymbol(
          "hfbwdbfdwnf"); // Testing with a string without symbols
      expect(result, isFalse);
    });

    test('Symbol Not Present', () {
      final result = registerLoginManager
          .containsSymbol("rteywui"); // Testing with a string without symbols
      expect(result, isFalse);
    });

    test('Symbol Not Present', () {
      final result = registerLoginManager
          .containsSymbol("a"); // Testing with a string without symbols
      expect(result, isFalse);
    });
  });

  group('RLogin and Register Manager isAlphaNumeric() Test', () {
    test('Test digits', () {
      expect(registerLoginManager.isAlphaNumeric(48), isTrue); // '0'
      expect(registerLoginManager.isAlphaNumeric(57), isTrue); // '9'
    });

    test('Test uppercase letters', () {
      expect(registerLoginManager.isAlphaNumeric(65), isTrue); // 'A'
      expect(registerLoginManager.isAlphaNumeric(90), isTrue); // 'Z'
    });

    test('Test lowercase letters', () {
      expect(registerLoginManager.isAlphaNumeric(97), isTrue); // 'a'
      expect(registerLoginManager.isAlphaNumeric(122), isTrue); // 'z'
    });

    test('Test special characters', () {
      expect(registerLoginManager.isAlphaNumeric(33), isFalse); // '!'
      expect(registerLoginManager.isAlphaNumeric(64), isFalse); // '@'
      expect(registerLoginManager.isAlphaNumeric(91), isFalse); // '['
      expect(registerLoginManager.isAlphaNumeric(96), isFalse); // '`'
      expect(registerLoginManager.isAlphaNumeric(123), isFalse); // '{'
    });
  });

  group('Login and Register Manager isWhitespace() Test', () {
    test('Test space character', () {
      expect(registerLoginManager.isWhitespace(32), isTrue);
    });

    test('Test non-space characters', () {
      expect(registerLoginManager.isWhitespace(33), isFalse); // '!'
      expect(registerLoginManager.isWhitespace(65), isFalse); // 'A'
      expect(registerLoginManager.isWhitespace(97), isFalse); // 'a'
      expect(registerLoginManager.isWhitespace(126), isFalse); // '~'
      expect(registerLoginManager.isWhitespace(0), isFalse); // null character
      expect(
          registerLoginManager.isWhitespace(10), isFalse); // newline character
    });
  });

  group('Login and Register Manager checkNullEntry() Test', () {
    test('Both strings are not null and not empty', () {
      expect(registerLoginManager.checkNullEntry('hello', 'world'), isTrue);
    });

    test('First string is null', () {
      expect(registerLoginManager.checkNullEntry(null, 'world'), isFalse);
    });

    test('Second string is null', () {
      expect(registerLoginManager.checkNullEntry('hello', null), isFalse);
    });

    test('Both strings are null', () {
      expect(registerLoginManager.checkNullEntry(null, null), isFalse);
    });

    test('First string is empty', () {
      expect(registerLoginManager.checkNullEntry('', 'world'), isFalse);
    });

    test('Second string is empty', () {
      expect(registerLoginManager.checkNullEntry('hello', ''), isFalse);
    });

    test('Both strings are empty', () {
      expect(registerLoginManager.checkNullEntry('', ''), isFalse);
    });
  });
}
