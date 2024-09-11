import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/create_cluster_usecase.dart';
import 'package:flutter/material.dart';

class CreateClusterForm extends StatefulWidget {
  final ValueChanged<bool> onToggleVisibility; // Callback for visibility toggle
  final CreateClusterUsecase createClusterUsecase; // Usecase for cluster creation

  const CreateClusterForm({
    Key? key,
    required this.onToggleVisibility,
    required this.createClusterUsecase,
  }) : super(key: key);

  @override
  State<CreateClusterForm> createState() => _CreateClusterFormState();
}

class _CreateClusterFormState extends State<CreateClusterForm> {
  bool _isVisible = false; // Track form visibility

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isVisible
          ? Column(
              children: [
                // Form fields for cluster creation (name, description, etc.)
                ElevatedButton(
                  onPressed: () async {
                    // Validate form data
                    // Call createClusterUsecase to create the cluster
                  },
                  child: const Text('Create Cluster'),
                ),
                TextButton(
                  onPressed: () => setState(() => _isVisible = false),
                  child: const Text('Cancel'),
                ),
              ],
            )
          : IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() => _isVisible = true),
            ),
    );
  }
}