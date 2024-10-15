import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/bloc/historyRhyme/history_rhymes_bloc.dart';
import 'package:rhymer/ui/ui.dart';

import '../settings.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            title: Text('Настройки'),
            elevation: 0,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Темная тема',
              value: true,
              onChanged: (value) {},
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Уведомления',
              value: true,
              onChanged: (value) {},
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Разрешить аналитику',
              value: false,
              onChanged: (value) {},
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
              child: SettingsActionCard(
            title: 'Очистить историю',
            icon: Icons.delete_sweep_outlined,
            iconColor: theme.primaryColor,
            onTap: () {
              _clearHistory(context);
            },
          )),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Поддержка',
              icon: Icons.message_outlined,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _clearHistory(BuildContext context) {
    BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
  }
}

class SettingsActionCard extends StatelessWidget {
  const SettingsActionCard({
    super.key,
    required this.title,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  final String title;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
        child: AppContainer(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 18)),
              Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    icon,
                    color: iconColor ?? theme.hintColor.withOpacity(0.3),
                    size: 32,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
