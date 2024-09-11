import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sales_tracker/data/local/local_auth_provider.dart';
import 'package:sales_tracker/data/model/user_model.dart';
import 'package:sales_tracker/data/porvider/auth_provider.dart';
import 'package:sales_tracker/data/porvider/event_provider.dart';
import 'package:sales_tracker/data/porvider/login_provider.dart';
import 'package:sales_tracker/data/porvider/registration_provider.dart';
import 'package:sales_tracker/pages/splash_screen/view/splash_screen.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  // Get the application documents directory
  final document = await getApplicationDocumentsDirectory();
  final hivePath = document.path;
  
  // Delete the Hive directory to clear all data
  final hiveDirectory = Directory(hivePath);
  if (await hiveDirectory.exists()) {
    await hiveDirectory.delete(recursive: true);
  }

  // Reinitialize Hive
  Hive.init(hivePath);
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(userBoxName);

  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BN'),
        Locale('ar', 'AR')
      ],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<LocalAutProvider>(
            create: (context) => LocalAutProvider()),
        ChangeNotifierProvider<RegistrationProvider>(
            create: (context) => RegistrationProvider()),
        ChangeNotifierProvider<EventsProvider>(
            create: (context) => EventsProvider(context)),
            
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              title: 'Event Management',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                textTheme: GoogleFonts.manropeTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              home: const SplashScreen(),
              builder: (ctx, child) {
                child = FlutterEasyLoading(child: child);
                return child;
              },
            );
          }),
    );
  }
}
