import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/services/service_api.dart';
import '../../base/base_view_model.dart';

class VmPublicListing extends ViewModelBase {

  VmPublicListing(this.serviceApi) {
    unawaited(init());
  }
  bool rentSelection = true;
  final ServiceApi serviceApi;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();


  void changeRentSelection() {
    rentSelection = !rentSelection;
    notifyListeners();
  }

  @override
  Future<void> init() async {}
}