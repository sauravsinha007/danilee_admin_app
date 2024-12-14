import 'package:danilee/resources/app_colors.dart';
import 'package:danilee/screens/loading/loading_screen.dart';
import 'package:danilee/screens/login/bloc/login_bloc.dart';
import 'package:danilee/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: AppUIColors.cyan),
        // segmentedButtonTheme: SegmentedButtonThemeData(
        //   style: ButtonStyle(
        //     padding: WidgetStateProperty.all(EdgeInsets.zero),
        //     textStyle: WidgetStateProperty.all(
        //       AppTextStyles.caption.textColor(AppUIColors.darkBlue),
        //     ),
        //   ),
        // ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppUIColors.white,
        ),
        appBarTheme: const AppBarTheme(
          shadowColor: AppUIColors.black,
        ),
        iconTheme: const IconThemeData(color: AppUIColors.white),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const LoadingScreen(),
        '/login': (BuildContext context) => BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc(),
              child: const LoginScreen(),
            ),
      },
    );
  }
}
