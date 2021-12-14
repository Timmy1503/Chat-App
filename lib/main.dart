import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/select_user_screen.dart';
import 'package:chatapp/screens/sign_in_screen.dart';
import 'package:chatapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/screens/chat_screen.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final client = StreamChatClient(streamKey);

  runApp(MyApp(client: client, appTheme: AppTheme()));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final AppTheme appTheme;

  const MyApp({Key? key, required this.client, required this.appTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: 'Chat App',
      builder: (context, child) {
        return StreamChatCore(
            client: client,
            child: ChannelsBloc(
              child: UsersBloc(
                child: child!,
              ),
            )
        );
      },
      home: SelectUserScreen(),
      //rgrtre

    
    );
  }
}
