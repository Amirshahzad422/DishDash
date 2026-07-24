import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/footer/custom_footer.dart';
import '../../components/modal/custom_modal.dart';
import '../../providers/cart_provider.dart';
import '../../providers/orders_provider.dart';
import '../../routes/app_router.dart';
import '../../styles/app_colors.dart';
import '../../utils/formatters.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'Maryam');
  final TextEditingController _phoneController = TextEditingController(text: '+1 (555) 234-5678');
  final TextEditingController _emailController = TextEditingController(text: 'maryamfatima2253@gmail.com');
  final TextEditingController _addressController = TextEditingController(text: '742 Evergreen Terrace, Suite 4B');
  final TextEditingController _notesController = TextEditingController();

  String _paymentMethod = 'Credit Card';
  String _deliveryTime = 'ASAP (20-30 mins)';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Customer Contact Details
                    const Text('1. Customer Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outline)),
                      validator: (val) => val == null || val.isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone_outlined)),
                            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email_outlined)),
                            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    // Section 2: Delivery / Pickup Details
                    Text('2. ${cart.orderType} Details', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                    if (cart.orderType == 'Delivery') ...[
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: 'Delivery Address', prefixIcon: Icon(Icons.location_on_outlined)),
                        validator: (val) => val == null || val.isEmpty ? 'Please enter delivery address' : null,
                      ),
                      const SizedBox(height: 12),
                    ],
                    DropdownButtonFormField<String>(
                      initialValue: _deliveryTime,
                      decoration: const InputDecoration(labelText: 'Delivery / Pickup Time', prefixIcon: Icon(Icons.access_time)),
                      items: const [
                        DropdownMenuItem(value: 'ASAP (20-30 mins)', child: Text('ASAP (20-30 mins)')),
                        DropdownMenuItem(value: 'Schedule for Later (1 Hour)', child: Text('Schedule for Later (1 Hour)')),
                        DropdownMenuItem(value: 'Schedule for Later (2 Hours)', child: Text('Schedule for Later (2 Hours)')),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _deliveryTime = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(labelText: 'Driver / Special Delivery Notes', prefixIcon: Icon(Icons.note_outlined)),
                    ),
                    const Divider(height: 32),

                    // Section 3: Payment Method Selection
                    const Text('3. Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                    Column(
                      children: ['Credit Card', 'Cash on Delivery', 'Mobile Wallet (Apple/Google Pay)'].map((method) {
                        return RadioListTile<String>(
                          title: Text(method, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          value: method,
                          // ignore: deprecated_member_use
                          groupValue: _paymentMethod,
                          activeColor: AppColors.primary,
                          // ignore: deprecated_member_use
                          onChanged: (val) {
                            if (val != null) setState(() => _paymentMethod = val);
                          },
                        );
                      }).toList(),
                    ),
                    const Divider(height: 32),

                    // Section 4: Summary & Place Order
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          ...cart.items.map((i) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${i.quantity}x ${i.item.name}', style: const TextStyle(fontSize: 13)),
                                    Text(Formatters.currency(i.totalPrice), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  ],
                                ),
                              )),
                          const Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(Formatters.currency(cart.totalAmount), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.primary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final newOrder = ordersProvider.createOrder(
                              items: cart.items,
                              subtotal: cart.subtotal,
                              deliveryFee: cart.deliveryFee,
                              tax: cart.tax,
                              discount: cart.discountAmount,
                              totalAmount: cart.totalAmount,
                              orderType: cart.orderType,
                              address: _addressController.text,
                              paymentMethod: _paymentMethod,
                            );

                            cart.clearCart();

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => CustomModal(
                                title: 'Order Placed Successfully!',
                                message: 'Your order #${newOrder.orderNumber} has been received by the kitchen. You can track your meal in real-time!',
                                primaryButtonText: 'TRACK ORDER',
                                onPrimaryPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRouter.ordersRoute,
                                    (route) => route.isFirst,
                                  );
                                },
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('PLACE ORDER', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}