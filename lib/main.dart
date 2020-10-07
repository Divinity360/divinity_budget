import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './providers/labels.dart';
import './providers/transactions.dart';
import './screens/home_tabs_screen.dart';
import './screens/edit_labels_screen.dart';
import './screens/onboarding.dart';
import './utils/db_helper.dart';

Future<void> main() async {

  // Needed for onboarding.
  WidgetsFlutterBinding.ensureInitialized();
  final isOnboarded = await DBHelper.isOnboarded();

  runApp(MyApp(isOnboarded: isOnboarded));
}

class MyApp extends StatelessWidget {
  final bool isOnboarded;

  const MyApp({
    @required this.isOnboarded,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Transactions(),
        ),
        ChangeNotifierProvider(
          create: (_) => Labels(),
        ),
      ],
      child: MaterialApp(
        title: 'Divinity Budget',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepPurpleAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme(),
          // This page transition looks better than the default.
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        initialRoute: isOnboarded ? '/' : Onboarding.routeName,
        home: HomeTabsScreen(),
        routes: {
          EditLabelsScreen.routeName: (_) => EditLabelsScreen(),
          Onboarding.routeName: (_) => Onboarding()
        },
      ),
    );
  }
}
