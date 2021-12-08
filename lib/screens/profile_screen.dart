

import 'package:chatapp/app.dart';
import 'package:chatapp/widgets/icon_buttons.dart';


import 'package:firebase_auth/firebase_auth.dart' as firebase ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';


// class profile_screen extends StatelessWidget {
//   // static Route get router => MaterialPageRoute(builder: builder)=> const profile_screen(),);
//   const profile_screen({Key? key}): super(key: key);
//
//  @override
//   Widget build(BuildContext) {
//    var context;
//    final user = context.currentUser;
//    var arrow_back_ios_new;
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Profile'),
//        leading: Center(
//          child: IconBackground(
//             icon: Icon.arrow_back_ios_new,
//            onTap: () {
//              Navigator.of(context).pop();
//            },
//          ),
//        ),
//    ),
//  }
//
//
//  }
//    // body: Center(
//    // child: Column(
//    //   children: [
//    //     Hero(
//    // tag: 'hero-profile-picture',
//    // child: Avatar.large(url: user?.image),
//    // ),
//    // Padding(
//    //    padding: const EdgeInsets.all(8.0),
//    //    child: Text(user?.name ?? 'No name'),
//    // ),
//    // const Divider(),
//    // const _SignOutButton(),
//    //      ],
//
//
//
//        }
//
//     abstract class _SignOutButton extends StatelessWidget{
//         const _SignOutButton({
//           Key? key,
//         }): super(key: key);
//         @override
//       _SignOutButtonState createState()=> _SignOutButtonState();
//     }
//
//     class _SignOutButtonState extends State<_SignOutButton>{
//          bool _loading = false;
//
//          Future<void> _signOut() async {
//            setState(() {
//              _loading = true;
//            });
//
//            try{
//              await StreamChatCore.of(context).client.disconnectUser();
//              await firebase.FirebaseAuth.instance.signOut();
//
//              var SplashScreen;
//              Navigator.of(context).pushReplacement(SplashScreen.route);
//            } on Exception catch (e, st) {
//              logger.e('Could not sign out', e, st);
//              setState(() {
//                _loading = false;
//              });
//            }
//          }
//          @override
//          Widget build(BuildContext context){
//            return _loading
//                ? const CircularProgressIndicator()
//                : TextButton(
//              onPressed: _signOut,
//              child: const Text('Sign out'),
//            );
//          }
//
// }
//

