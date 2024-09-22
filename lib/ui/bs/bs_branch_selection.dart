import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/models/model_branches.dart';
import '../../core/resources/_r.dart';
import '../../core/services/service_api.dart';
import '../../ui/base/base_view.dart';
import '../../ui/base/base_view_model.dart';
import '../../ui/widgets/widget_button.dart';
import '../../ui/widgets/widget_dropdown.dart';
import '../../ui/widgets/widgets_text.dart';

class BsBranchSelection extends StatefulWidget {
  const BsBranchSelection({required this.onSuccess, super.key, this.branchId});
  final int? branchId;
  final Function(ModelBranch selectedBranch) onSuccess;

  @override
  State<BsBranchSelection> createState() => _BsBranchSelectionState();
}

class _BsBranchSelectionState extends WidgetBaseStatefull<BsBranchSelection, VmBsBranchSelection> {
  @override
  VmBsBranchSelection createViewModel(BuildContext context) => VmBsBranchSelection(apiService(context), widget.branchId);

  @override
  SystemUiOverlayStyle? systemBarBrightness() => null;

  @override
  Widget buildWidgetForWeb(BuildContext context, VmBsBranchSelection viewModel) => _getBody(context, viewModel);

  @override
  Widget buildWidget(BuildContext context, VmBsBranchSelection viewModel) => _getBody(context, viewModel);

  Widget _getBody(BuildContext context, VmBsBranchSelection viewModel) => Container(
        margin: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            TextBasic(
              text: 'Lütfen araç eklemek istediğiniz şubeyi seçiniz',
              color: R.themeColor.secondary,
              fontFamily: R.fonts.displayBold,
              fontSize: 20,
            ),
            Container(height: 32),
            DropdownBasic(
              selectedItem: viewModel.selectedBranch,
              // ignore: discarded_futures
              callback: () => apiService(context).client.getBranches(null, null, null),
              onChanged: viewModel.setSelectedBranch,
              title: 'Şube Seçimi',
              hasError: viewModel.isDetectError && viewModel.selectedBranch == null,
              errorLabel: R.string.pleaseSelect,
              hint: 'Seçiniz',
              isRequired: true,
            ),
            Container(height: 20),
            SizedBox(
              width: double.infinity,
              child: ButtonBasic(
                bgColor: R.color.river,
                textColor: R.color.white,
                text: 'Devam Et',
                onPressed: () {
                  if (viewModel.checkFields()) {
                    Navigator.pop(context);
                    widget.onSuccess(viewModel.selectedBranch!);
                  }
                },
              ),
            ),
          ],
        ),
      );
}

class VmBsBranchSelection extends ViewModelBase {
  VmBsBranchSelection(this.serviceApi, this.branchId) {
    init();
  }

  final ServiceApi serviceApi;
  final int? branchId;

  ModelBranch? selectedBranch;

  @override
  void init() {
    if (branchId != null) {
      selectedBranch = ModelBranch(id: branchId!, licenceExpireDate: DateTime.now());
    }
  }

  void setSelectedBranch(ModelBranch? item, bool isAutoComplete) {
    selectedBranch = item;
  }

  bool checkFields() => selectedBranch != null;
}
