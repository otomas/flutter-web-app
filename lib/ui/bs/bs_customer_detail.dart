import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '/core/extensions/extension_date.dart';
import '/core/models/model_customer.dart';
import '/core/resources/_r.dart';
import '/core/utils/launch_intent.dart';
import '/ui/widgets/widget_button.dart';
import '/ui/widgets/widget_expansion_panel.dart';
import '/ui/widgets/widget_scroll.dart';
import '/ui/widgets/widgets_text.dart';

import '../../core/enums/enum_app.dart';
import '../../core/services/service_api.dart';
import '../../core/services/service_firebase.dart';
import '../../ui/base/base_view.dart';
import '../../ui/base/base_view_model.dart';
import 'bs_add_customer.dart';

class BsCustomerDetail extends StatefulWidget {
  const BsCustomerDetail({
    required this.id,
    super.key,
  });
  final int id;

  @override
  State<BsCustomerDetail> createState() => _BsCustomerDetailState();
}

class _BsCustomerDetailState extends WidgetBaseStatefull<BsCustomerDetail, VmBsCustomerDetail> {
  @override
  VmBsCustomerDetail createViewModel(BuildContext context) => VmBsCustomerDetail(apiService(context), firebaseService(context), widget.id);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsCustomerDetail viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsCustomerDetail viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsCustomerDetail viewModel) => Column(
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

  Widget _getHeader(BuildContext context, VmBsCustomerDetail viewModel) => Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextBasic(
                text: viewModel.data?.fullName ?? '',
                color: R.themeColor.secondary,
                fontFamily: R.fonts.displayBold,
                fontSize: 24,
              ),
              IconButton(
                onPressed: () async {
                  await router(context).showBaseBottomSheet(
                    context,
                    BsAddCustomer(
                      id: widget.id,
                      data: viewModel.data,
                    ),
                  );
                  unawaited(viewModel.getData());
                },
                icon: SvgPicture.asset(R.drawable.svg.iconEdit, width: 24),
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextBasic(
            text: viewModel.data?.title ?? '',
            color: R.themeColor.smoke,
            fontFamily: R.fonts.displayMedium,
            fontSize: 18,
          ),
          const SizedBox(height: 5),
          TextBasic(
            text: viewModel.data?.mobileNumber ?? '',
            color: R.themeColor.smoke,
            fontFamily: R.fonts.displayMedium,
            fontSize: 18,
          ),
        ],
      );

  List<Widget> _getInfo(BuildContext context, VmBsCustomerDetail viewModel) => [
        WidgetExpansionPanelItem(title: R.string.tcNumber, value: viewModel.data?.citizenNo),
        WidgetExpansionPanelItem(title: R.string.birthDate, value: viewModel.data?.dateOfBirth.dayMonthNameAndYear()),
        WidgetExpansionPanelItem(title: R.string.address, value: viewModel.data?.address),
        WidgetExpansionPanelItem(title: R.string.mobilePhone, value: viewModel.data?.phoneNumber ?? viewModel.data?.mobileNumber),
        WidgetExpansionPanelItem(title: R.string.taxNo, value: viewModel.data?.taxNo, isActiveDivider: false),
        WidgetExpansionPanelItem(title: R.string.region, value: viewModel.data?.neighborhood?.district?.province?.region?.name ?? '-'),
        WidgetExpansionPanelItem(
          title: R.string.province,
          value: '${viewModel.data?.neighborhood?.district?.province?.name ?? '-'} / ${viewModel.data?.neighborhood?.district?.name ?? '-'} / ${viewModel.data?.neighborhood?.name ?? '-'}',
        ),
        WidgetExpansionPanelItem(title: R.string.emailAddress, value: viewModel.data?.email, isActiveDivider: false),
        WidgetExpansionPanelItem(title: R.string.faxNo, value: viewModel.data?.faxNumber, isActiveDivider: false),
      ];

  Widget _getButtons(BuildContext context, VmBsCustomerDetail viewModel) => Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: ButtonBasic(
              onPressed: () => Navigator.pop(context),
              bgColor: R.themeColor.viewBg,
              text: R.string.close,
              textColor: R.themeColor.secondary,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ButtonBasic(
              onPressed: () => unawaited(callPhone(viewModel.data?.phoneNumber ?? viewModel.data?.mobileNumber)),
              text: R.string.callCustomer,
              bgColor: R.themeColor.success,
            ),
          ),
          const SizedBox(width: 20),
        ],
      );
}

class VmBsCustomerDetail extends ViewModelBase {
  VmBsCustomerDetail(this.serviceApi, this.serviceFirebase, this.id) {
    init();
  }
  final ServiceApi serviceApi;
  final ServiceFirebase serviceFirebase;
  final int id;

  ModelCustomer? data;

  @override
  void init() {
    unawaited(getData());
  }

  Future<void> getData() async {
    setActivityState(ActivityState.isLoading);
    await serviceApi.client.getCustomer(id).then(
      (response) {
        data = response.data;
      },
      onError: (error) {
        handleApiError(error);
      },
    );
    setActivityState(ActivityState.isLoaded);
  }
}
