import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key, required this.tabs});
  final List<String> tabs;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with TickerProviderStateMixin {
  final List<GlobalKey> _tabKeys = [];
  double _indicatorPosition = 0.0;
  double _indicatorWidth = 0.0;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.tabs.length; i++) {
      _tabKeys.add(GlobalKey());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _tabController?.removeListener(_handleTabSelection);
    _tabController = DefaultTabController.of(context);
    _tabController?.addListener(_handleTabSelection);

    if (_tabController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _updateIndicatorPosition(_tabController!.index);
        }
      });
    }
  }

  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      _updateIndicatorPosition(_tabController!.index);
    }
  }

  void _updateIndicatorPosition(int index) {
    if (!mounted || _tabKeys[index].currentContext == null) return;

    final RenderBox tabBox = _tabKeys[index].currentContext!.findRenderObject() as RenderBox;
    final position = tabBox.localToGlobal(Offset.zero);
    final containerBox = context.findRenderObject() as RenderBox;
    final containerPosition = containerBox.localToGlobal(Offset.zero);

    setState(() {
      _indicatorPosition = position.dx - containerPosition.dx;
      _indicatorWidth = tabBox.size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null) return const SizedBox();

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 40,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: const Divider(
                height: 0,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.tabs.length,
              (index) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    key: _tabKeys[index],
                    onTap: () {
                      _updateIndicatorPosition(index);
                      _tabController?.animateTo(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 150),
                        style: TextStyles.font16Regular.copyWith(
                          color: index == _tabController?.index ? AppColors.primary : Colors.black,
                        ),
                        child: Text(widget.tabs[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.fastOutSlowIn,
              transform: Matrix4.translationValues(_indicatorPosition, 0, 0),
              width: _indicatorWidth,
              height: 2,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    super.dispose();
  }
}
