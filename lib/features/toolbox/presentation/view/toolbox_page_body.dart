import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/utils/styles.dart';
import '../manager/toolboxPage_cubit.dart';
import 'widgets/toolbox_tool_card.dart';
import 'pages/alarm_page.dart';
import 'pages/music_page.dart';
import 'pages/compass_page.dart';

class ToolboxPageBody extends StatelessWidget {
  const ToolboxPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolboxPageCubit, ToolboxPageState>(
      builder: (context, state) {
        if (state is ToolboxPageLoading || state is ToolboxPageInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ToolboxPageError) {
          return Center(child: Text(state.message));
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الأدوات', style: Styles.style24),
                SizedBox(height: 12.h),
                Text('إدارة أدواتك اليومية بسهولة', style: Styles.style18),
                SizedBox(height: 24.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: 1,
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.grey, thickness: 1),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToolboxToolCard(
                            title: 'المنبه',
                            icon: Icons.alarm,
                            color: Colors.orange,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AlarmPage(),
                              ),
                            ),
                          ),
                          ToolboxToolCard(
                            title: 'الموسيقى',
                            icon: Icons.music_note,
                            color: Colors.purple,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MusicPage(),
                              ),
                            ),
                          ),
                          ToolboxToolCard(
                            title: 'البوصلة',
                            icon: Icons.explore,
                            color: Colors.green,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CompassPage(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
