import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payments extends StatelessWidget {
  final VoidCallback onLogout;

  const Payments({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment, size: 50, color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Payment Solutions',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Secure & Global Payment Processing',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'We provide comprehensive payment solutions for all your business needs. '
                'From local transactions to international payments, we support multiple payment methods '
                'with top-notch security and reliability.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildListDelegate([
                _buildPaymentCard(
                  'Razorpay Integration',
                  'Seamless integration with Razorpay payment gateway for Indian businesses. '
                      'Supports all major payment methods including credit/debit cards, net banking, UPI, and wallets.',
                  Icons.account_balance,
                  Colors.blue,
                ),
                _buildPaymentCard(
                  'UPI Payment Solutions',
                  'Unified Payments Interface (UPI) integration for instant bank transfers. '
                      'Support for all UPI apps including Google Pay, PhonePe, Paytm, and more.',
                  Icons.mobile_friendly,
                  Colors.green,
                ),
                _buildPaymentCard(
                  'Net Banking',
                  'Secure net banking integration with all major Indian banks. '
                      'Real-time transaction processing with instant confirmation.',
                  Icons.account_balance_wallet,
                  Colors.purple,
                ),
                _buildPaymentCard(
                  'International Payments',
                  'Accept payments from anywhere in the world with multi-currency support. '
                      'Integration with PayPal, Stripe, and other international payment gateways.',
                  Icons.public,
                  Colors.orange,
                ),
                _buildPaymentCard(
                  'Payment Security',
                  'PCI DSS compliant payment processing with advanced encryption. '
                      'Fraud detection and prevention systems to protect your transactions.',
                  Icons.security,
                  Colors.red,
                ),
                _buildPaymentCard(
                  'Recurring Payments',
                  'Set up subscription models with automatic recurring billing. '
                      'Support for monthly, quarterly, and annual payment cycles.',
                  Icons.autorenew,
                  Colors.teal,
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Supported Payment Methods',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildPaymentMethodChip('Credit Cards'),
                      _buildPaymentMethodChip('Debit Cards'),
                      _buildPaymentMethodChip('UPI'),
                      _buildPaymentMethodChip('Net Banking'),
                      _buildPaymentMethodChip('PayPal'),
                      _buildPaymentMethodChip('Stripe'),
                      _buildPaymentMethodChip('Google Pay'),
                      _buildPaymentMethodChip('PhonePe'),
                      _buildPaymentMethodChip('Paytm'),
                      _buildPaymentMethodChip('Apple Pay'),
                      _buildPaymentMethodChip('Amazon Pay'),
                      _buildPaymentMethodChip('Bank Transfer'),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF0D47A1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF0D47A1).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Transaction Statistics',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem('98.7%', 'Success Rate'),
                            _buildStatItem('<2s', 'Avg. Processing'),
                            _buildStatItem('24/7', 'Support'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Recent Transactions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  _buildTransactionItem(
                    'Payment Received',
                    '#INV-001',
                    '\$249.99',
                    Colors.green,
                  ),
                  _buildTransactionItem(
                    'Website Package',
                    '#INV-002',
                    '\$499.99',
                    Colors.green,
                  ),
                  _buildTransactionItem(
                    'Mobile App',
                    '#INV-003',
                    '\$799.99',
                    Colors.green,
                  ),
                  _buildTransactionItem(
                    'Subscription Renewal',
                    '#INV-004',
                    '\$99.99',
                    Colors.blue,
                  ),
                  _buildTransactionItem(
                    'Maintenance',
                    '#INV-005',
                    '\$149.99',
                    Colors.blue,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: onLogout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Logout", style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(description, style: TextStyle(fontSize: 14, height: 1.4)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodChip(String method) {
    return Chip(
      label: Text(method),
      backgroundColor: Color(0xFF0D47A1).withOpacity(0.1),
      labelStyle: TextStyle(color: Color(0xFF0D47A1)),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildTransactionItem(
    String title,
    String invoice,
    String amount,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(invoice, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
