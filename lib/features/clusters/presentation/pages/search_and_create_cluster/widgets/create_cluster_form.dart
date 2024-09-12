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
  final _descriptionController = TextEditingController();
  final _legalIdController = TextEditingController();

  // Controladores para los campos de la dirección
  final _streetTypeAndNameController = TextEditingController();
  final _buildingNumberController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();

  String _clusterType = 'Physical'; // Tipo por defecto

  LatLng _coordinates = LatLng(0.0, 0.0); // Placeholder para las coordenadas
  bool _isLoading = false;

  // Función para crear un TextFormField de manera simplificada
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String validationMessage,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: (value) => value == null || value.isEmpty ? validationMessage : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextFormField(
            controller: _nameController,
            labelText: 'Cluster Name',
            validationMessage: 'Please enter a name',
          ),
          _buildTextFormField(
            controller: _descriptionController,
            labelText: 'Description',
            validationMessage: 'Please enter a description',
          ),
          _buildTextFormField(
            controller: _legalIdController,
            labelText: 'Legal ID',
            validationMessage: 'Please enter a Legal ID',
          ),
          // Campos para la dirección
          _buildTextFormField(
            controller: _streetTypeAndNameController,
            labelText: 'Street Type and Name',
            validationMessage: 'Please enter the street type and name',
          ),
          _buildTextFormField(
            controller: _buildingNumberController,
            labelText: 'Building Number',
            validationMessage: 'Please enter the building number',
          ),
          _buildTextFormField(
            controller: _neighborhoodController,
            labelText: 'Neighborhood',
            validationMessage: 'Please enter the neighborhood',
          ),
          _buildTextFormField(
            controller: _postalCodeController,
            labelText: 'Postal Code',
            validationMessage: 'Please enter the postal code',
          ),
          _buildTextFormField(
            controller: _cityController,
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
                _clusterType = newValue!;
              });
            },
            items: <String>['Physical', 'Legal']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() => _isLoading = true);

                // Crear el objeto Address con los valores del formulario
                final address = Address(
                  streetTypeAndName: _streetTypeAndNameController.text,
                  buildingNumber: _buildingNumberController.text,
                  neighborhood: _neighborhoodController.text,
                  postalCode: _postalCodeController.text,
                  city: _cityController.text,
                  state: _stateController.text,
                  country: _countryController.text,
                );

                await widget.createClusterUsecase.createCluster(
                  clusterUid: 'generatedClusterUid',
                  legalId: _legalIdController.text,
                  clusterName: _nameController.text,
                  description: _descriptionController.text,
                  type: _clusterType,
                  address: address, // Pasar el objeto Address
                  coordinates: _coordinates,
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
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _legalIdController.dispose();
    _streetTypeAndNameController.dispose();
    _buildingNumberController.dispose();
    _neighborhoodController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }
}
