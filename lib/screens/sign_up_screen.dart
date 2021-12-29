import 'package:chatapp/app.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SignUpScreen extends StatefulWidget {
  static Route get route =>
      MaterialPageRoute(builder: (contex) => SignUpScreen());

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = firebase.FirebaseAuth.instance;
  final functions = FirebaseFunctions.instance;

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _profilePictureController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // Future<void> _signUp() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _loading = true;
  //     });
  //     try {
  //       final credentials = await firebase.FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(
  //               email: _emailController.text,
  //               password: _passwordController.text);
  //       final user = credentials.user;
  //       if (user == null) {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text('User is empty')));
  //         return;
  //       }
  //
  //       List<Future<void>> future = [
  //         credentials.user!.updateDisplayName(_nameController.text),
  //         if (_profilePictureController.text.isNotEmpty)
  //           credentials.user!.updatePhotoURL(_profilePictureController.text)
  //       ];
  //
  //       await Future.wait(future);
  //
  //       final callable = functions.httpsCallable('createStreamUserAndGetToken');
  //       final result = await callable();
  //       final client = StreamChatCore.of(context).client;
  //       await client.connectUser(
  //           User(
  //               id: credentials.user!.uid,
  //               name: _nameController.text,
  //               image: _profilePictureController.text),
  //           result.data);
  //
  //       await Navigator.of(context).pushReplacement(HomeScreen.route);
  //     } on firebase.FirebaseAuthException catch (e) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text(e.message ?? 'Auth error')));
  //     } catch (e, st) {
  //       logger.e('Sign up error', e, st);
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('An error occured')));
  //     }
  //     setState(() {
  //       _loading = false;
  //     });
  //   }
  // }

  void signUp(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
        postDetailsToFirestore()
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebase.User? user = auth.currentUser;
    UserModel userModel = UserModel(
        uid: user!.uid,
        email: _emailController.text,
        name: _nameController.text,
        image: _profilePictureController.text);

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreeen()), (route) => false);
  }

  String? _nameInputValidatior(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? _emailInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Not a valid email';
    }
    return null;
  }

  String? _passwordInputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length <= 8) {
      return 'Password needs to be longer than 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _profilePictureController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: (_loading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 24, bottom: 24),
                child: Text(
                  'Register', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                ),
                ),
                Padding(padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  validator: _nameInputValidatior,
                  decoration: InputDecoration(hintText: 'Name'),
                  keyboardType: TextInputType.name,
                  autofillHints: [
                    AutofillHints.name,
                    AutofillHints.username
                  ],
                ),
                ),
                Padding(padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _profilePictureController,
                  decoration: InputDecoration(hintText: 'Picture URL'),
                  keyboardType: TextInputType.url,
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: _emailInputValidator,
                    decoration: const InputDecoration(hintText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0),
                child: TextFormField(controller: _passwordController,
                validator: _passwordInputValidator,
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                ),
                ),
                Padding(padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed:() {
                    signUp(_emailController.text, _passwordController.text);
                  }, //_signIn,
                  child: Text('Sign up'),
                ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical:  5.0),
                child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style: Theme.of(context).textTheme.subtitle2),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
