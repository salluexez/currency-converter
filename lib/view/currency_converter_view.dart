import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/currency_viewmodel.dart';

class CurrencyConverterView extends StatefulWidget {
  const CurrencyConverterView({super.key});

  @override
  State<CurrencyConverterView> createState() =>
      _CurrencyConverterViewState();
}

class _CurrencyConverterViewState
    extends State<CurrencyConverterView> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<CurrencyViewModel>(context, listen: false).getRates();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CurrencyViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Live Currency Converter')),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  initialValue: vm.fromCurrency,
                                  items: vm.currencies
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    vm.fromCurrency = value!;
                                    vm.getRates();
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'From',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  initialValue: vm.toCurrency,
                                  items: vm.currencies
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    vm.toCurrency = value!;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'To',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              vm.convert(
                                double.tryParse(controller.text) ?? 0,
                              );
                            },
                            child: const Text('Convert'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    vm.result.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}