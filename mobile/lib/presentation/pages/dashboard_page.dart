import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F12), // Dark Background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildBalanceCard(),
              const SizedBox(height: 32),
              _buildSectionTitle('Insights Diários'),
              const SizedBox(height: 16),
              _buildInsightCard(),
              const SizedBox(height: 32),
              _buildSectionTitle('Transações Recentes'),
              const SizedBox(height: 16),
              _buildRecentTransactions(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, Eldo',
              style: GoogleFonts.outfit(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            Text(
              'Bem-vindo de volta',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFF1D1B20),
          child: Icon(Icons.person_outline, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF3B3398)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saldo Consolidado',
                style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
              ),
              const Icon(Icons.visibility_outlined, color: Colors.white70, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'R\$ 12.450,80',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildBalanceIndicator(Icons.arrow_upward, 'Receitas', 'R\$ 15.000'),
              const SizedBox(width: 24),
              _buildBalanceIndicator(Icons.arrow_downward, 'Despesas', 'R\$ 2.549'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBalanceIndicator(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 12),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.outfit(color: Colors.white60, fontSize: 10)),
            Text(value, style: GoogleFonts.outfit(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildInsightCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B20),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00D09E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.lightbulb_outline, color: Color(0xFF00D09E)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dica de Economia',
                  style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Você gastou 12% menos com lazer este mês. Parabéns!',
                  style: GoogleFonts.outfit(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      children: [
        _buildTransactionItem('Netflix', 'Lazer', '- R\$ 55,90', Colors.redAccent),
        _buildTransactionItem('Salário App', 'Renda', '+ R\$ 8.500,00', const Color(0xFF00D09E)),
        _buildTransactionItem('Uber', 'Transporte', '- R\$ 24,50', Colors.redAccent),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String category, String amount, Color amountColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1D1B20),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.shopping_bag_outlined, color: Colors.white38),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600)),
                Text(category, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.outfit(color: amountColor, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF0F0F12),
      selectedItemColor: const Color(0xFF6C63FF),
      unselectedItemColor: Colors.white24,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
      ],
    );
  }
}
