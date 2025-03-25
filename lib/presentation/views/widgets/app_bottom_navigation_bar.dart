import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kabar/presentation/resources/colors.dart';
import 'package:kabar/presentation/resources/styles.dart';
import 'package:kabar/shared/extensions/context_extensions.dart';

class AppBottomNavigationItem {
  AppBottomNavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });

  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final PageRouteInfo page;
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
  });

  final List<AppBottomNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;

  @override
  Widget build(BuildContext context) {
    final _unSelectedTextStyle = unSelectedTextStyle ??
        AppStyles.textSmall
            .copyWith(color: AppColors.secondaryBackgroundColors);
    final _selectedTextStyle = selectedTextStyle ??
        _unSelectedTextStyle.copyWith(
          fontWeight: FontWeight.w500,
          color: context.themeOwn().colorSchema?.primary,
        );
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(-5, 5),
            color: const Color(0xFFAEAEC0).withAlpha((0.5 * 255).round()),
            blurRadius: 20,
          )
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
        //borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Material(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: _BottomNavigationTile(
            items: items,
            currentIndex: currentIndex,
            onTap: onTap,
            selectedTextStyle: _selectedTextStyle,
            unSelectedTextStyle: _unSelectedTextStyle,
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
  });

  final List<AppBottomNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items
          .asMap()
          .map(
            (i, e) => MapEntry(
              i,
              Expanded(
                child: _Tile(
                  item: e,
                  isSelected: i == currentIndex,
                  onTap: () => onTap?.call(i),
                  selectedTextStyle: selectedTextStyle,
                  unSelectedTextStyle: unSelectedTextStyle,
                ),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
  });

  final AppBottomNavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          if (isSelected) item.selectedIcon else item.icon,
          const SizedBox(height: 8),
          Text(
            item.label,
            style: isSelected ? selectedTextStyle : unSelectedTextStyle,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
