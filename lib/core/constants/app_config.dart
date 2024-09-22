import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/formatters.dart';

const String boxKey = '85383af9c4684bc5e4fd4633042423d658fc518c';
const String errorPropertyActivityActionStateTag = 'activityErrorActionState';
const String errorPropertyMessageTag = 'errorMessage';
const String alertPropertyTag = 'alertProperty';

const String clientId = '8405ad7a-3db6-458b-9c2a-008bd8d6f5f6';
const String clientSecret = '0MmKCuHM4DutaurlbxJTbV3dEb30Zo9NdFdkJwM4';

const List<String> allowedExtensions = ['pdf'];

const List<int> pageSizeList = [10, 25, 50, 100]; 

Future<String> appFiledir() async => Platform.isAndroid ? '/storage/emulated/0/Download' : (await getApplicationDocumentsDirectory()).path;

const unAuthRequestEndpoints = [
  '/system/devices',
  '/Device/{id}',
  '/user/oauth/token',
  '/user/auth/password/forgot',
  '/common/countries',
  '/common/countries/{countryId}/provinces',
  '/common/provinces',
  '/common/provinces/{cityId}/districts',
  '/common/districts/{districtId}/neighborhoods',
];

final inputDecimalFormatter = [DecimalFormatter(), FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d+)*$'))];
