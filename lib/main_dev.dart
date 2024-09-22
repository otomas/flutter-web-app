import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/constants/app_config.dart';
import 'core/enums/enum_app.dart';
import 'core/models/model_flavor.dart';
import 'core/resources/_r.dart';
import 'core/services/service_json_mapper_context.dart';
import 'core/services/service_notification.dart';
import 'core/settings/controller_language.dart';
import 'core/utils/flavor_config.dart';
import 'core/utils/general_data.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'main.reflectable.dart';

Future<void> main() async {
  FlavorConfig(
    flavorName: Flavor.dev.value,
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
}
