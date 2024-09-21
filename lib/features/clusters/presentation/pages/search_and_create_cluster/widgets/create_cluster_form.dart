import 'package:cluster_passport/features/clusters/a_cluster/domain/entities/cluster_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cluster_passport/features/clusters/a_cluster/domain/usecases/create_cluster_usecase.dart';

class CreateClusterForm extends StatefulWidget {
  final CreateClusterUsecase createClusterUsecase;
  final VoidCallback onClusterCreated;

  const CreateClusterForm({
    super.key,
    required this.createClusterUsecase,
    required this.onClusterCreated,
  });

  @override
  State<CreateClusterForm> createState() => _CreateClusterFormState();
}

class _CreateClusterFormState extends State<CreateClusterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _clusterDescriptionController = TextEditingController();
  final _clusterLegalIdController = TextEditingController();
  final _clusterAddressStreetTypeAndNameController = TextEditingController();
  final _clusterAddressBuildingNumberController = TextEditingController();
  final _clusterAddressNeighborhoodController = TextEditingController();
  final _clusterAddressPostalCodeController = TextEditingController();
  final _clusterAddressCityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();

  String _clusterType = "Physical";
  final LatLng _coordinates = const LatLng(0.0, 0.0);
  bool _isLoading = false;

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String validationMessage,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
        validator: (value) =>
            value == null || value.isEmpty ? validationMessage : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFormField(
              controller: _nameController,
              labelText: 'Cluster Name',
              validationMessage: 'Please enter a name',
            ),
            _buildTextFormField(
              controller: _clusterDescriptionController,
              labelText: 'Description',
              validationMessage: 'Please enter a description',
            ),
            _buildTextFormField(
              controller: _clusterLegalIdController,
              labelText: 'Legal ID',
              validationMessage: 'Please enter a Legal ID',
            ),
            _buildTextFormField(
              controller: _clusterAddressStreetTypeAndNameController,
              labelText: 'Street Type and Name',
              validationMessage: 'Please enter the street type and name',
            ),
            _buildTextFormField(
              controller: _clusterAddressBuildingNumberController,
              labelText: 'Building Number',
              validationMessage: 'Please enter the building number',
            ),
            _buildTextFormField(
              controller: _clusterAddressNeighborhoodController,
              labelText: 'Neighborhood',
              validationMessage: 'Please enter the clusterAddressNeighborhood',
            ),
            _buildTextFormField(
              controller: _clusterAddressPostalCodeController,
              labelText: 'Postal Code',
              validationMessage: 'Please enter the postal code',
            ),
            _buildTextFormField(
              controller: _clusterAddressCityController,
              labelText: 'City',
              validationMessage: 'Please enter the city',
            ),
            _buildTextFormField(
              controller: _stateController,
              labelText: 'State',
              validationMessage: 'Please enter the state',
            ),
            _buildTextFormField(
              controller: _countryController,
              labelText: 'Country',
              validationMessage: 'Please enter the country',
            ),
            DropdownButtonFormField<String>(
              value: _clusterType,
              decoration: const InputDecoration(labelText: 'Cluster Type'),
              onChanged: (String? newValue) {
                setState(() {
                  _clusterType = newValue ??
                      'Physical'; // Asigna 'Physical' si newValue es null
                });
              },
              items: const <String>['Physical', 'Legal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => _isLoading = true);
                  final address = ClusterAddress(
                    clusterAddressStreetTypeAndName:
                        _clusterAddressStreetTypeAndNameController.text,
                    clusterAddressBuildingNumber:
                        _clusterAddressBuildingNumberController.text,
                    clusterAddressNeighborhood:
                        _clusterAddressNeighborhoodController.text,
                    clusterAddressPostalCode:
                        _clusterAddressPostalCodeController.text,
                    clusterAddressCity: _clusterAddressCityController.text,
                    state: _stateController.text,
                    country: _countryController.text,
                  );

                  await widget.createClusterUsecase.createCluster(
                    clusterUid: 'generatedClusterUid',
                    clusterLegalId: _clusterLegalIdController.text,
                    clusterName: _nameController.text,
                    clusterDescription: _clusterDescriptionController.text,
                    clusterType: _clusterType,
                    clusterAddress: address,
                    clusterCoordinates: _coordinates,
                  );
                  setState(() => _isLoading = false);
                  widget.onClusterCreated();
                }
              },
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Create Cluster'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _clusterDescriptionController.dispose();
    _clusterLegalIdController.dispose();
    _clusterAddressStreetTypeAndNameController.dispose();
    _clusterAddressBuildingNumberController.dispose();
    _clusterAddressNeighborhoodController.dispose();
    _clusterAddressPostalCodeController.dispose();
    _clusterAddressCityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }
}
