import 'package:flutter/material.dart';
import 'package:srws_app/core/l10n/app_localizations.dart'; 
import '../../data/guide_data.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color textDark = Color(0xFF1B5E20);
    final l10n = AppLocalizations.of(context)!; 

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFA5D6A7),
            Color(0xFFE8F5E9),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 90,
          title: Column(
            children: [
              Text(
                l10n.learnAndProtect, 
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: textDark.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.recyclingGuide, 
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: textDark,
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            _SdgBanner(l10n: l10n),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
                itemCount: wasteItems.length,
                itemBuilder: (context, index) {
                  return _WasteCard(item: wasteItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SdgBanner extends StatelessWidget {
  final AppLocalizations l10n;
  const _SdgBanner({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.eco_rounded, color: Colors.green.shade700, size: 20),
          const SizedBox(width: 10),
          Text(
            l10n.responsibleConsumption, 
            style: TextStyle(
              color: Colors.green.shade900,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _WasteCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _WasteCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final Color color = item['color'] as Color;
    final l10n = AppLocalizations.of(context)!;
    final String id = item['id'] as String;

    String getLocalizedTitle(String categoryId) {
      if (categoryId == 'plastic') return l10n.plasticTitle;
      if (categoryId == 'paper') return l10n.paperTitle;
      if (categoryId == 'glass') return l10n.glassTitle;
      if (categoryId == 'metal') return l10n.metalTitle;
      if (categoryId == 'batteries' || categoryId == 'battery') return l10n.batteriesTitle;
      if (categoryId == 'e-waste' || categoryId == 'ewaste') return l10n.eWasteTitle;
      if (categoryId == 'organic' || categoryId == 'organic-waste') return l10n.organicWasteTitle;
      return item['title'] as String;
    }

    String getLocalizedSubtitle(String categoryId) {
      if (categoryId == 'plastic') return l10n.plasticDesc;
      if (categoryId == 'paper') return l10n.paperDesc;
      if (categoryId == 'glass') return l10n.glassDesc;
      if (categoryId == 'metal') return l10n.metalDesc;
      if (categoryId == 'batteries' || categoryId == 'battery') return l10n.batteriesDesc;
      if (categoryId == 'e-waste' || categoryId == 'ewaste') return l10n.eWasteDesc;
      if (categoryId == 'organic' || categoryId == 'organic-waste') return l10n.organicWasteDesc;
      return item['subtitle'] as String;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryDetailScreen(category: item),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(item['icon'] as IconData, color: color, size: 32),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getLocalizedTitle(id),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          getLocalizedSubtitle(id),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey.shade300),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final Color color = category['color'] as Color;
    final l10n = AppLocalizations.of(context)!;
    final String id = category['id'] as String;

    String getLocalizedTitle(String categoryId) {
      if (categoryId == 'plastic') return l10n.plasticTitle;
      if (categoryId == 'paper') return l10n.paperTitle;
      if (categoryId == 'glass') return l10n.glassTitle;
      if (categoryId == 'metal') return l10n.metalTitle;
      if (categoryId == 'batteries' || categoryId == 'battery') return l10n.batteriesTitle;
      if (categoryId == 'e-waste' || categoryId == 'ewaste') return l10n.eWasteTitle;
      if (categoryId == 'organic' || categoryId == 'organic-waste') return l10n.organicWasteTitle;
      return category['title'] as String;
    }

    String getLocalizedFact(String categoryId) {
      if (categoryId == 'plastic') return l10n.plasticFact;
      if (categoryId == 'paper') return l10n.paperFact;
      if (categoryId == 'glass') return l10n.glassFact;
      if (categoryId == 'metal') return l10n.metalFact;
      if (categoryId == 'batteries' || categoryId == 'battery') return l10n.batteriesFact;
      if (categoryId == 'e-waste' || categoryId == 'ewaste') return l10n.eWasteFact;
      if (categoryId == 'organic' || categoryId == 'organic-waste') return l10n.organicWasteFact;
      return category['fact'] as String;
    }

    List<String> getLocalizedInstructions(String categoryId) {
      if (categoryId == 'plastic') {
        return [l10n.plasticInst1, l10n.plasticInst2, l10n.plasticInst3, l10n.plasticInst4];
      }
      if (categoryId == 'paper') {
        return [l10n.paperInst1, l10n.paperInst2, l10n.paperInst3, l10n.paperInst4];
      }
      if (categoryId == 'glass') {
        return [l10n.glassInst1, l10n.glassInst2, l10n.glassInst3, l10n.glassInst4];
      }
      if (categoryId == 'metal') {
        return [l10n.metalInst1, l10n.metalInst2, l10n.metalInst3, l10n.metalInst4];
      }
      if (categoryId == 'batteries' || categoryId == 'battery') {
        return [l10n.batteriesInst1, l10n.batteriesInst2, l10n.batteriesInst3, l10n.batteriesInst4];
      }
      if (categoryId == 'e-waste' || categoryId == 'ewaste') {
        return [l10n.eWasteInst1, l10n.eWasteInst2, l10n.eWasteInst3, l10n.eWasteInst4];
      }
      if (categoryId == 'organic' || categoryId == 'organic-waste') {
        return [l10n.organicWasteInst1, l10n.organicWasteInst2, l10n.organicWasteInst3, l10n.organicWasteInst4];
      }
      return List<String>.from(category['instructions'] as List);
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF9FBF9),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: color,
              foregroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color,
                            color.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: -50,
                      bottom: -50,
                      child: Icon(
                        category['icon'] as IconData,
                        size: 250,
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            size: 70,
                            color: Colors.white,
          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          getLocalizedTitle(id),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.08),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionHeader(
                            icon: Icons.recycling_rounded,
                            label: l10n.howToRecycleCorrectly, 
                            color: color,
                          ),
                          const SizedBox(height: 24),
                          ...getLocalizedInstructions(id)
                              .asMap()
                              .entries
                              .map(
                                (entry) => _InstructionTile(
                                  index: entry.key + 1,
                                  text: entry.value,
                                  color: color,
                                ),
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _FactCard(fact: getLocalizedFact(id), color: color, l10n: l10n),
                    const SizedBox(height: 40),
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

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class _InstructionTile extends StatelessWidget {
  final int index;
  final String text;
  final Color color;

  const _InstructionTile({
    required this.index,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FactCard extends StatelessWidget {
  final String fact;
  final Color color;
  final AppLocalizations l10n;

  const _FactCard({required this.fact, required this.color, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.didYouKnow, 
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            fact,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}