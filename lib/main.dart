import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paged_datatable/l10n/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/constants/app_config.dart';
import 'core/enums/enum_app.dart';
import 'core/models/model_flavor.dart';
import 'core/resources/_r.dart';
import 'core/services/router/router.dart';
import 'core/services/service_json_mapper_context.dart';
import 'core/services/service_notification.dart';
import 'core/services/service_route.dart';
import 'core/settings/controller_language.dart';
import 'core/utils/flavor_config.dart';
import 'core/utils/general_data.dart';
import 'core/utils/provider_setup.dart';
import 'firebase_options.dart';
import 'main.reflectable.dart';
import 'ui/base/base_view.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      FlavorConfig(
        flavorName: Flavor.prod.value,
        values: const ModelFlavor(
          baseUrl: 'https://test.api.otomas.app',
          fileUrl: 'https://test.api.otomas.app',
          appName: 'Otomas',
        ),
      );

      initializeReflectable();

      setPathUrlStrategy();

      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      await Hive.initFlutter();
      GeneralData.getInstance().hive = await Hive.openBox(boxKey);

      await LanguageController.initialize();
      if (!kIsWeb) {
        await ServiceNotification.configure();
      }
      ServiceJsonMapperContext();

      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: R.color.transparent, systemNavigationBarColor: R.color.transparent));

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

      runApp(const MyApp());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

class MyApp extends StatelessWidget with BaseView {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: providers,
        child: Builder(
          builder: (context) {
            router(context);
            final obs = <NavigatorObserver>[RooterObserver()];
            return MaterialApp.router(
              scaffoldMessengerKey: ServiceRoute.scaffoldMessengerKey,
              routerConfig: ServiceRoute.rootRouter.config(
                navigatorObservers: () => obs,
                deepLinkTransformer: (uri) async {
                  log(uri.path, name: 'ROUTE');
                  // if (uri.path.contains('vehicle-create-')) {
                  //   DeepLink([RouteVehicleDetail(vehicleId: 300)]);
                  // }
                  return SynchronousFuture(uri);
                },
                // }
              ),
              theme: ThemeData(
                useMaterial3: false,
                scaffoldBackgroundColor: R.color.white,
                fontFamily: R.fonts.displayRegular,
                primarySwatch: R.color.primarySwatch,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                bottomSheetTheme: BottomSheetThemeData(backgroundColor: R.color.transparent),
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  },
                ),
              ),
              debugShowCheckedModeBanner: false,
              supportedLocales: LanguageController.supportedLocales,
              localizationsDelegates: const [
                PagedDataTableLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (_, router) => firebaseService(context).isProd ? router! : FlavorBanner(child: router!),
            );
          },
        ),
      );
}
