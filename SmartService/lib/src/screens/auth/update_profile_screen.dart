/* 

import 'package:smart_service/src/controllers/auth/UpdateProfileController.dart';
import 'package:smart_service/src/controllers/auth/UserController.dart';
import 'package:smart_service/src/models/auth/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:smart_service/src/constants/images.dart';
import 'package:smart_service/src/controllers/auth/login_controller.dart';
import 'package:smart_service/src/screens/auth/forget_password_screen.dart';
import 'package:smart_service/src/screens/auth/register_sreen.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/constants/texts.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:smart_service/src/utils/validators/validator.dart';
import 'package:smart_service/src/utils/widget_theme/header_close_custom.dart';
import 'package:text_custom/text_custom.dart';

class UpdateUserProfileScreen extends StatelessWidget {
  final UserModel user;
  final UpdateProfileController controller = Get.put(UpdateProfileController());

   UpdateUserProfileScreen({super.key, required this.user }){
     controller.initUserData(user);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(LineAwesomeIcons.angle_left_solid),),
        title: Text(TextApp.tEditProfile, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        actions: [
          // IconButton(onPressed: () =>(), icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Positioned(
                  top: 40,
                  left: 90,
                  bottom: 30,
                  child: GestureDetector(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.black,
                          child: controller.imageUrl.value == ''
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundImage: AssetImage(ImageApp.tCover),
                                )
                              : ClipOval(
                                  child: Image.network(
                                    width: 150,
                                    height: 150,
                                    controller.imageUrl.value,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.error,
                                        size: 50,
                                        color: Colors.red,
                                      );
                                    },
                                  ),
                                ),
                        ),
                        // Loader pendant l’upload
                        if (controller.isUploading.value)
                          const Positioned.fill(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                    onTap: () {
                      controller.showImagePickerOption(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Form(
                  key: controller.formKeyUpdate,
                  child: Container(
                    // padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.first_name,
                          validator: (value) => TValidator.validationEmptyText("tFirstName".tr, value),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: "tFirstName".tr,
                              hintText: "tFirstName".tr,
                              border: OutlineInputBorder()
                          ),
                        ),
                        // SizedBox(height: tFormHeight -20,),
                        // TextFormField(
                        //   // controller: controller.lastName,
                        //   validator: (value) => TValidator.validationEmptyText("Prénom", value),
                        //   decoration: InputDecoration(
                        //       prefixIcon: Icon(Icons.person_outline_outlined),
                        //       labelText: TextApp.tLastName,
                        //       hintText: TextApp.tLastName,
                        //       border: OutlineInputBorder()
                        //   ),
                        // ),
                        /* SizedBox(height: tFormHeight -20,),
                        TextFormField(
                          controller: controller.last_name,
                          validator: (value) => TValidator.validationEmptyText("tLastName".tr, value),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: "tLastName".tr,
                              hintText: "tLastName".tr,
                              border: OutlineInputBorder()
                          ),
                        ), */
                        SizedBox(height: tFormHeight -20,),
                        TextFormField(
                          controller: controller.email,
                          validator: (value) => TValidator.validateEmail(value),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.alternate_email),
                              labelText: TextApp.tEmail,
                              hintText: TextApp.tEmail,
                              border: OutlineInputBorder()
                          ),
                        ),
                        SizedBox(height: tFormHeight -20,),
                        TextFormField(
                          controller: controller.phoneNumber,
                          validator: (value) => TValidator.validationPhoneNumber(value),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers),
                            labelText: TextApp.tPhoneNo,
                            hintText: TextApp.tPhoneNo,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: ColorApp.tsecondaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: tFormHeight -20,),
                        TextFormField(
                          controller: controller.userAdress,
                          validator: (value) => TValidator.validationEmptyText("tUserAdress".tr, value),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_on_rounded),
                              labelText: "tUserAdress".tr,
                              hintText: "tUserAdress".tr,
                              border: OutlineInputBorder()
                          ),
                        ),
                        // // Obx( ()=>),
                        // TextFormField(
                        //   // controller: controller.password,
                        //   validator: (value) => TValidator.validatePassword(value),
                        //   // obscureText: controller.hidePassword.value,
                        //   decoration: InputDecoration(
                        //
                        //     prefixIcon: Icon(Icons.fingerprint),
                        //     labelText: TextApp.tPassword,
                        //     hintText: TextApp.tPassword,
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //       borderSide: BorderSide(
                        //         color: ColorApp.tsecondaryColor,
                        //       ),
                        //     ),
                        //     // suffixIcon: IconButton(
                        //     //   onPressed: () =>controller.hidePassword.value = !controller.hidePassword.value ,
                        //     //   icon: Icon(controller.hidePassword.value?  Icons.visibility_off : Icons.visibility),
                        //     //
                        //     // )
                        //   ),
                        // ),
                        SizedBox(height: tFormHeight -15,),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: ()=>UpdateProfileController.instance.updateProfile(),
                              child: Text(TextApp.tModify.toUpperCase()),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  foregroundColor: ColorApp.tWhiteColor,
                                  backgroundColor: ColorApp.tsecondaryColor,
                                  side: BorderSide(color: ColorApp.tsecondaryColor),
                                  padding: EdgeInsets.symmetric(vertical: tButtonHeight)
                              ),
                            )),
                        SizedBox(height: tFormHeight -15,),
                      ],
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
 */

