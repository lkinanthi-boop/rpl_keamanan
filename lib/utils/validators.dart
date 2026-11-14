class Validators {
  // Membersihkan karakter berbahaya dan spasi.
  static String sanitize(String value) {
    return value
        .replaceAll(RegExp(r'''[<>"']'''), '')
        .replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '')
        .trim();
  }

  // Validasi email dengan hasil true atau false.
  static bool isValidEmail(String? value) {
    final email = sanitize(value ?? '');

    if (email.isEmpty) {
      return false;
    }

    final emailRegex = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }

  // Validasi teks berdasarkan panjang minimum dan maksimum.
  static String? validateText(
    String? value, {
    int minLength = 1,
    int? maxLength,
  }) {
    final text = sanitize(value ?? '');

    if (text.isEmpty) {
      return 'Kolom tidak boleh kosong';
    }

    if (text.length < minLength) {
      return 'Teks minimal $minLength karakter';
    }

    if (maxLength != null && text.length > maxLength) {
      return 'Teks maksimal $maxLength karakter';
    }

    return null;
  }

  // Validasi nama.
  static String? validateName(String? value) {
    return validateText(value, minLength: 3);
  }

  // Validasi email untuk TextFormField.
  static String? validateEmail(String? value) {
    if (sanitize(value ?? '').isEmpty) {
      return 'Email tidak boleh kosong';
    }

    if (!isValidEmail(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  // Validasi nomor telepon.
  static String? validatePhone(String? value) {
    final phone = sanitize(value ?? '');

    if (phone.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    if (!RegExp(r'^[0-9]{10,13}$').hasMatch(phone)) {
      return 'Nomor telepon harus terdiri dari 10–13 digit';
    }

    return null;
  }

  // Validasi URL.
  static String? validateUrl(String? value) {
    final url = sanitize(value ?? '');

    if (url.isEmpty) {
      return 'URL tidak boleh kosong';
    }

    final uri = Uri.tryParse(url);

    if (uri == null ||
        !uri.hasAuthority ||
        !['http', 'https'].contains(uri.scheme) ||
        uri.host.isEmpty ||
        !uri.host.contains('.')) {
      return 'URL harus menggunakan http atau https dan format yang valid';
    }

    return null;
  }

  // Validasi password.
  static String? validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    if (password.length < 8) {
      return 'Password minimal 8 karakter';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password harus memiliki huruf besar';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password harus memiliki angka';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]').hasMatch(password)) {
      return 'Password harus memiliki simbol';
    }

    return null;
  }
}
