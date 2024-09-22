import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../core/resources/_r.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widget_button.dart';
import '../../widgets/widget_scroll.dart';
import '../../widgets/widget_textfield.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_my_account.dart';

@RoutePage()
class FragmentMyAccount extends StatefulWidget {
  const FragmentMyAccount({super.key});

  @override
  State<FragmentMyAccount> createState() => _FragmentMyAccountState();
}

class _FragmentMyAccountState extends WidgetBaseStatefull<FragmentMyAccount, VmFragmentMyAccount> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentMyAccount createViewModel(BuildContext context) => VmFragmentMyAccount(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentMyAccount viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentMyAccount viewModel) => buildWidget(context, viewModel);

  Widget _getBody(BuildContext context, VmFragmentMyAccount viewModel) => ScrollWithNoGlowWidget(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (!viewModel.isEditable) _getHeader(context, viewModel),
            if (!viewModel.isEditable) const SizedBox(height: 32),
            _getEstablishmentField(context, viewModel),
            const SizedBox(height: 20),
            _getCompanyFields(context, viewModel),
            const SizedBox(height: 20),
            _getAuthNameField(context, viewModel),
            const SizedBox(height: 20),
            _getContactFields(context, viewModel),
            const SizedBox(height: 20),
            _getTaxFields(context, viewModel),
            const SizedBox(height: 20),
          ],
        ),
      );

  Widget _getHeader(BuildContext context, VmFragmentMyAccount viewModel) => Column(
        children: [
          Row(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(shape: BoxShape.circle, color: R.themeColor.primaryLight),
                child: Center(
                  child: TextBasic(
                    text: viewModel.authorizedNameController.text.substring(0, 1).toUpperCase(),
                    color: R.themeColor.primary,
                    fontSize: 34,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBasic(
                    text: viewModel.authorizedNameController.text,
                    fontSize: 18,
                    fontFamily: R.fonts.displayBold,
                  ),
                  const SizedBox(height: 5),
                  const ButtonPremium(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBasic(
                text: 'Profil Bilgileri',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: R.themeColor.smokeDark,
              ),
              ButtonBasic(
                onPressed: () => viewModel.edit(),
                bgColor: R.themeColor.primaryLight,
                textColor: R.themeColor.primary,
                child: Row(
                  children: [
                    Expanded(
                      child: TextBasic(
                        text: R.string.editProfile,
                        color: R.themeColor.primary,
                        fontSize: 14,
                        fontFamily: R.fonts.displayBold,
                      ),
                    ),
                    SvgPicture.asset(R.drawable.svg.iconEdit),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );

  Widget _getEstablishmentField(BuildContext context, VmFragmentMyAccount viewModel) => _getViewField(title: R.string.establishment, controller: viewModel.establishmentController, isEnabled: viewModel.isEditable);

  Widget _getCompanyFields(BuildContext context, VmFragmentMyAccount viewModel) => Row(
        children: [
          Expanded(child: _getViewField(title: R.string.createdDate, controller: viewModel.corporationCreatedDateController, isEnabled: viewModel.isEditable)),
          const SizedBox(width: 10),
          Expanded(child: _getViewField(title: R.string.companyEmail, controller: viewModel.corporationEmailController, isEnabled: viewModel.isEditable)),
        ],
      );

  Widget _getAuthNameField(BuildContext context, VmFragmentMyAccount viewModel) => _getViewField(title: R.string.authName, controller: viewModel.authorizedNameController, isEnabled: viewModel.isEditable);

  Widget _getContactFields(BuildContext context, VmFragmentMyAccount viewModel) => Row(
        children: [
          Expanded(child: _getViewField(title: R.string.mobilePhone, controller: viewModel.mobilePhoneController, isEnabled: viewModel.isEditable)),
          const SizedBox(width: 10),
          Expanded(child: _getViewField(title: R.string.emailAddress, controller: viewModel.authorizedEmailController, isEnabled: viewModel.isEditable)),
        ],
      );

  Widget _getTaxFields(BuildContext context, VmFragmentMyAccount viewModel) => Row(
        children: [
          Expanded(child: _getViewField(title: R.string.taxOffice, controller: viewModel.taxOfficeController, isEnabled: viewModel.isEditable)),
          const SizedBox(width: 10),
          Expanded(child: _getViewField(title: R.string.taxNo, controller: viewModel.taxNoController, isEnabled: viewModel.isEditable)),
        ],
      );

  Widget _getViewField({required String title, required TextEditingController controller, required bool isEnabled}) => Column(
        children: [
          TextFieldBasic(
            enabled: isEnabled,
            title: title,
            borderColor: R.color.transparent,
            controller: controller,
            contentPaddingVertical: 0,
            contentPaddingHorizontal: 0,
            textColor: R.themeColor.secondary,
            fontSize: 14,
            isDense: true,
          ),
          Divider(height: 1, color: R.themeColor.border),
        ],
      );
}
