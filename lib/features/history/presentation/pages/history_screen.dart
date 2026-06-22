import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/history_cubit.dart';
import '../cubit/history_state.dart';
import '../../../guide/data/guide_data.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..loadHistory(),
      child: const HistoryView(),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  Map<String, dynamic> _getCategoryData(String categoryName) {
    return wasteItems.firstWhere(
      (item) =>
          item['id'].toString().toLowerCase() ==
              categoryName.toLowerCase() ||
          item['title'].toString().toLowerCase() ==
              categoryName.toLowerCase(),
      orElse: () => {
        'title': categoryName,
        'color': const Color(0xFF2E7D32),
        'icon':  Icons.restore_from_trash_rounded,
      },
    );
  }

  String _calculateRank(int totalScans) {
    if (totalScans < 5)  return 'Beginner';
    if (totalScans < 15) return 'Recycler';
    if (totalScans < 30) return 'Eco-Hero';
    return 'Planet Savior';
  }

  @override
  Widget build(BuildContext context) {
    const Color textDark = Color(0xFF1B5E20);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFA5D6A7), Color(0xFFE8F5E9), Colors.white],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 90,
          title: Column(children: [
            Text(
              'YOUR DEVICE LOG',
              style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: textDark.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 4),
            const Text('Local Impact',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: textDark)),
          ]),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          // Clear history ikonu
          actions: [
            BlocBuilder<HistoryCubit, HistoryState>(
              builder: (ctx, state) {
                if (state is HistoryLoaded && state.items.isNotEmpty) {
                  return IconButton(
                    icon: const Icon(Icons.delete_sweep_outlined,
                        color: Color(0xFF1B5E20)),
                    tooltip: 'Clear History',
                    onPressed: () => _confirmClear(ctx),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: Color(0xFF2E7D32)));
            }
            if (state is HistoryError) {
              return Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<HistoryCubit>().loadHistory(),
                    child: const Text('Retry'),
                  ),
                ]),
              );
            }
            if (state is HistoryLoaded) {
              return Column(children: [
                _buildStatsHeader(state.items),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Recent Scans',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87)),
                  ),
                ),
                Expanded(
                  child: state.items.isEmpty
                      ? Center(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                            Icon(Icons.history,
                                size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 12),
                            Text('No scans yet',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16)),
                            const SizedBox(height: 8),
                            Text('Take a photo to get started!',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 13)),
                          ]))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          itemCount: state.items.length,
                          itemBuilder: (context, index) =>
                              _buildHistoryCard(state.items[index]),
                        ),
                ),
              ]);
            }
            return const Center(
                child: Text('No history found on this device'));
          },
        ),
      ),
    );
  }

  Widget _buildStatsHeader(List items) {
    const Color cardColor = Color(0xFF2E7D32);
    final String rank = _calculateRank(items.length);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: cardColor.withValues(alpha: 0.4),
              blurRadius: 25,
              offset: const Offset(0, 15)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem('Total Scans', '${items.length}',
              Icons.bar_chart_rounded),
          Container(
              width: 1,
              height: 60,
              color: Colors.white.withValues(alpha: 0.2)),
          _statItem(
              'Today',
              '${items.where((i) => i.date.day == DateTime.now().day && i.date.month == DateTime.now().month && i.date.year == DateTime.now().year).length}',
              Icons.today_rounded),
          Container(
              width: 1,
              height: 60,
              color: Colors.white.withValues(alpha: 0.2)),
          _statItem('Your Rank', rank, Icons.emoji_events_rounded),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, IconData icon) {
    return Column(children: [
      Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 30),
      const SizedBox(height: 12),
      Text(value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900)),
      const SizedBox(height: 4),
      Text(label,
          style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5)),
    ]);
  }

  Widget _buildHistoryCard(dynamic item) {
    final categoryData = _getCategoryData(item.category);
    final Color    itemColor = categoryData['color'] as Color;
    final IconData itemIcon  = categoryData['icon']  as IconData;
    final String   itemTitle = categoryData['title'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 15,
              offset: Offset(0, 8)),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              color: itemColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18)),
          child: Icon(itemIcon, color: itemColor, size: 30),
        ),
        title: Text(itemTitle,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17,
                color: Colors.black87)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Row(children: [
            Icon(Icons.access_time_rounded,
                size: 14, color: Colors.grey.shade500),
            const SizedBox(width: 6),
            Text(
              item.date.toString().substring(0, 16),
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ]),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.shade50, shape: BoxShape.circle),
          child: Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: Colors.grey.shade400),
        ),
      ),
    );
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Clear History'),
        content: const Text(
            'All scan history will be permanently deleted from this device.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<HistoryCubit>().clearHistory();
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
