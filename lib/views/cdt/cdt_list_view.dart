import 'package:flutter/material.dart';
import '../../models/cdt.dart';
import '../../services/cdt_service.dart';
import '../../widgets/base_view.dart';

class CDTListView extends StatefulWidget {
  const CDTListView({super.key});

  @override
  State<CDTListView> createState() => _CDTListViewState();
}

class _CDTListViewState extends State<CDTListView> {
  final CDTService _cdtService = CDTService();
  late Future<List<CDT>> _futureCDTs;

  @override
  void initState() {
    super.initState();
    _futureCDTs = _cdtService.getCDTs();
  }

  String _formatMonto(double monto) {
    return '\$${monto.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Lista de CDTs',
      body: FutureBuilder<List<CDT>>(
        future: _futureCDTs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay CDTs disponibles'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final cdt = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              cdt.nombreEntidad,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${cdt.tasa}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cdt.descripcion,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Monto: ${_formatMonto(cdt.monto)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


