// import 'package:flutter/material.dart';

// import 'src/app.dart';
// import 'src/settings/settings_controller.dart';
// import 'src/settings/settings_service.dart';

// void main() async {
//   // Set up the SettingsController, which will glue user settings to multiple
//   // Flutter Widgets.
//   final settingsController = SettingsController(SettingsService());

//   // Load the user's preferred theme while the splash screen is displayed.
//   // This prevents a sudden theme change when the app is first displayed.
//   await settingsController.loadSettings();

//   // Run the app and pass in the SettingsController. The app listens to the
//   // SettingsController for changes, then passes it further down to the
//   // SettingsView.
//   runApp(MyApp(settingsController: settingsController));
// }

// ignore: depend_on_referenced_packages
import 'package:ml_product_recommendation/database/db.dart';
import 'package:ml_product_recommendation/modules/product_list/product_list_controller.dart';
import 'package:ml_product_recommendation/modules/product_list/product_list_view.dart';
import 'package:ml_product_recommendation/utils/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      color: Color(0xFFDB3022),
      foregroundColor: Color(0xFF222222),
    ),
    // canvasColor set to transparent to make a showModalBottomSheet clipping the background
    canvasColor: Colors.transparent,
    fontFamily: 'Metropolis',
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          (const Color(0xFF222222)),
        ),
      ),
    ),
    primaryColor: const Color(0xFF222222),
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          (const Color(0xFF222222)),
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF222222),
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF222222),
      ),
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive (db)
  await DB.init();

  final MyApp myApp = MyApp(
    initialRoute: ProductListView.routeName,
  );
  runApp(myApp);
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.initialRoute});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductListController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        // onGenerateRoute: AppRouter.onGenerateRoute,
        routes: Routes.items,
        home: const ProductListView(),
        navigatorKey: navigatorKey,
        theme: themeData(),
      ),
    );
  }
}