import 'package:smart_service/src/controllers/auth/UpdateProfileController.dart';
import 'package:smart_service/src/controllers/auth/UserController.dart';
import 'package:smart_service/src/models/auth/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:smart_service/src/constants/images.dart';
import 'package:smart_service/src/controllers/auth/login_controller.dart';
import 'package:smart_service/src/screens/auth/forget_password_screen.dart';
import 'package:smart_service/src/screens/auth/register_sreen.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/constants/texts.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:smart_service/src/utils/validators/validator.dart';
import 'package:smart_service/src/utils/widget_theme/header_close_custom.dart';
import 'package:text_custom/text_custom.dart';

class UpdateUserProfileScreen extends StatelessWidget {
  final UserModel user;
  final UpdateProfileController controller = Get.put(UpdateProfileController());

  UpdateUserProfileScreen({super.key, required this.user}) {
    controller.initUserData(user);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Color(0xFF0A0E14) : Color(0xFFF8FAFD),
      appBar: _buildAppBar(isDark, context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              // Section avatar avec animation - MAINTAIN CONTEXT HERE
              _buildAvatarSection(isDark, context), // ← CONTEXT PASSED HERE
              
              const SizedBox(height: 40),
              
              // Formulaire avec animations
              _buildFormSection(isDark, context), // ← CONTEXT PASSED HERE
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(bool isDark, BuildContext context) { // ← CONTEXT ADDED
    return AppBar(
      centerTitle: true,
      leading: SlideInAnimation(
        delay: 0,
        direction: SlideDirection.left,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
          ),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              LineAwesomeIcons.angle_left_solid,
              color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
            ),
          ),
        ),
      ),
      title: FadeInAnimation(
        delay: 0.1,
        child: Text(
          TextApp.tEditProfile,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: isDark ? Colors.white : Colors.black,
    );
  }

