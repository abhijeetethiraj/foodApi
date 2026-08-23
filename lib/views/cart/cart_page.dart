import 'package:flutter/material.dart';
import 'package:foodapi/provider/cart_provider.dart';
import 'package:foodapi/views/payment/payment_page.dart';
import 'package:foodapi/views/widgets/cart_items.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      if (viewModel.cartItems.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(
                            child: Text(
                              'Your cart is empty. Add items from Home!',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        )
                      else
                        ...List.generate(viewModel.cartItems.length, (index) {
                          return CartItemWidget(
                            item: viewModel.cartItems[index],
                            onIncrement: () => viewModel.incrementQuantity(index),
                            onDecrement: () => viewModel.decrementQuantiity(index),
                            onDelete: () => viewModel.removeItem(index),
                          );
                        }),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Subtotal', viewModel.subtotal),
                    const SizedBox(height: 12),
                    _buildSummaryRow(
                      'Delivery Fee',
                      viewModel.subtotal > 0 ? viewModel.deliveryFee : 0,
                    ),
                    const SizedBox(height: 12),
                    _buildSummaryRow('Tax', viewModel.tax),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF983D2A),
                          ),
                        ),
                        Text(
                          '₹ ${viewModel.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF983D2A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: viewModel.cartItems.isEmpty ? null : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentsPage(
                                cartItems: viewModel.cartItems,
                                 amount: viewModel.total,
                                 ),
                                 )
                              
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B3A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
        Text(
          '₹ ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}