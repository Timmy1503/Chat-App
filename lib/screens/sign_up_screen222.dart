// // import 'package:chat_app_firebase/models/user_model.dart';
// // import 'package:chat_app_firebase/screens/conversation_screen.dart';
// // import 'package:chat_app_firebase/services/database.dart';
// //import 'package:fluttertoast/fluttertoast.dart';
// //import 'package:cloud_firestore/cloud_firestore.dart';
// //import 'package:clo';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class SignUpScreen extends StatefulWidget{
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen>{
//   final _auth = FirebaseAuth.instance;
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//   // DatabaseMethods databaseMethods = DatabaseMethods();
//   @override
//   Widget build(BuildContext context) {
//     final nameField = TextFormField(
//       autofocus: false,
//       controller: nameController,
//       keyboardType: TextInputType.name,
//       validator: (value){
//         RegExp regExp = RegExp(r"^.{3,}$");
//         if(value!.isEmpty){
//           return ("Full name cannot be empty");
//         }
//         if(!regExp.hasMatch(value)){
//           return ("Full name needs to be longer than 3 characters");
//         }
//         return null;
//       },
//       onSaved: (value){
//         nameController.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.account_circle),
//           contentPadding: const EdgeInsets.fromLTRB(20,15,20,15),
//           hintText: "Full Name",
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           )
//       ),
//     );
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
//           prefixIcon: const Icon(Icons.mail),
//           contentPadding: const EdgeInsets.fromLTRB(20,15,20,15),
//           hintText: "Email",
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           )
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
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.vpn_key),
//           contentPadding: const EdgeInsets.fromLTRB(20,15,20,15),
//           hintText: "Password",
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           )
//       ),
//     );
//     final confirmPasswordField = TextFormField(
//       autofocus: false,
//       controller: confirmPasswordController,
//       obscureText: true,
//       validator: (value){
//         if(confirmPasswordController.text != passwordController.text){
//           return "Password don't match";
//         }
//         return null;
//       },
//       onSaved: (value){
//         confirmPasswordController.text = value!;
//       },
//       textInputAction: TextInputAction.done,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(Icons.vpn_key),
//           contentPadding: const EdgeInsets.fromLTRB(20,15,20,15),
//           hintText: "Confirm Password",
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           )
//       ),
//     );
//
//     final signUpButton = Material(
//       elevation: 5,
//       borderRadius: BorderRadius.circular(30),
//       color: Colors.redAccent,
//       child: MaterialButton(
//         padding: const EdgeInsets.fromLTRB(20,15,20,15),
//         minWidth: MediaQuery.of(context).size.width,
//         onPressed: (){
//           signUp(emailController.text, passwordController.text);
//
//         },
//         child: const Text("Sign Up",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               fontSize: 20,
//               color: Colors.white,
//               fontWeight: FontWeight.bold
//           ),),
//       ),
//     );
//
//     return Scaffold(
//       backgroundColor: Colors.lightGreenAccent,
//       appBar: AppBar(
//         backgroundColor: Colors.lightGreenAccent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.red),
//           onPressed: (){
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
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
//                     nameField,
//                     const SizedBox(height: 25,),
//                     emailField,
//                     const SizedBox(height: 25,),
//                     passwordField,
//                     const SizedBox(height: 25,),
//                     confirmPasswordField,
//                     const SizedBox(height: 35,),
//                     signUpButton
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
//   void signUp(String email, String password) async{
//     if(_formKey.currentState!.validate()){
//       await _auth.createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) => {
//         postDetailsToFirestore()
//       }).catchError((e){
//         Fluttertoast.showToast(msg: e!.message);
//       });
//     }
//   }
//
//   postDetailsToFirestore() async{
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     User? user = _auth.currentUser;
//     UserModel userModel = UserModel();
//
//     userModel.email = user!.email;
//     userModel.uid = user.uid;
//     userModel.fullName = nameController.text;
//
//     await firebaseFirestore
//         .collection("users")
//         .doc(user.uid)
//     .set(userModel.toMap());
//     Fluttertoast.showToast(msg: "Account created successfully");
//
//     // Map<String, String> userInfo = {
//     //   "fullName": nameController.text,
//     //   "email": emailController.text //can xem lai cho nay
//     // }
//     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ConversationScreen(currentUserId: '',)), (route) => false);
//   }
// }
