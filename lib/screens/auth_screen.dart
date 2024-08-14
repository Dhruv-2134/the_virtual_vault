import 'package:flutter/material.dart';
import 'package:the_virtual_vault/models/user.dart';
import '../services/auth_service.dart';
import '../utils/validators.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _name = '';
  String _phone = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_isLogin) {
          // ignore: unused_local_variable
          final user = await _authService.login(_email, _password);
          // Handle successful login
        } else {
          // ignore: unused_local_variable
          final user = await _authService.register(User(
            id: 0, // ID will be assigned by the server
            email: _email,
            username: _email,
            password: _password,
            name: {'firstname': _name, 'lastname': ''},
            address: {},
            phone: _phone,
          ));
          // Handle successful registration
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(); // Return to previous screen
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: validateEmail,
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: validatePassword,
              onSaved: (value) => _password = value!,
            ),
            if (!_isLogin) ...[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: validateName,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: validatePhone,
                onSaved: (value) => _phone = value!,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(_isLogin ? 'Login' : 'Register'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? 'Create an account' : 'I already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
