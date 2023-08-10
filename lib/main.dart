import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortly/components/themes/app_theme.dart';
import 'package:shortly/screens/welcome_page/welcome_page.dart';
import 'package:shortly/services/short_link_service.dart';
import 'package:shortly/shared/routes.dart';

void main() {
  runApp(MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
   MyApp({super.key, });
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShortLinkService>(
            create: (context) => ShortLinkService()),
      ],
      child: MaterialApp(
        title: 'Shortly',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        navigatorKey: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}