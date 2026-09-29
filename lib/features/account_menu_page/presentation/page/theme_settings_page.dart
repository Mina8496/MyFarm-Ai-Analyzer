import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/theme/theme_controller.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ThemeController>();
    final scheme = Theme.of(context).colorScheme;

    final options = <_ThemeOption>[
      _ThemeOption(
        mode: ThemeMode.system,
        icon: Icons.brightness_auto_rounded,
        title: 'تلقائي',
        subtitle: 'يتبع إعدادات الجهاز',
      ),
      _ThemeOption(
        mode: ThemeMode.light,
        icon: Icons.light_mode_rounded,
        title: 'فاتح',
        subtitle: 'خلفية فاتحة دائمًا',
      ),
      _ThemeOption(
        mode: ThemeMode.dark,
        icon: Icons.dark_mode_rounded,
        title: 'داكن',
        subtitle: 'خلفية داكنة تريح العين ليلًا',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('المظهر'), centerTitle: true),
      body: Obx(() {
        final current = c.mode.value;

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: options.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final o = options[i];
            final selected = current == o.mode; 
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => c.setMode(o.mode),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: selected
                      ? scheme.primary.withValues(alpha: 0.12)
                      : scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  border: Border.all(
                    color: selected ? scheme.primary : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(o.icon, color: selected ? scheme.primary : null),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            o.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            o.subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: scheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selected)
                      Icon(Icons.check_circle_rounded, color: scheme.primary),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _ThemeOption {
  final ThemeMode mode;
  final IconData icon;
  final String title;
  final String subtitle;
  const _ThemeOption({
    required this.mode,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
