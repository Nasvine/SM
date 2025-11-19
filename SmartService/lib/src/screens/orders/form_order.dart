import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/models/order_model.dart';
import 'package:smart_service/src/screens/orders/location_input.dart';
import 'package:smart_service/src/screens/orders/route_map.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/button_custom_outlined_icon.dart';
import 'package:smart_service/src/utils/texts/text_custom.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:smart_service/src/utils/validators/validator.dart';
import 'package:iconsax/iconsax.dart';

class FormOrderScreen extends StatefulWidget {
  const FormOrderScreen({super.key, this.orderId = ""});
  final String orderId;
  @override
  
  State<FormOrderScreen> createState() => _FormOrderScreenState();
}

class _FormOrderScreenState extends State<FormOrderScreen> {
  PlaceLocation? _selectedLocationStart;
  PlaceLocation? _selectedLocationEnd;
  final companyLocation = PlaceLocation(
    latitude: 6.378617299999999,
    longitude: 2.4122047,
    address: "Smart Services",
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  final List<Map<String, dynamic>> packages = [
    {
      "key": "Food",
      "name": 'Repas',
      "icon": Iconsax.box,
      "color": Colors.orange
    },
    {
      "key": "SuperMarket",
      "name": 'SuperMarché ou Marché',
      "icon": Iconsax.shop,
      "color": Colors.green
    },
    {
      "key": "Package",
      "name": 'Colis',
      "icon": Icons.luggage,
      "color": Colors.blue
    },
    {
      "key": "AdministrativeCourse",
      "name": 'Course Administrative',
      "icon": Iconsax.document,
      "color": Colors.purple
    },
  ];
  
  String? packageType;
  bool isValidated = false;
  final messageController = TextEditingController();
  final numeroWithdrawalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    
    return Scaffold(
      backgroundColor: isDark ? ColorApp.tDarkBgColor : Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
            size: 20,
          ),
        ),
        title: Text(
          "Nouvelle livraison",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeaderSection(isDark),
                
                const SizedBox(height: 24),
                
                // Adresse de départ
                _buildLocationSection(
                  title: "Adresse de départ",
                  icon: Iconsax.location,
                  isStart: true,
                  isDark: isDark,
                ),
                
                const SizedBox(height: 20),
                
                // Adresse de destination
                _buildLocationSection(
                  title: "Adresse de destination",
                  icon: Iconsax.location_add,
                  isStart: false,
                  isDark: isDark,
                ),
                
                const SizedBox(height: 20),
                
                // Type de colis
                _buildPackageTypeSection(isDark),
                
                const SizedBox(height: 20),
                
                // Message au livreur
                _buildMessageSection(isDark),
                
                const SizedBox(height: 20),
                
                // Numéro de retrait
                _buildPhoneSection(isDark),
                
                const SizedBox(height: 32),
                
                // Bouton de validation
                _buildSubmitButton(isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorApp.tPrimaryColor.withOpacity(0.1),
            ColorApp.tSecondaryColor.withOpacity(0.05),
        ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: ColorApp.tPrimaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.box_add,
              color: ColorApp.tPrimaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Détails de livraison",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Remplissez les informations de votre colis",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection({
    required String title,
    required IconData icon,
    required bool isStart,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorApp.tPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: ColorApp.tPrimaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
            ),
            color: isDark ? Colors.grey[800] : Colors.white,
          ),
          child: LocationInput(
            onSelectedLocation: (value) {
              setState(() {
                if (isStart) {
                  _selectedLocationStart = value;
                } else {
                  _selectedLocationEnd = value;
                }
              });
            },
          ),
        ),
        if ((isStart && _selectedLocationStart != null) || 
            (!isStart && _selectedLocationEnd != null))
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              isStart 
                  ? _selectedLocationStart!.address
                  : _selectedLocationEnd!.address,
              style: TextStyle(
                fontSize: 12,
                color: Colors.green[600],
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  Widget _buildPackageTypeSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorApp.tPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.box,
                color: ColorApp.tPrimaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Type de colis",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? Colors.grey[800] : Colors.white,
          ),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: ColorApp.tPrimaryColor,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: isDark ? Colors.grey[800] : Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            value: packageType,
            hint: Text(
              'Sélectionnez le type de colis',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
            items: packages.map((value) {
              String key = value["key"];
              String name = value["name"];
              IconData icon = value["icon"];
              Color color = value["color"];
              
              return DropdownMenuItem(
                value: key,
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                packageType = value!;
              });
            },
            validator: (value) =>
                TValidator.validationEmptyText("Type de colis", value),
            icon: Icon(
              Iconsax.arrow_down_1,
              color: Colors.grey[500],
            ),
            dropdownColor: isDark ? Colors.grey[800] : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildMessageSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorApp.tPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.message_text,
                color: ColorApp.tPrimaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Message au livreur",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? Colors.grey[800] : Colors.white,
          ),
          child: TextFormField(
            controller: messageController,
            maxLines: 4,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: "Instructions spéciales pour le livreur...",
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: ColorApp.tPrimaryColor,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: isDark ? Colors.grey[800] : Colors.white,
              contentPadding: const EdgeInsets.all(16),
            ),
            validator: (value) => TValidator.validationEmptyText(
              "Message au livreur",
              value,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorApp.tPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.mobile,
                color: ColorApp.tPrimaryColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Numéro de retrait",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? Colors.grey[800] : Colors.white,
          ),
          child: TextFormField(
            controller: numeroWithdrawalController,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: "Ex: 01 23 45 67 89",
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(
                Iconsax.mobile,
                color: Colors.grey[500],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: ColorApp.tPrimaryColor,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: isDark ? Colors.grey[800] : Colors.white,
            ),
            validator: (value) => TValidator.validationPhoneNumber(value),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(bool isDark) {
    return Column(
      children: [
        if (isValidated)
          const CircularProgressIndicator(color: ColorApp.tPrimaryColor)
        else
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.tPrimaryColor,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.map_1,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.orderId != null 
                        ? "Mettre à jour la livraison"
                        : "Voir l'itinéraire et le prix",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        
        const SizedBox(height: 16),
        
        // Indicateurs de progression
        _buildProgressIndicator(isDark),
      ],
    );
  }

  Widget _buildProgressIndicator(bool isDark) {
    final steps = [
      _selectedLocationStart != null,
      _selectedLocationEnd != null,
      packageType != null,
      messageController.text.isNotEmpty,
      numeroWithdrawalController.text.isNotEmpty,
    ];
    final completedSteps = steps.where((step) => step).length;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Progression: $completedSteps/${steps.length}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              "${((completedSteps / steps.length) * 100).toInt()}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ColorApp.tPrimaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: completedSteps / steps.length,
          backgroundColor: Colors.grey[300],
          color: ColorApp.tPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  void _submitForm() async {
    // Vérifications des adresses
    if (_selectedLocationStart == null) {
      _showErrorSnackbar("Veuillez sélectionner l'adresse de départ.");
      return;
    }
    if (_selectedLocationEnd == null) {
      _showErrorSnackbar("Veuillez sélectionner l'adresse de destination.");
      return;
    }
    
    // Validation du formulaire
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isValidated = true;
    });

    // Navigation vers l'écran de carte
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      setState(() {
        isValidated = false;
      });
      
      Get.to(
        () => RouteMapScreen(
          startLocation: _selectedLocationStart!,
          endLocation: _selectedLocationEnd!,
          companyLocation: companyLocation,
          packageType: packageType!,
          message: messageController.text.trim(),
          orderId: widget.orderId,
          numeroWithdrawal: int.parse(numeroWithdrawalController.text.trim()),
        ),
      );
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Attention',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }
}