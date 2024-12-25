import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/app_auth/app_auth_bloc.dart';
import '../bloc/home_bloc.dart';
import 'drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          final drawerItems = state.appNavMenuItems;
          return Drawer(
            elevation: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const DrawerHeader(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    margin: EdgeInsets.all(0),
                    child: Image(
                      image: AssetImage('assets/images/Tricycle-logo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: drawerItems.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = drawerItems[index];
                            return DrawerItem(
                              item: item,
                              isSelected: state.selectedItem == item,
                              onSelect: (item) {
                                if (scaffoldKey != null) {
                                  scaffoldKey!.currentState?.openEndDrawer();
                                }
                                context.read<HomeBloc>().add(NavigationItemTappedEvent(item: item));
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 100),
                        _buildLogoutButton(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  ListTile _buildLogoutButton(BuildContext context) {
    return ListTile(
      onTap: () async {
        final confirmLogout = await _showLogoutDialog(context);
        if (confirmLogout) {
          if (!context.mounted) return;
          context.read<AppAuthBloc>().add(LogoutAppEvent());
        }
      },
      title: const Text('Logout'),
      leading: const Icon(Icons.logout),
    );
  }

  Future<bool> _showLogoutDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Logout'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
