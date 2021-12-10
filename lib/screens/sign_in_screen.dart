import 'package:chatapp/screens/home_screen.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../app.dart';

class SignInScreeen extends StatefulWidget {
  static Route get route =>
      MaterialPageRoute(builder: (context) => SignInScreeen());

  const SignInScreeen({Key? key}) : super(key: key);

  @override
  State<SignInScreeen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreeen> {
  final auth = firebase.FirebaseAuth.instance;
  final functions = FirebaseFunctions.instance;
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      try {
        final credentials = await firebase.FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        final user = credentials.user;
        if (user == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('User is empty')));
          return;
        }

        final callable = functions.httpsCallable('getStreamUserToken');
        final result = await callable();

        final client = StreamChatCore.of(context).client;
        await client.connectUser(User(id: credentials.user!.uid), result.data);

        await Navigator.of(context).pushReplacement(HomeScreen.route); //them man hinh home o day
      } on firebase.FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? 'Auth error')));
      } catch (e, st) {
        logger.e('Sign in error, ', e, st);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('An error occured')));
      }
      setState(() {
        _loading = false;
      });
    }
  }

  String? _emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!_emailRegex.hasMatch(value)) {
      return "Not a valid email";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length <= 8) {
      return 'Password needs to be longer than 8 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 24),
                        child: Text(
                          'Welcome back',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _emailController,
                          validator: _emailInputValidator,
                          decoration: InputDecoration(hintText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: [AutofillHints.email],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _passwordController,
                          validator: _passwordValidator,
                          decoration: InputDecoration(hintText: 'Password'),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: _signIn,
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have a account?',
                              style: Theme.of(context).textTheme.subtitle2),
                          SizedBox(width: 8),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(SignInScreeen.route);
                              },
                              child: Text('Create account'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
