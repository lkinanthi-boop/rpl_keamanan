import 'package:flutter_test/flutter_test.dart';
import 'package:secure_http/utils/validators.dart';

void main() {
  group('Validators.isValidEmail()', () {
    test('Email valid', () {
      expect(Validators.isValidEmail('user@gmail.com'), isTrue);
    });

    test('Email tidak valid', () {
      expect(Validators.isValidEmail('usergmail.com'), isFalse);
      expect(Validators.isValidEmail('user@'), isFalse);
      expect(Validators.isValidEmail(''), isFalse);
    });
  });

  group('Validators.sanitize()', () {
    test('Menghapus karakter berbahaya', () {
      final result = Validators.sanitize('<script>alert("XSS")</script>');

      expect(result, isNot(contains('<')));
      expect(result, isNot(contains('>')));
      expect(result, isNot(contains('"')));
      expect(result, isNot(contains("'")));
    });

    test('Menghapus spasi di awal dan akhir', () {
      expect(Validators.sanitize('  hello  '), 'hello');
    });
  });

  group('Validators.validateText()', () {
    test('Teks dengan panjang valid', () {
      expect(
        Validators.validateText('Flutter', minLength: 3, maxLength: 10),
        isNull,
      );
    });

    test('Teks terlalu pendek', () {
      expect(
        Validators.validateText('Hi', minLength: 3, maxLength: 10),
        isNotNull,
      );
    });

    test('Teks terlalu panjang', () {
      expect(
        Validators.validateText(
          'Flutter Programming',
          minLength: 3,
          maxLength: 10,
        ),
        isNotNull,
      );
    });

    test('Teks kosong atau null', () {
      expect(Validators.validateText(''), isNotNull);
      expect(Validators.validateText(null), isNotNull);
    });
  });
}
