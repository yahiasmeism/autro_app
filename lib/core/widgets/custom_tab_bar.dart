import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key, required this.tabs, this.controller});
  final List<String> tabs;
  final TabController? controller;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController?.removeListener(_handleTabSelection);
    _tabController = widget.controller ?? DefaultTabController.of(context);
    _tabController?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) return const SizedBox();
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 41,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                color: AppColors.secondaryOpacity13,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  widget.tabs.length,
                  (index) {
                    final isSelected = index == _tabController?.index;

                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          _tabController?.animateTo(
                            index,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeOut,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected ? AppColors.primary : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeOut,
                            style: TextStyles.font16Regular.copyWith(
                              color: isSelected ? AppColors.primary : Colors.black,
                            ),
                            child: Text(widget.tabs[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    super.dispose();
  }
}
