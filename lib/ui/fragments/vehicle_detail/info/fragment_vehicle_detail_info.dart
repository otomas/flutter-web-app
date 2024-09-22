import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ucg_interactable_svg/interactable_svg/src/widgets/interactable_svg.dart';
import '../../../../core/constants/ui_brightness_style.dart';
import '../../../../core/enums/enum_app.dart';
import '../../../../core/extensions/extension_balance.dart';
import '../../../../core/extensions/extension_date.dart';
import '../../../../core/extensions/extension_iterable.dart';
import '../../../../core/extensions/extension_num.dart';
import '../../../../core/extensions/extension_string.dart';
import '../../../../core/models/model_file.dart';
import '../../../../core/resources/_r.dart';
import '../../../../core/utils/alert_utils.dart';
import '../../../../core/utils/permission_utils.dart';
import '../../../../core/utils/vehicle_svg.dart';
import '../../../base/base_view.dart';
import '../../../widgets/widget_button.dart';
import '../../../widgets/widget_date_selection.dart';
import '../../../widgets/widget_expandable.dart';
import '../../../widgets/widget_expansion_panel.dart';
import '../../../widgets/widget_flexible.dart';
import '../../../widgets/widget_image.dart';
import '../../../widgets/widget_scroll.dart';
import '../../../widgets/widget_sortable_table.dart';
import '../../../widgets/widget_vehicle_detail_bar.dart';
import '../../../widgets/widget_vehicle_detail_card.dart';
import '../../../widgets/widget_vehicle_svg.dart';
import '../../../widgets/widgets_text.dart';
import 'vm_fragment_vehicle_detail_info.dart';

@RoutePage()
class FragmentVehicleDetailInfo extends StatefulWidget {
  const FragmentVehicleDetailInfo({
    @PathParam.inherit('vehicleId') required this.id,
    @QueryParam('branchId') this.branchId,
    super.key,
  });

  final int id;
  final int? branchId;

  @override
  State<FragmentVehicleDetailInfo> createState() => _FragmentVehicleDetailInfoState();
}

