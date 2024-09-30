import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/extensions/extension_date.dart';
import '/core/resources/_r.dart';
import '/ui/widgets/widget_button.dart';
import '/ui/widgets/widget_expansion_panel.dart';
import '/ui/widgets/widget_scroll.dart';
import '/ui/widgets/widgets_text.dart';
import '../../core/constants/formatter.dart';
import '../../core/enums/enum_app.dart';
import '../../core/extensions/extension_balance.dart';
import '../../core/models/model_alert_dialog.dart';
import '../../core/models/model_branches.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_firebase.dart';
import '../../core/utils/alert_utils.dart';
import '../../ui/base/base_view.dart';
import '../../ui/base/base_view_model.dart';
import 'bs_add_branch.dart';

class BsBranchDetail extends StatefulWidget {
  const BsBranchDetail({
    required this.id,
    super.key,
  });
  final int id;

  @override
  State<BsBranchDetail> createState() => _BsBranchDetailState();
}

class _BsBranchDetailState extends WidgetBaseStatefull<BsBranchDetail, VmBsBranchDetail> {
  @override
  VmBsBranchDetail createViewModel(BuildContext context) => VmBsBranchDetail(apiService(context), firebaseService(context), widget.id);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsBranchDetail viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsBranchDetail viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsBranchDetail viewModel) => Column(
        children: viewModel.data == null
            ? []
            : [
                _getHeader(context, viewModel),
                const SizedBox(height: 10),
                Expanded(child: ScrollWithNoGlowWidget(child: Column(children: _getInfo(context, viewModel)))),
                const SizedBox(height: 20),
                _getButtons(context, viewModel),
              ],
      );

  Widget _getHeader(BuildContext context, VmBsBranchDetail viewModel) => Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: TextBasic(
                text: R.string.branchDetail,
                fontFamily: R.fonts.displayMedium,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 36,
            width: 36,
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () => Navigator.pop(context),
              child: Icon(Icons.close, color: R.color.white),
            ),
          ),
          const SizedBox(width: 20),
        ],
      );

  List<Widget> _getInfo(BuildContext context, VmBsBranchDetail viewModel) => [
        if (DateTime.now().isAfter(viewModel.data?.licenceExpireDate ?? DateTime.now())) _isLicenceExpired(),
        const SizedBox(height: 20),
        WidgetExpansionPanelItem(title: R.string.name, value: viewModel.data?.name ?? '-'),
        WidgetExpansionPanelItem(title: R.string.country, value: viewModel.data?.neighborhood?.district?.province?.region?.country?.name ?? '-'),
        WidgetExpansionPanelItem(title: R.string.region, value: viewModel.data?.neighborhood?.district?.province?.region?.name ?? '-'),
        WidgetExpansionPanelItem(title: R.string.province, value: '${viewModel.data?.neighborhood?.district?.name ?? '-'}/${viewModel.data?.neighborhood?.district?.name ?? '-'}/${viewModel.data?.neighborhood?.district?.name ?? '-'}'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: R.themeColor.borderLight))),
          child: Row(
            children: [
              TextBasic(
                text: R.string.balance,
                fontSize: 14,
                color: R.themeColor.secondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextBasic(
                  text: viewModel.data?.balance.formatPrice() ?? '-',
                  fontSize: 14,
                  color: (viewModel.data?.balance?.amount ?? 0) <= 0 ? R.color.candy : R.color.river,
                  fontFamily: R.fonts.displayBold,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        WidgetExpansionPanelItem(title: R.string.lastPasswordChangeDate, value: viewModel.data?.updatedAt.dayMonthNameAndYear()),
        WidgetExpansionPanelItem(
          title: R.string.urPhoneNumber,
          value: phoneNumberMask.maskText(viewModel.data?.phone ?? '-'),
        ),
        WidgetExpansionPanelItem(title: R.string.address, value: viewModel.data?.address ?? '-', isActiveDivider: false),
      ];

  Widget _isLicenceExpired() => Container(
        width: size(context).width,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(color: R.themeColor.errorLight, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBasic(
              text: R.string.licenceExpired,
              fontSize: 16,
              color: R.color.candy,
              fontFamily: R.fonts.displayMedium,
            ),
            const SizedBox(height: 5),
            TextBasic(
              text: R.string.pleaseBuyLicence,
              color: R.themeColor.secondary,
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(color: R.color.candy, borderRadius: BorderRadius.circular(12)),
              child: ButtonBasic(
                text: R.string.renewLicenceNow,
                textColor: R.color.white,
              ),
            ),
          ],
        ),
      );

  Widget _getButtons(BuildContext context, VmBsBranchDetail viewModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ButtonBasic(
                    bgColor: R.themeColor.warningLight,
                    textColor: R.color.orange,
                    text: R.string.edit,
                    onPressed: () {
                      unawaited(
                        router(context).showBaseBottomSheet(
                          context,
                          BsAddBranch(
                            id: widget.id,
                            data: viewModel.data,
                            onSuccess: () => viewModel.getData(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ButtonBasic(
                    bgColor: R.themeColor.errorLight,
                    textColor: R.color.candy,
                    text: R.string.delete,
                    onPressed: () {
                      unawaited(
                        showPlatformAlert(
                          context,
                          ModelAlertDialog(
                            description: '${viewModel.data?.name ?? ''} şubesi silinecek onaylıyor musunuz?',
                            isActiveCancelButton: true,
                            dialogType: DialogTypes.confirmation,
                            onPressedButton: () async {
                              if (await viewModel.deleteBranch() && context.mounted) {
                                unawaited(router(context).startNewViewWithPath(route: '/home/branches'));
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

class VmBsBranchDetail extends ViewModelBase {
  VmBsBranchDetail(this.serviceApi, this.serviceFirebase, this.id) {
    init();
  }
  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final int id;

  ModelBranch? data;

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getBranch(id).then(
      (response) {
        data = response.data;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }

  Future<bool> deleteBranch() async {
    var state = false;
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.deleteBranch(data!.id).then(
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
