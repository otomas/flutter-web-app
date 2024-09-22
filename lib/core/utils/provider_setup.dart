import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../services/service_api.dart';
import '../services/service_app.dart';
import '../services/service_device_info.dart';
import '../services/service_firebase.dart';
import '../services/service_route.dart';
import 'general_data.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => ServiceApp()),
  ChangeNotifierProvider(create: (context) => ServiceDeviceInfo()),
  ChangeNotifierProvider(create: (context) => ServiceFirebase(Provider.of<ServiceDeviceInfo>(context, listen: false))),
  ChangeNotifierProvider(create: (context) => ServiceRoute(Provider.of<ServiceFirebase>(context, listen: false))),
  ChangeNotifierProvider(create: (context) => ServiceApi(GeneralData.getInstance().getAuthToken(), GeneralData.getInstance().getTaxNumber(), Provider.of<ServiceFirebase>(context, listen: false))),
];
