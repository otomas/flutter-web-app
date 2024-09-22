import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/core/extensions/extension_date.dart';
import '/core/models/model_alert_dialog.dart';
import '/core/models/model_user_info.dart';
import '/core/resources/_r.dart';
import '/core/utils/alert_utils.dart';
import '/ui/widgets/widget_button.dart';
import '/ui/widgets/widget_expansion_panel.dart';
import '/ui/widgets/widget_scroll.dart';
import '/ui/widgets/widgets_text.dart';

import '../../core/enums/enum_app.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_firebase.dart';
import '../../ui/base/base_view.dart';
import '../../ui/base/base_view_model.dart';
import 'bs_add_user.dart';

class BsUserDetail extends StatefulWidget {
  const BsUserDetail({
    required this.id,
    super.key,
  });

  final int id;

  @override
  State<BsUserDetail> createState() => _BsUserDetailState();
}

class _BsUserDetailState extends WidgetBaseStatefull<BsUserDetail, VmBsUserDetail> {
  @override
  VmBsUserDetail createViewModel(BuildContext context) => VmBsUserDetail(apiService(context), firebaseService(context), widget.id);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsUserDetail viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsUserDetail viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsUserDetail viewModel) => Column(
        children: viewModel.data == null
            ? []
            : [
                const SizedBox(height: 40),
                _getHeader(context, viewModel),
                const SizedBox(height: 40),
                Expanded(
                  child: ScrollWithNoGlowWidget(child: Column(children: _getInfo(context, viewModel))),
                ),
                const SizedBox(height: 40),
                _getButtons(context, viewModel),
              ],
      );

  Widget _getHeader(BuildContext context, VmBsUserDetail viewModel) => Column(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: R.themeColor.primaryLight,
            ),
            child: Center(
              child: TextBasic(
                text: (viewModel.data?.firstName ?? '').substring(0, 1),
                color: R.themeColor.primary,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextBasic(
            text: viewModel.data?.fullName ?? '-',
            color: R.themeColor.secondary,
            fontFamily: R.fonts.displayBold,
            fontSize: 24,
          ),
          const SizedBox(height: 5),
          TextBasic(
            text: viewModel.data?.autoGallery?.title ?? '',
            color: R.themeColor.smoke,
            fontFamily: R.fonts.displayMedium,
            fontSize: 18,
          ),
          const SizedBox(height: 5),
          TextBasic(
            text: viewModel.data?.mobileNo ?? '',
            fontSize: 18,
            color: R.themeColor.smoke,
          ),
        ],
      );

  List<Widget> _getInfo(BuildContext context, VmBsUserDetail viewModel) => [
        WidgetExpansionPanelItem(title: R.string.idNo, value: viewModel.data?.citizenNo),
        WidgetExpansionPanelItem(title: R.string.birthDate, value: viewModel.data?.dateOfBirth.dayMonthNameAndYear()),
        WidgetExpansionPanelItem(title: R.string.country, value: viewModel.data?.neighborhood?.district?.province?.region?.country?.name ?? ''),
        WidgetExpansionPanelItem(title: R.string.region, value: viewModel.data?.neighborhood?.district?.province?.region?.name ?? ''),
        WidgetExpansionPanelItem(
          title: R.string.province,
          value: '${viewModel.data?.neighborhood?.district?.province?.name ?? '-'} / ${viewModel.data?.neighborhood?.district?.name ?? '-'} / ${viewModel.data?.neighborhood?.name ?? '-'}',
          isActiveDivider: false,
        ),
        WidgetExpansionPanelItem(title: R.string.lastLoginDate, value: viewModel.data?.dateOfActivity.dayMonthNameAndYear()),
        WidgetExpansionPanelItem(title: R.string.lastPasswordChangeDate, value: viewModel.data?.dateOfLastPasswordChange.dayMonthNameAndYear(), isActiveDivider: false),
      ];

  Widget _getButtons(BuildContext context, VmBsUserDetail viewModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: ButtonBasic(
                  onPressed: () async {
                    await router(context).showBaseBottomSheet(context, BsAddUser(id: viewModel.id, data: viewModel.data));
                    unawaited(viewModel.getData());
                  },
                  bgColor: R.themeColor.infoLight,
                  text: 'Kullanıcıyı Güncelle'.replaceAll(' ', '\n'),
                  textColor: R.themeColor.info,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ButtonBasic(
                  onPressed: () {},
                  bgColor: R.themeColor.warningLight,
                  text: R.string.resetPassword.replaceAll(' ', '\n'),
                  textColor: R.themeColor.warning,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ButtonBasic(
                  onPressed: () async {
                    unawaited(
                      showPlatformAlert(
                        context,
                        ModelAlertDialog(
                          description: 'Kullanıcıyı silmek istediğinize emin misiniz?',
                          isActiveCancelButton: true,
                          onPressedButton: () async {
                            if (await viewModel.deleteUser() && context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          dialogType: DialogTypes.confirmation,
                        ),
                      ),
                    );
                  },
                  bgColor: R.themeColor.errorLight,
                  text: R.string.deleteUser.replaceAll(' ', '\n'),
                  textColor: R.themeColor.error,
                ),
              ),
            ],
          ),
        ),
      );
}

class VmBsUserDetail extends ViewModelBase {
  VmBsUserDetail(this.serviceApi, this.serviceFirebase, this.id) {
    init();
  }

  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final int id;

  ModelUserInfo? data;

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getUser(id).then(
      (response) {
        data = response.data;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  Future<bool> deleteUser() async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.deleteUser(id).then(
      (response) {
        state = true;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
    return state;
  }
}
