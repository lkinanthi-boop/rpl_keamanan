/// Kumpulan fungsi validasi dan sanitasi input.
class Validators {
  /// Memvalidasi format email.
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  /// Memvalidasi bahwa value tidak kosong.
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Memvalidasi panjang value.
  static bool hasValidLength(String value, {int min = 1, int max = 100}) {
    final length = value.trim().length;
    return length >= min && length <= max;
  }

  /// Membersihkan input dari karakter HTML tertentu.
  static String sanitize(String input) {
    return input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;')
        .trim();
  }

  /// Memvalidasi input teks.
  static String? validateText(
    String? value, {
    String fieldName = 'Field',
    int minLength = 1,
    int maxLength = 100,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }

    if (!hasValidLength(value, min: minLength, max: maxLength)) {
      return '$fieldName harus antara $minLength-$maxLength karakter';
    }

    return null;
  }

  /// Memvalidasi email dan mengembalikan pesan error jika tidak valid.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    if (!isValidEmail(value.trim())) {
      return 'Format email tidak valid';
    }

    return null;
  }
}