  Widget _buildAvatarSection(bool isDark, BuildContext context) { // ← CONTEXT ADDED
    return Column(
      children: [
        // Titre section avatar
        FadeInAnimation(
          delay: 0.2,
          child: Text(
            "Modifier votre photo de profil",
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Avatar avec effet
        SlideInAnimation(
          delay: 0.3,
          direction: SlideDirection.top,
          child: Obx(
            () => GestureDetector(
              onTap: () {
                controller.showImagePickerOption(context); // ← NOW CONTEXT IS AVAILABLE
              },
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                ? [
                    Color(0xFFFE9003).withOpacity(0.8),
                    Color.fromARGB(255, 199, 122, 21).withOpacity(0.6),
                    Color.fromARGB(255, 238, 184, 113).withOpacity(0.4),
                  ]
                : [
                    Color(0xFFFE9003).withOpacity(0.8),
                    Color.fromARGB(255, 199, 122, 21).withOpacity(0.6),
                    Color.fromARGB(255, 238, 184, 113).withOpacity(0.4),
                  ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.orange.shade900.withOpacity(0.4) : Colors.orange.shade300.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    // Avatar image
                    Container(
                      width: 130,
                      height: 130,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? Color(0xFF1A2332) : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: controller.imageUrl.value == ''
                          ? ClipOval(
                              child: Image.asset(
                                ImageApp.tCover,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.network(
                                controller.imageUrl.value,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                      color: ColorApp.tsecondaryColor,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person_rounded,
                                    size: 60,
                                    color: isDark ? Colors.white.withOpacity(0.5) : Colors.grey.withOpacity(0.5),
                                  );
                                },
                              ),
                            ),
                    ),
                    
                    // Overlay avec icône de modification
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.4),
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    
                    // Loader pendant l'upload
                    if (controller.isUploading.value)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.6),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 10),
        
        // Indication de tap
        FadeInAnimation(
          delay: 0.4,
          child: Text(
            "Appuyez pour modifier la photo",
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white.withOpacity(0.5) : Colors.grey.withOpacity(0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection(bool isDark, BuildContext context) { // ← CONTEXT ADDED
    return SlideInAnimation(
      delay: 0.5,
      direction: SlideDirection.right,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: isDark ? Color(0xFF1A2332).withOpacity(0.8) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
          border: Border.all(
            color: isDark ? Colors.orange.shade800.withOpacity(0.3) : Colors.orange.shade100,
          ),
        ),
        child: Form(
          key: controller.formKeyUpdate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre section formulaire
              FadeInAnimation(
                delay: 0.6,
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFE9003), Color(0xFFFE9003)],
                        ),
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Informations personnelles",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 25),
              
              // Champ prénom
              _buildFormField(
                delay: 0.7,
                controller: controller.first_name,
                label: "tFirstName".tr,
                hint: "tFirstName".tr,
                icon: Icons.person_outline_rounded,
                validator: (value) => TValidator.validationEmptyText("tFirstName".tr, value),
                isDark: isDark,
              ),

              const SizedBox(height: 20),

              // Champ email
              _buildFormField(
                delay: 0.8,
                controller: controller.email,
                label: TextApp.tEmail,
                hint: TextApp.tEmail,
                icon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => TValidator.validateEmail(value),
                isDark: isDark,
              ),

              const SizedBox(height: 20),

              // Champ téléphone
              _buildFormField(
                delay: 0.9,
                controller: controller.phoneNumber,
                label: TextApp.tPhoneNo,
                hint: TextApp.tPhoneNo,
                icon: Icons.phone_android_rounded,
                keyboardType: TextInputType.phone,
                validator: (value) => TValidator.validationPhoneNumber(value),
                isDark: isDark,
              ),

              const SizedBox(height: 20),

              // Champ adresse
              _buildFormField(
                delay: 1.0,
                controller: controller.userAdress,
                label: "tUserAdress".tr,
                hint: "tUserAdress".tr,
                icon: Icons.location_on_rounded,
                validator: (value) => TValidator.validationEmptyText("tUserAdress".tr, value),
                isDark: isDark,
              ),

              const SizedBox(height: 30),

              // Bouton de modification
              _buildUpdateButton(isDark, context), // ← CONTEXT PASSED HERE
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required double delay,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    bool isDark = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return FadeInAnimation(
      delay: delay,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? Color(0xFF111827) : Colors.grey[50],
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 15, right: 10),
              child: Icon(
                icon,
                color: isDark ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.6),
              ),
            ),
            labelText: label,
            labelStyle: TextStyle(
              color: isDark ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.4),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: ColorApp.tsecondaryColor,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.3),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildUpdateButton(bool isDark, BuildContext context) { // ← CONTEXT ADDED
    return FadeInAnimation(
      delay: 1.1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ColorApp.tsecondaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: ElevatedButton(
          onPressed: () => UpdateProfileController.instance.updateProfile(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
          ),
          child: Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorApp.tsecondaryColor,
                  ColorApp.tsecondaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child:  Text(
                        TextApp.tModify.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

// [Les classes d'animation SlideInAnimation et FadeInAnimation restent identiques]

// Classes d'animation réutilisables
enum SlideDirection { left, right, top, bottom }

class SlideInAnimation extends StatefulWidget {
  final Widget child;
  final double delay;
  final SlideDirection direction;
  final Duration duration;

  const SlideInAnimation({
    super.key,
    required this.child,
    this.delay = 0,
    this.direction = SlideDirection.left,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final offset = _getOffsetByDirection();
    _animation = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  Offset _getOffsetByDirection() {
    switch (widget.direction) {
      case SlideDirection.left:
        return const Offset(-0.5, 0.0);
      case SlideDirection.right:
        return const Offset(0.5, 0.0);
      case SlideDirection.top:
        return const Offset(0.0, -0.5);
      case SlideDirection.bottom:
        return const Offset(0.0, 0.5);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation.value * 50,
          child: Opacity(opacity: _controller.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final double delay;
  final Duration duration;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.delay = 0,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    Future.delayed(Duration(milliseconds: (widget.delay * 1000).round()), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - _animation.value)),
          child: Opacity(opacity: _animation.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