class _FragmentVehicleDetailInfoState extends WidgetBaseStatefull<FragmentVehicleDetailInfo, VmFragmentVehicleDetailInfo> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentVehicleDetailInfo createViewModel(BuildContext context) => VmFragmentVehicleDetailInfo(apiService(context), widget.id);

  @override
  Widget buildWidget(BuildContext context, VmFragmentVehicleDetailInfo viewModel) => ScrollWithNoGlowWidget(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getVehicleGeneralInfoCard(context, viewModel),
            const SizedBox(height: 10),
            _getVehicleExpertiseReport(context, viewModel),
            const SizedBox(height: 10),
            _getPhotos(context, viewModel),
            const SizedBox(height: 10),
            _getInsuranceAndInspectionInfo(context, viewModel),
            const SizedBox(height: 10),
            _getPurchasePayments(context, viewModel),
            const SizedBox(height: 10),
            _getBuyingSellingPayments(context, viewModel),
          ],
        ),
      );

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentVehicleDetailInfo viewModel) => buildWidget(context, viewModel);

  Widget _getVehicleGeneralInfoCard(BuildContext context, VmFragmentVehicleDetailInfo viewModel) => WidgetVehicleDetailCard(
        title: 'Genel Bilgiler',
        children: [
          WidgetVehicleDetailBar(
            imageUrl: viewModel.data?.coverPhotoUrl,
            plate: viewModel.data?.plateNumber,
            title: '${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''} ${viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''}',
            subtitle: '${viewModel.data?.vehicleVersion?.vehicleModel?.name ?? ''} ${viewModel.data?.vehicleVersion?.name ?? ''}',
            price: viewModel.data?.price,
            salesPrice: viewModel.data?.salesPrice,
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              IntrinsicHeight(
                child: WidgetFlexible(
                  isRow: isWeb(context),
                  children: [
                    WidgetExpandable(
                      isExpanded: true,
                      child: Column(
                        children: [
                          WidgetValueText(title: 'Oluşturma Tarihi', value: viewModel.data?.createdAt.dayMonthNameAndYear() ?? ''),
                          WidgetValueText(title: 'Marka', value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleBrand?.name ?? ''),
                          WidgetValueText(title: 'Seri', value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.name ?? ''),
                          WidgetValueText(title: 'Model', value: viewModel.data?.vehicleVersion?.vehicleModel?.name ?? ''),
                          WidgetValueText(title: 'Model Yılı', value: viewModel.data?.modelYear?.toString() ?? ''),
                          WidgetValueText(title: 'Yakıt Tipi', value: viewModel.data?.vehicleFuelType?.name ?? ''),
                          WidgetValueText(title: 'Şanzıman Tipi', value: viewModel.data?.vehicleTransmissionType?.name ?? ''),
                          WidgetValueText(title: 'Kilometre', value: viewModel.data?.kilometer.formatPrice() ?? '', isActiveDivider: !isWeb(context)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    if (isWeb(context)) VerticalDivider(color: R.themeColor.borderLight),
                    const SizedBox(width: 30),
                    WidgetExpandable(
                      isExpanded: true,
                      child: Column(
                        children: [
                          WidgetValueText(title: 'Motor Hacmi', value: '${viewModel.data?.engineCapacity.formatPrice()} cm³'),
                          WidgetValueText(title: 'Motor Gücü', value: '${viewModel.data?.enginePower.formatPrice()} hp'),
                          WidgetValueText(title: 'Araç Tipi', value: viewModel.data?.vehicleVersion?.vehicleModel?.vehicleSeries?.vehicleType?.name ?? ''),
                          WidgetValueText(title: 'Kasa Tipi', value: viewModel.data?.vehicleVersion?.name ?? ''),
                          WidgetValueText(title: 'Çekiş Tipi', value: viewModel.data?.vehicleTractionType?.name ?? ''),
                          WidgetValueText(title: 'Şasi Numarası', value: viewModel.data?.chassisNumber ?? ''),
                          WidgetValueText(title: 'Renk', value: viewModel.data?.color ?? '', isActiveDivider: !isWeb(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  Widget _getVehicleExpertiseReport(BuildContext context, VmFragmentVehicleDetailInfo viewModel) => WidgetVehicleDetailCard(
        title: 'Ekspertiz Bilgileri',
        children: [
          IntrinsicHeight(
            child: WidgetFlexible(
              isRow: isWeb(context),
              children: [
                UcgInteractableSvg(
                  key: ValueKey(viewModel.data),
                  svgAddress: vehicleSvg,
                  isActivePadding: false,
                  unSelectableColor: (partId, color) {
                    final item = viewModel.expertiseItems.entries.firstWhereOrNull((e) => e.key.id == partId);
                    if (item != null) {
                      return Color(int.tryParse('0xFF${item.value.color}')!);
                    }
                    return null;
                  },
                  onChanged: (region) {},
                ),
                const SizedBox(width: 20),
                if (isWeb(context)) VerticalDivider(color: R.themeColor.borderLight) else Divider(color: R.themeColor.borderLight),
                const SizedBox(width: 20),
                Expanded(
                  child: WidgetExpertiseLabel(
                    vehicleColorFlawGroups: viewModel.colorFlawGroups,
                    selectedItems: viewModel.expertiseItems,
                  ),
                ),
                const SizedBox(width: 20),
                VerticalDivider(color: R.themeColor.borderLight),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBasic(text: 'Lorem Ipsum', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayBold, fontSize: 18),
                      const SizedBox(height: 10),
                      TextBasic(
                        text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the.",
                        color: R.themeColor.secondaryHover,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _getPhotos(BuildContext context, VmFragmentVehicleDetailInfo viewModel) => WidgetVehicleDetailCard(
        title: 'Fotoğraflar',
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBasic(
                text: 'Aracınızın Fotoğrafları',
                color: R.themeColor.secondary,
                fontFamily: R.fonts.displayMedium,
                fontSize: 16,
              ),
              if (viewModel.checkErrorByField('files'))
                TextBasic(
                  text: viewModel.getErrorMsg('files') ?? '',
                ),
              const SizedBox(height: 20),
              GridView.builder(
                itemCount: viewModel.photos.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.5),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    await showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoTheme(
                        data: const CupertinoThemeData(brightness: Brightness.light),
                        child: CupertinoActionSheet(
                          actions: [
                            // if (!widget.isArchive)
                            CupertinoActionSheetAction(
                              child: const Text('Kapak Fotoğrafı Yap'),
                              onPressed: () {
                                Navigator.pop(context);
                                viewModel.setCoverPhoto(viewModel.photos[index]);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: const Text('Görüntüle'),
                              onPressed: () {
                                Navigator.pop(context);
                                // router(context).startNewView(route: RoutePhoto(urls: viewModel.photos.map((e) => e.url!).toList(), index: index));
                              },
                            ),
                            // if (!widget.isArchive)
                            CupertinoActionSheetAction(
                              child: const Text('Sil'),
                              onPressed: () {
                                Navigator.pop(context);
                                viewModel.deletePhoto(viewModel.photos[index]);
                              },
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            isDefaultAction: true,
                            onPressed: () => Navigator.pop(context),
                            child: Text(R.string.cancel),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: NetworkImageWithPlaceholder(
                      height: 50,
                      width: double.infinity,
                      radius: 12,
                      imageUrl: viewModel.photos[index].url,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    RichTextBasic(
                      texts: '${viewModel.photos.length}/30'.highlightOccurrences(
                        '${viewModel.photos.length}',
                        textColor: R.themeColor.secondary,
                        boldTextColor: R.themeColor.secondary,
                        fontSize: 16,
                        boldFontSize: 16,
                        isOnlyFirst: true,
                      ),
                    ),
                    const Expanded(child: SizedBox(width: 10)),
                    ButtonBasic(
                      onPressed: () async {
                        if (isWeb(context)) {
                          final files = <ModelFile>[];
                          if (await accessGalleryPermission(context)) {
                            final f = await ImagePicker().pickMultiImage();
                            for (final e in f) {
                              files.add(ModelFile(path: File(e.path).path, type: FileType.gallery, byte: await e.readAsBytes()));
                            }
                          }
                          if (files.isNotEmpty) {
                            unawaited(viewModel.addPhoto(files));
                          }
                          return;
                        }
                        final files = await chooseFileSource(context, isActiveFile: false, isActiveVideo: false, isActiveVoice: false);
                        if (files.isNotEmpty) {
                          unawaited(viewModel.addPhoto(files));
                        }
                      },
                      bgColor: R.themeColor.primaryLight,
                      textColor: R.themeColor.primary,
                      child: Row(
                        children: [
                          TextBasic(
                            text: 'Fotoğraf Ekle',
                            color: R.themeColor.primary,
                            fontFamily: R.fonts.displayBold,
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.camera_alt_outlined,
                            color: R.themeColor.primary,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  Widget _getInsuranceAndInspectionInfo(BuildContext context, VmFragmentVehicleDetailInfo viewModel) => WidgetVehicleDetailCard(
        title: 'Sigorta & Muayene',
        children: [
          WidgetFlexible(
            isRow: isWeb(context),
            children: [
              WidgetExpandable(
                isExpanded: isWeb(context),
                child: WidgetDateSelection(
                  title: 'Sigorta Bilgileri',
                  bgColor: R.themeColor.warningLight,
                  titleColor: R.color.orange,
                  selectedStartDate: DateTime.now(),
                  selectedEndDate: DateTime.now(),
                  isPreview: true,
                ),
              ),
              const SizedBox(width: 16),
              WidgetExpandable(
                isExpanded: isWeb(context),
                child: WidgetDateSelection(
                  title: 'Muayene Bilgileri',
                  bgColor: R.themeColor.successLight,
                  titleColor: R.color.river,
                  selectedStartDate: DateTime.now(),
                  selectedEndDate: DateTime.now(),
                  isPreview: true,
                ),
              ),
            ],
          ),
        ],
      );

  Widget _getPurchasePayments(BuildContext context, VmFragmentVehicleDetailInfo viewModel) => WidgetVehicleDetailCard(
        title: 'Satın Alma Ödemeleri',
        children: [
          WidgetSortableTable(
            key: ValueKey(viewModel.data?.purchasePayments?.length),
            titles: const ['Ödeme Tipi', 'Ödeme Yeri', 'Ödeme Tutarı'],
            items: List.generate(viewModel.data?.purchasePayments?.length ?? 0, (index) {
              final item = viewModel.data!.purchasePayments![index];
              return [item.paymentType ?? '-', item.processedBy ?? '-', item.amount.formatPrice()];
            }),
          ),
        ],
      );

  Widget _getBuyingSellingPayments(BuildContext context, VmFragmentVehicleDetailInfo viewModel) => WidgetVehicleDetailCard(
        title: 'Alış & Satış Ödemeleri',
        children: [
          IntrinsicHeight(
            child: WidgetFlexible(
              isRow: isWeb(context),
              children: [
                WidgetExpandable(
                  isExpanded: isWeb(context),
                  child: SizedBox(
                    width: double.infinity,
                    child: IntrinsicWidth(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Row(
                              children: [
                                SvgPicture.asset(R.drawable.svg.iconUserCircle, height: 42, width: 42),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextBasic(text: 'Tedarikiçi', color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 14),
                                      const SizedBox(height: 5),
                                      TextBasic(text: viewModel.data?.supplier?.fullName ?? '-', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayBold, fontSize: 18),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: R.themeColor.borderLight),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Row(
                              children: [
                                SvgPicture.asset(R.drawable.svg.iconUserCircle, height: 42, width: 42),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextBasic(text: 'Alıcı', color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 14),
                                      const SizedBox(height: 5),
                                      TextBasic(text: viewModel.data?.buyer?.fullName ?? '-', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayBold, fontSize: 18),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: R.themeColor.borderLight),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Row(
                              children: [
                                SvgPicture.asset(R.drawable.svg.iconUserCircle, height: 42, width: 42),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextBasic(text: 'Satıcı', color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 14),
                                      const SizedBox(height: 5),
                                      TextBasic(text: viewModel.data?.seller?.fullName ?? '-', color: R.themeColor.secondaryHover, fontFamily: R.fonts.displayBold, fontSize: 18),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                WidgetExpandable(
                  isExpanded: isWeb(context),
                  child: WidgetFlexible(
                    isRow: isWeb(context),
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isWeb(context)) VerticalDivider(color: R.themeColor.borderLight) else Divider(color: R.themeColor.borderLight),
                      WidgetExpandable(
                        isExpanded: isWeb(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextBasic(text: 'Dolar Endeksli Güncel Değeri', color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 14),
                              const SizedBox(height: 5),
                              TextBasic(text: viewModel.data?.currentDollarIndex.formatPrice() ?? '-', color: R.themeColor.primary, fontFamily: R.fonts.displayBold, fontSize: 24),
                            ],
                          ),
                        ),
                      ),
                      if (isWeb(context)) VerticalDivider(color: R.themeColor.borderLight) else Divider(color: R.themeColor.borderLight),
                      WidgetExpandable(
                        isExpanded: isWeb(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextBasic(text: 'Dolar Endeksli Değer Artışı', color: R.themeColor.smoke, fontFamily: R.fonts.displayMedium, fontSize: 14),
                              const SizedBox(height: 5),
                              TextBasic(text: viewModel.data?.dollarIndexedIncrease.formatPrice() ?? '-', color: R.themeColor.primary, fontFamily: R.fonts.displayBold, fontSize: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          WidgetExpansionPanelItem(
            title: 'Satın Alınma Tarihi',
            value: viewModel.data?.purchasedAt.dayMonthNameYearAndMonth(),
            titleFontSize: 12,
            valueFontSize: 12,
            padding: const EdgeInsets.all(10),
            isActiveDivider: false,
          ),
          WidgetExpansionPanelItem(
            title: 'Eklenme Tarihi',
            value: viewModel.data?.createdAt.dayMonthNameYearAndMonth(),
            titleFontSize: 12,
            valueFontSize: 12,
            padding: const EdgeInsets.all(10),
            isActiveDivider: false,
          ),
          WidgetExpansionPanelItem(
            title: 'Güncellenme Tarihi',
            value: viewModel.data?.updatedAt.dayMonthNameYearAndMonth(),
            titleFontSize: 12,
            valueFontSize: 12,
            padding: const EdgeInsets.all(10),
            isActiveDivider: false,
          ),
        ],
      );
}
