import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/core/theme/app_colors.dart';
import 'package:kornia/core/widgets/app_dialog.dart';
import 'package:kornia/features/gospel/presentation/gospel_notifier.dart';
import 'package:kornia/features/gospel/presentation/widgets/week_day_selector.dart';
import 'package:kornia/features/gospel/utils.dart';

class GospelScreen extends ConsumerWidget {
  const GospelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gospelState = ref.watch(gospelNotifierProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F3),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Color(0xFFFCF9F3),
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,

              floating: true,
              snap: true,
              pinned: false,

              title: Text(
                'Evangelio del Día',
                textAlign: TextAlign.left,
                style: TextStyle(color: AppColors.darkBackground, fontSize: 20),
              ),
              actions:  [
                Icon(
                  Icons.calendar_month_sharp,
                  color: AppColors.sandDark,
                  size: 20,
                ),
                SizedBox(width: 12),
                Icon(Icons.headphones, color: AppColors.sandDark, size: 20),
                SizedBox(width: 12),
                Icon(Icons.person, color: AppColors.sandDark, size: 20),
                SizedBox(width: 16),
              ],
            ),

            SliverAppBar(
              backgroundColor: const Color(0xFFFCF9F3),
              elevation: 0,
              primary:
                  false, 
              automaticallyImplyLeading: false,
              pinned: true, 
              floating: false,
              toolbarHeight: 160,
              title: Container(
                width: size.width,
                color: const Color(0xFFFCF9F3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '● Tiempo de cuaresma • CICLO B',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.sandDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Utils.formatDateForUi(DateTime.now()),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.darkBackground,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    WeekDaySelector(
                      selectedDate: DateTime.now(),
                      onDateSelected: (selectedDate) {
                        
                      },
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  spacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: gospelState.when(
                        data: (gosple) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gosple.title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.bronzeGold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                gosple.content,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.deepEarth,
                                ),
                              ),
                            ],
                          );
                        },
                        error: (error, stackTrace) =>
                            Center(child: Text('Error: $error')),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    ElevatedButton.icon(
                      label: const Text('Compartir'),
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        AppDialog.show(
                          context,
                          title: 'Próximamente',
                          message:
                              'Esta funcionalidad de compartir estará disponible muy pronto.',
                          confirmText: 'Entendido',
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
