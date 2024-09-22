import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/ui_brightness_style.dart';
import '../../../ui/base/base_view.dart';
import '../../widgets/widgets_text.dart';
import 'vm_fragment_favorites.dart';

@RoutePage()
class FragmentFavorites extends StatefulWidget {
  const FragmentFavorites({super.key});

  @override
  State<FragmentFavorites> createState() => _FragmentFavoritesState();
}

class _FragmentFavoritesState extends WidgetBaseStatefull<FragmentFavorites, VmFragmentFavorites> {
  @override
  SystemUiOverlayStyle systemBarBrightness() => UIBrightnessStyle.getInstance().system();

  @override
  VmFragmentFavorites createViewModel(BuildContext context) => VmFragmentFavorites(apiService(context));

  @override
  Widget buildWidget(BuildContext context, VmFragmentFavorites viewModel) => const Center(child: TextBasic(text: 'favorites'));

  @override
  Widget buildWidgetForWeb(BuildContext context, VmFragmentFavorites viewModel) => buildWidget(context, viewModel);
}
