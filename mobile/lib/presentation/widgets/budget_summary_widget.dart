import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetSummaryWidget extends StatelessWidget {
  const BudgetSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Orçamentos do Mês', style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('Ver todos')),
          ],
        ),
        const SizedBox(height: 16),
        _buildBudgetItem('🍔 Alimentação', 850, 1200, const Color(0xFF00D09E)),
        _buildBudgetItem('🚗 Transporte', 480, 500, const Color(0xFFFFAB00)),
      ],
    );
  }

  Widget _buildBudgetItem(String category, double current, double limit, Color color) {
    final double percent = (current / limit).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B20),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w500)),
              Text('R\$ $current / R\$ $limit', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.05),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
