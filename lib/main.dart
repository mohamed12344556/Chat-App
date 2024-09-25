import 'package:chat_app/views/ai_chat_screen.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/home_screen.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:chat_app/views/onboarding_screen.dart';
import 'package:chat_app/views/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          routes: {
            OnboardingScreen.id: (context) => const OnboardingScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            RegisterScreen.id: (context) => const RegisterScreen(),
            HomeScreen.id: (context) => const HomeScreen(),
            AiChatScreen.id: (context) => const AiChatScreen(),
            ChatScreen.id: (context) => const ChatScreen(),
          },
          initialRoute: OnboardingScreen.id,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
