import 'package:flutter/material.dart';
import '../../components/footer/custom_footer.dart';
import '../../components/modal/custom_modal.dart';
import '../../styles/app_colors.dart';
import '../../utils/responsive.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _faqQuery = '';

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How fast will my food arrive?',
      'answer': 'Most orders are delivered in under 25-30 minutes depending on distance and kitchen order volume.',
    },
    {
      'question': 'Can I customize ingredients or add extra toppings?',
      'answer': 'Yes! Simply tap any food card to open its detail screen and select custom sizes, crusts, and add-on toppings.',
    },
    {
      'question': 'What promo codes are available?',
      'answer': 'Use code DISHDASH10 for 10% off your entire order, or FREESHIP for free delivery!',
    },
    {
      'question': 'How does live order tracking work?',
      'answer': 'After placing an order, visit the Orders tab to watch your meal status update from Placed to Preparing, Ready, and Delivered.',
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    final filteredFaqs = _faqs.where((faq) {
      if (_faqQuery.isEmpty) return true;
      return faq['question']!.toLowerCase().contains(_faqQuery.toLowerCase()) ||
          faq['answer']!.toLowerCase().contains(_faqQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact Us & Support',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                const Text('Have a question, feedback, or custom inquiry? We\'re here to help!', style: TextStyle(color: AppColors.textLight, fontSize: 13)),
                const SizedBox(height: 24),

                // Form & Info layout
                if (isMobile)
                  Column(
                    children: [
                      _buildContactForm(context),
                      const SizedBox(height: 24),
                      _buildInfoCard(),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildContactForm(context)),
                      const SizedBox(width: 24),
                      Expanded(flex: 2, child: _buildInfoCard()),
                    ],
                  ),
                const Divider(height: 48),

                // Searchable FAQ Accordion
                const Text('Frequently Asked Questions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (val) => setState(() => _faqQuery = val),
                  decoration: const InputDecoration(
                    hintText: 'Search FAQ questions...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 16),
                ...filteredFaqs.map((faq) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: ExpansionTile(
                        title: Text(faq['question']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(faq['answer']!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4)),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const CustomFooter(),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: const [AppColors.cardShadow],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Send Us a Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Your Name', prefixIcon: Icon(Icons.person_outline)),
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email_outlined)),
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject', prefixIcon: Icon(Icons.subject)),
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Message', alignLabelWithHint: true),
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomModal(
                        title: 'Message Sent!',
                        message: 'Thank you for reaching out to DishDash. Our support team will get back to you within 2 hours.',
                        primaryButtonText: 'OK',
                        onPrimaryPressed: () {
                          Navigator.pop(context);
                          _nameController.clear();
                          _emailController.clear();
                          _subjectController.clear();
                          _messageController.clear();
                        },
                      ),
                    );
                  }
                },
                child: const Text('SUBMIT MESSAGE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtle,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Restaurant Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.location_on, color: AppColors.primary),
              SizedBox(width: 10),
              Expanded(child: Text('123 Gourmet Ave, Suite 100, Food City', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.phone, color: AppColors.primary),
              SizedBox(width: 10),
              Text('+1 (800) 555-DISH', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.email, color: AppColors.primary),
              SizedBox(width: 10),
              Text('support@dishdash.com', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),

          // Map Placeholder
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              height: 140,
              width: double.infinity,
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, size: 36, color: AppColors.secondary),
                      const SizedBox(height: 6),
                      const Text('Interactive Map View', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}