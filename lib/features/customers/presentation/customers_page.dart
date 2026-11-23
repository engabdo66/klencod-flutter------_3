import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/search_field.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final _searchController = TextEditingController();

  // بيانات وهمية للعرض (لاحقاً ستأتي من Drift/Riverpod)
  final List<Map<String, dynamic>> _customers = [
    {'name': 'أحمد محمد', 'phone': '0912345678', 'balance': 1500.0},
    {'name': 'سارة علي', 'phone': '0923456789', 'balance': -3200.0},
    {'name': 'خالد عمر', 'phone': '0934567890', 'balance': 0.0},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('العملاء'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.archive_outlined),
            onPressed: () {
              // الانتقال إلى الأرشيف
            },
            tooltip: 'الأرشيف الشهري',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            // === صف البطاقات الإحصائية ===
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'إجمالي العملاء',
                    value: '${_customers.length}',
                    icon: Icons.people_outline,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: StatCard(
                    title: 'إجمالي المستحقات',
                    value: '15,200 ر.س', // مثال
                    icon: Icons.account_balance_wallet_outlined,
                    iconColor: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // === حقل البحث ===
            SearchField(
              controller: _searchController,
              onChanged: (value) {
                // تصفية القائمة (لاحقاً)
              },
            ),
            const SizedBox(height: AppSpacing.lg),

            // === قائمة العملاء ===
            Expanded(
              child: ListView.separated(
                itemCount: _customers.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final customer = _customers[index];
                  final balance = customer['balance'] as double;
                  final isOwedToUs = balance > 0;
                  final isOwedByUs = balance < 0;

                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors.border),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.gold.withOpacity(0.1),
                        child: Text(
                          customer['name'].substring(0, 1),
                          style: TextStyle(
                            color: AppColors.gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        customer['name'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        customer['phone'] ?? 'لا يوجد هاتف',
                        style: theme.textTheme.bodySmall,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${balance.abs().toStringAsFixed(0)} ر.س',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isOwedToUs
                                  ? AppColors.danger
                                  : isOwedByUs
                                      ? AppColors.success
                                      : theme.colorScheme.onSurface,
                              fontFeatures: const [FontFeature.tabularFigures()],
                            ),
                          ),
                          Text(
                            isOwedToUs
                                ? 'مستحق لنا'
                                : isOwedByUs
                                    ? 'له عندنا'
                                    : 'مُسدد',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        // الانتقال إلى ملف العميل
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // إضافة عميل جديد
        },
        icon: const Icon(Icons.add),
        label: const Text('عميل جديد'),
        backgroundColor: AppColors.gold,
        foregroundColor: Colors.black87,
      ),
    );
  }
}