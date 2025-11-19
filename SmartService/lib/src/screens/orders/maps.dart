import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_service/src/models/order_model.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_service/src/constants/colors.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    super.key,
    required this.location,
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String _currentAddress = "";
  bool _isSearching = false;

  void _moveCamera(double lat, double lng) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16),
    );
    setState(() {
      _pickedLocation = LatLng(lat, lng);
    });
  }

  void _getCurrentLocation() {
    _moveCamera(widget.location.latitude, widget.location.longitude);
  }

  void _confirmSelection() {
    if (_pickedLocation != null) {
      Navigator.of(context).pop(_pickedLocation);
    } else {
      _showSnackBar("Veuillez sélectionner un emplacement sur la carte");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ColorApp.tDarkBgColor : Colors.grey[50],
      appBar: AppBar(
        title: Text(
          widget.isSelecting
              ? 'Sélectionnez votre emplacement'
              : 'Votre position',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : Colors.black,
            size: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (widget.isSelecting)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: _confirmSelection,
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorApp.tPrimaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorApp.tPrimaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          // Carte Google Maps
          GoogleMap(
            onTap: !widget.isSelecting
                ? null
                : (position) {
                    setState(() {
                      _pickedLocation = position;
                    });
                  },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.location.latitude,
                widget.location.longitude,
              ),
              zoom: 16,
            ),
            onMapCreated: (controller) => _mapController = controller,
            markers: (_pickedLocation == null && widget.isSelecting)
                ? {}
                : {
                    Marker(
                      markerId: const MarkerId('selected_location'),
                      position: _pickedLocation ??
                          LatLng(
                            widget.location.latitude,
                            widget.location.longitude,
                          ),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed,
                      ),
                      infoWindow: InfoWindow(
                        title: 'Emplacement sélectionné',
                        snippet: _currentAddress.isNotEmpty 
                            ? _currentAddress 
                            : 'Adresse en cours de chargement...',
                      ),
                    ),
                  },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
          ),

          // Barre de recherche élégante
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: _searchController,
                focusNode: _searchFocus,
                googleAPIKey: "AIzaSyCv7nzABmowHcgisZuOVJL8HvENMMQ-uxU",
                debounceTime: 600,
                countries: ["bj"],
                isLatLngRequired: true,
                inputDecoration: InputDecoration(
                  hintText: "Rechercher une adresse au Bénin...",
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: Colors.grey[500],
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _searchFocus.unfocus();
                          },
                          icon: Icon(
                            Iconsax.close_circle,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                textStyle: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
                getPlaceDetailWithLatLng: (prediction) {
                  if (prediction.lat != null && prediction.lng != null) {
                    final lat = double.parse(prediction.lat!);
                    final lng = double.parse(prediction.lng!);
                    _moveCamera(lat, lng);
                    setState(() {
                      _currentAddress = prediction.description ?? "";
                    });
                  }
                },
                itemClick: (prediction) {
                  _searchFocus.unfocus();
                  _searchController.text = prediction.description ?? "";
                  if (prediction.lat != null && prediction.lng != null) {
                    _moveCamera(
                      double.parse(prediction.lat!),
                      double.parse(prediction.lng!),
                    );
                    setState(() {
                      _currentAddress = prediction.description ?? "";
                    });
                  }
                },
                itemBuilder: (context, v, prediction) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: ColorApp.tPrimaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.location,
                            color: ColorApp.tPrimaryColor,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prediction.description ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (prediction.structuredFormatting?.secondaryText != null)
                                Text(
                                  prediction.structuredFormatting!.secondaryText!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                seperatedBuilder: const Divider(),
                /* containerDecoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ), */
              ),
            ),
          ),

          // Bouton de localisation actuelle
          Positioned(
            bottom: 120,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _getCurrentLocation,
                icon: Icon(
                  Iconsax.gps,
                  color: ColorApp.tPrimaryColor,
                  size: 24,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: isDark ? Colors.grey[900] : Colors.white,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ),

          // Bouton de zoom in
          Positioned(
            bottom: 180,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  _mapController?.animateCamera(
                    CameraUpdate.zoomIn(),
                  );
                },
                icon: Icon(
                  Iconsax.add,
                  color: ColorApp.tPrimaryColor,
                  size: 20,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: isDark ? Colors.grey[900] : Colors.white,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ),

          // Bouton de zoom out
          Positioned(
            bottom: 60,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  _mapController?.animateCamera(
                    CameraUpdate.zoomOut(),
                  );
                },
                icon: Icon(
                  Iconsax.minus,
                  color: ColorApp.tPrimaryColor,
                  size: 20,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: isDark ? Colors.grey[900] : Colors.white,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ),

          // Indicateur de sélection en bas
          if (widget.isSelecting && _pickedLocation != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.location,
                            color: Colors.green,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Emplacement sélectionné",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentAddress.isNotEmpty 
                          ? _currentAddress 
                          : "Appuyez sur confirmer pour valider",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _confirmSelection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.tPrimaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.tick_circle, size: 18),
                            SizedBox(width: 8),
                            Text(
                              "Confirmer cet emplacement",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Instructions pour la sélection
          if (widget.isSelecting && _pickedLocation == null)
            const Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Appuyez sur la carte pour sélectionner un emplacement",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}