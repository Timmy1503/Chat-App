import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/home_screen333.dart';
import 'package:chatapp/screens/sign_up_screen.dart';
import 'package:cloud_functions/cloud_functions.dart';
//import 'package:firebase_auth/firebase_auth.dart';
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

  //final auth = firebase.FirebaseAuth.instance;
  //final functions = FirebaseFunctions.instance;

  final _auth = firebase.FirebaseAuth.instance;
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  void signIn(String email, String password) async{
    if(_formKey.currentState!.validate()){
      setState(() {
        _loading = true;
      });
      try{
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        firebase.User? user = _auth.currentUser;
        final client = StreamChatCore.of(context).client;
        await client.connectUser(
            User(
              id: user!.uid,
            ),
            client.devToken(user.uid).rawValue,
        );

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Sign in successfull')));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen333()));
      }on Exception catch (e){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User is empty')));
      };

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
                          onSaved: (value){
                            _emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
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
                          onSaved: (value){
                            _passwordController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            signIn(_emailController.text, _passwordController.text);
                          }, //_signIn,
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
                                Navigator.of(context).push(SignUpScreen.route);
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
