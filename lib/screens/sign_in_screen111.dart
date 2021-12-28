// import 'package:chat_app_firebase/screens/conversation_screen.dart';
// import 'package:chat_app_firebase/screens/sign_up_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// class SignInScreen extends StatefulWidget{
//   const SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen>{
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   final _auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     final emailField = TextFormField(
//       autofocus: false,
//       controller: emailController,
//       keyboardType: TextInputType.emailAddress,
//       validator: (value){
//         if(value!.isEmpty){
//           return ("Please enter your email");
//         }
//
//         if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
//           return ("Please enter a valid email");
//         }
//         return null;
//       },
//       onSaved: (value){
//         emailController.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.mail),
//         contentPadding: const EdgeInsets.fromLTRB(20,15,20,15),
//         hintText: "Email",
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         )
//       ),
//     );
//     final passwordField = TextFormField(
//       autofocus: false,
//       controller: passwordController,
//       obscureText: true,
//       validator: (value){
//         RegExp regExp = RegExp(r"^.{6,}$");
//         if(value!.isEmpty){
//           return ("Password is required for login");
//         }
//         if(!regExp.hasMatch(value)){
//           return ("Password needs to be longer than 6 characters");
//         }
//       },
//       onSaved: (value){
//         passwordController.text = value!;
//       },
//       textInputAction: TextInputAction.done,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.vpn_key),
//           contentPadding: const EdgeInsets.fromLTRB(20,15,20,15),
//           hintText: "Password",
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           )
//       ),
//     );
//
//     final loginButton = Material(
//       elevation: 5,
//       borderRadius: BorderRadius.circular(30),
//       color: Colors.redAccent,
//       child: MaterialButton(
//         padding: const EdgeInsets.fromLTRB(20,15,20,15),
//         minWidth: MediaQuery.of(context).size.width,
//         onPressed: (){
//           signIn(emailController.text, passwordController.text);
//         },
//         child: const Text("Sign In",
//           textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 20,
//           color: Colors.white,
//           fontWeight: FontWeight.bold
//         ),),
//       ),
//     );
//     return Scaffold(
//       backgroundColor: Colors.lightGreenAccent,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             color: Colors.lightGreenAccent,
//             child: Padding(
//               padding: const EdgeInsets.all(36.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 200,
//                       child: Image.asset("assets/images/chat_app.png",
//                         fit: BoxFit.contain,),
//                     ),
//                     const SizedBox(height: 45,),
//                     emailField,
//                     const SizedBox(height: 25,),
//                     passwordField,
//                     const SizedBox(height: 35,),
//                     loginButton,
//                     const SizedBox(height: 15,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         const Text("Don't have account? "),
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
//                           },
//                           child: const Text(
//                             "SignUp",
//                             style: TextStyle(
//                                 color: Colors.redAccent,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void signIn(String email, String password) async{
//     if(_formKey.currentState!.validate()){
//       await _auth.signInWithEmailAndPassword(email: email, password: password)
//           .then((uid) => {
//             Fluttertoast.showToast(msg: "Sign in successfull"),
//         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ConversationScreen(currentUserId: '',)))
//       }).catchError((e){
//         Fluttertoast.showToast(msg: e!.message);
//       });
//     }
//   }
// }