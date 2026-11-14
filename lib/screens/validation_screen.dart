import 'package:flutter/material.dart';
import '../utils/validators.dart';


class ValidationScreen extends StatefulWidget {
const ValidationScreen({super.key});

@override
State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
final _formKey = GlobalKey<FormState>();

final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _phoneController = TextEditingController();
final _urlController = TextEditingController();
final _passwordController = TextEditingController();

String _result = '';

@override
void dispose() {
_nameController.dispose();
_emailController.dispose();
_phoneController.dispose();
_urlController.dispose();
_passwordController.dispose();
super.dispose();
}

void _submitForm() {
if (_formKey.currentState!.validate()) {
// Membersihkan input sebelum diproses.
final name = Validators.sanitize(_nameController.text);
final email = Validators.sanitize(_emailController.text);
final phone = Validators.sanitize(_phoneController.text);
final url = Validators.sanitize(_urlController.text);

setState(() {
_result = '''
Validasi berhasil!

Nama: $name
Email: $email
Nomor Telepon: $phone
URL: $url
Password: Berhasil divalidasi
''';
});
} else {
setState(() {
_result = 'Terdapat input yang belum valid. Periksa kembali!';
});
}
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Validasi Input'),
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
TextFormField(
controller: _nameController,
decoration: const InputDecoration(
labelText: 'Nama',
border: OutlineInputBorder(),
),
validator: Validators.validateName,
),
const SizedBox(height: 16),

TextFormField(
controller: _emailController,
keyboardType: TextInputType.emailAddress,
decoration: const InputDecoration(
labelText: 'Email',
border: OutlineInputBorder(),
),
validator: Validators.validateEmail,
),
const SizedBox(height: 16),

TextFormField(
controller: _phoneController,
keyboardType: TextInputType.phone,
decoration: const InputDecoration(
labelText: 'Nomor Telepon',
border: OutlineInputBorder(),
),
validator: Validators.validatePhone,
),
const SizedBox(height: 16),

TextFormField(
controller: _urlController,
keyboardType: TextInputType.url,
decoration: const InputDecoration(
labelText: 'URL',
hintText: 'https://example.com',
border: OutlineInputBorder(),
),
validator: Validators.validateUrl,
),
const SizedBox(height: 16),

TextFormField(
controller: _passwordController,
obscureText: true,
decoration: const InputDecoration(
labelText: 'Password',
border: OutlineInputBorder(),
),
validator: Validators.validatePassword,
),
const SizedBox(height: 20),

ElevatedButton(
onPressed: _submitForm,
child: const Text('Validasi Data'),
),

if (_result.isNotEmpty) ...[
const SizedBox(height: 20),
Text(
_result,
style: const TextStyle(fontSize: 14),
),
],
],
),
),
),
);
}
}