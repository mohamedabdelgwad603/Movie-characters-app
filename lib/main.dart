// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:breaking_bad_app/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(BreakingBadApp(
    appRoutes: AppRoutes(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({
    Key? key,
    required this.appRoutes,
  }) : super(key: key);
  final AppRoutes appRoutes;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRoutes.onGenerateRoute,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
