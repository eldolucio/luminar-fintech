import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsentManagementPage extends StatelessWidget {
  final String institutionName;
  final String status;
  final DateTime expirationDate;

  const ConsentManagementPage({
    super.key,
    required this.institutionName,
    required this.status,
    required this.expirationDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F12),
      appBar: AppBar(
        title: Text('Gestão de Consentimento', style: GoogleFonts.outfit()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(),
            const SizedBox(height: 32),
            _buildDataPermissionsList(),
            const SizedBox(height: 48),
            _buildRevokeButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B20),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF6C63FF),
            child: Text(institutionName[0], style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(institutionName, style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Ativo até ${expirationDate.day}/${expirationDate.month}/${expirationDate.year}', 
                  style: GoogleFonts.outfit(color: const Color(0xFF00D09E), fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Color(0xFF00D09E)),
        ],
      ),
    );
  }

  Widget _buildDataPermissionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dados Compartilhados', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 16),
        _permissionItem(Icons.account_balance_wallet, 'Saldos das Contas'),
        _permissionItem(Icons.list_alt, 'Extrato (Transações de 12 meses)'),
        _permissionItem(Icons.credit_card, 'Limites e Faturas de Cartão'),
        _permissionItem(Icons.person, 'Dados Cadastrais'),
      ],
    );
  }

  Widget _permissionItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white38),
          const SizedBox(width: 12),
          Text(label, style: GoogleFonts.outfit(color: Colors.white, fontSize: 14)),
          const Spacer(),
          const Icon(Icons.check, size: 16, color: Color(0xFF00D09E)),
        ],
      ),
    );
  }

  Widget _buildRevokeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          side: const BorderSide(color: Color(0xFFFF5252)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {
          _showRevokeDialog(context);
        },
        child: Text('Revogar Consentimento', style: GoogleFonts.outfit(color: const Color(0xFFFF5252), fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showRevokeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1D1B20),
        title: Text('Revogar acesso?', style: GoogleFonts.outfit(color: Colors.white)),
        content: Text('Seus dados deixarão de ser atualizados automaticamente no app.', 
          style: GoogleFonts.outfit(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            }, 
            child: const Text('Sim, Revogar', style: TextStyle(color: Color(0xFFFF5252)))),
        ],
      ),
    );
  }
}
