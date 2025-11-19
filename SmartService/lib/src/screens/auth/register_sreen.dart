/* import 'package:smart_service/src/controllers/auth/RegisterController.dart';
import 'package:smart_service/src/screens/auth/login_screen.dart';
import 'package:smart_service/src/screens/settings/policy_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/constants/texts.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:smart_service/src/utils/validators/validator.dart';
import 'package:smart_service/src/utils/widget_theme/header_close_custom.dart';
import 'package:text_custom/text_custom.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controllerForm = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                HeaderCloseCustom(
                  isDark: isDark,
                  headerIcon1: Icons.close,
                  headerText: "",
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/smart-service-49ew28/assets/uoxtvrh4smpk/Logo_smart.png",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                TextCustom(
                  TheText: "tWelcomeLogin".tr,
                  TheTextSize: 20,
                  TheTextFontWeight: FontWeight.bold,
                  TheTextColor: THelperFunctions.isDarkMode(context)
                      ? ColorApp.tWhiteColor
                      : ColorApp.tBlackColor,
                ),
                const SizedBox(height: 10),
                TextCustom(
                  TheText: "tRegisterTitle".tr,
                  TheTextSize: 15,
                  TheTextFontWeight: FontWeight.normal,
                  TheTextColor: THelperFunctions.isDarkMode(context)
                      ? ColorApp.tWhiteColor
                      : ColorApp.tBlackColor,
                ),
                const SizedBox(height: 10),
                TextCustom(
                  TheText: "tRegisterSubTitle".tr,
                  TheTextSize: 15,
                  TheTextFontWeight: FontWeight.normal,
                  TheTextColor: THelperFunctions.isDarkMode(context)
                      ? ColorApp.tWhiteColor
                      : ColorApp.tBlackColor,
                ),
                const SizedBox(height: 10),
                Form(
                  key: controllerForm.registerformKey,
                  child: Column(
                    children: [
                      TextFormFieldSimpleCustom(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        borderRadiusBorder: 10,
                        cursorColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        borderSideRadiusBorder:
                            THelperFunctions.isDarkMode(context)
                            ? ColorApp.tsecondaryColor
                            : ColorApp.tSombreColor,
                        borderRadiusFocusedBorder: 10,
                        borderSideRadiusFocusedBorder:
                            THelperFunctions.isDarkMode(context)
                            ? ColorApp.tsecondaryColor
                            : ColorApp.tSombreColor,
                        controller: controllerForm.fullName,
                        labelText: TextApp.tFullName,
                        labelStyleColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        hintText: TextApp.tFullName,
                        hintStyleColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: THelperFunctions.isDarkMode(context)
                              ? ColorApp.tWhiteColor
                              : ColorApp.tBlackColor,
                        ),
                        validator: (value) => TValidator.validationEmptyText(
                          "Nom & Prénoms",
                          value,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldSimpleCustom(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        borderRadiusBorder: 10,
                        cursorColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        borderSideRadiusBorder:
                            THelperFunctions.isDarkMode(context)
                            ? ColorApp.tsecondaryColor
                            : ColorApp.tSombreColor,
                        borderRadiusFocusedBorder: 10,
                        borderSideRadiusFocusedBorder:
                            THelperFunctions.isDarkMode(context)
                            ? ColorApp.tsecondaryColor
                            : ColorApp.tSombreColor,
                        controller: controllerForm.phoneNo,
                        labelText: TextApp.tPhoneNo,
                        labelStyleColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        hintText: TextApp.tPhoneNo,
                        hintStyleColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        prefixIcon: Icon(
                          Icons.phone_android_outlined,
                          color: THelperFunctions.isDarkMode(context)
                              ? ColorApp.tWhiteColor
                              : ColorApp.tBlackColor,
                        ),
                        validator: (value) =>
                            TValidator.validationPhoneNumber(value),
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldSimpleCustom(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        borderRadiusBorder: 10,
                        cursorColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        borderSideRadiusBorder:
                            THelperFunctions.isDarkMode(context)
                            ? ColorApp.tsecondaryColor
                            : ColorApp.tSombreColor,
                        borderRadiusFocusedBorder: 10,
                        borderSideRadiusFocusedBorder:
                            THelperFunctions.isDarkMode(context)
                            ? ColorApp.tsecondaryColor
                            : ColorApp.tSombreColor,
                        controller: controllerForm.email,
                        labelText: TextApp.tEmail,
                        labelStyleColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        hintText: TextApp.tEmail,
                        hintStyleColor: THelperFunctions.isDarkMode(context)
                            ? ColorApp.tWhiteColor
                            : ColorApp.tBlackColor,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: THelperFunctions.isDarkMode(context)
                              ? ColorApp.tWhiteColor
                              : ColorApp.tBlackColor,
                        ),
                        validator: (value) => TValidator.validateEmail(value),
                      ),

                      const SizedBox(height: 10),
                      Obx(
                        () => TextFormFieldSimpleCustom(
                          keyboardType: TextInputType.text,
                          obscureText: controllerForm.hidePassword.value,
                          borderRadiusBorder: 10,
                          cursorColor: THelperFunctions.isDarkMode(context)
                              ? ColorApp.tWhiteColor
                              : ColorApp.tBlackColor,
                          borderSideRadiusBorder:
                              THelperFunctions.isDarkMode(context)
                              ? ColorApp.tsecondaryColor
                              : ColorApp.tSombreColor,
                          borderRadiusFocusedBorder: 10,
                          borderSideRadiusFocusedBorder:
                              THelperFunctions.isDarkMode(context)
                              ? ColorApp.tsecondaryColor
                              : ColorApp.tSombreColor,
                          controller: controllerForm.password,
                          labelText: TextApp.tPassword,
                          labelStyleColor: THelperFunctions.isDarkMode(context)
                              ? ColorApp.tWhiteColor
                              : ColorApp.tBlackColor,
                          hintText: TextApp.tPassword,
                          hintStyleColor: THelperFunctions.isDarkMode(context)
                              ? ColorApp.tWhiteColor
                              : ColorApp.tBlackColor,
                          prefixIcon: Icon(
                            Icons.fingerprint,
                            color: THelperFunctions.isDarkMode(context)
                                ? ColorApp.tWhiteColor
                                : ColorApp.tBlackColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => controllerForm.hidePassword.value =
                                !controllerForm.hidePassword.value,
                            icon: Icon(
                              controllerForm.hidePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          validator: (value) {
                            final erreurMessage = TValidator.validatePassword(
                              value,
                            );

                            // Afficher l'erreur dans un snackbar si elle existe
                            if (erreurMessage != null) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Get.snackbar(
                                  'Erreur de mot de passe',
                                  erreurMessage,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                  duration: Duration(
                                    seconds: 4,
                                  ), // Durée plus longue pour lire
                                );
                              });
                            }

                            // Retourner null pour ne pas afficher l'erreur sous le champ
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      Obx(
                        () => CheckboxListTile(
                          value: controllerForm.acceptPolicy.value,
                          onChanged: (value) {
                            controllerForm.acceptPolicy.value = value!;
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: GestureDetector(
                            onTap: () {
                              // Naviguer vers la page Politique de confidentialité
                              Get.to(() => const PrivacyPolicyOwnerHomePage());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "J'accepte la ",
                                style: TextStyle(
                                  color: THelperFunctions.isDarkMode(context)
                                      ? ColorApp.tWhiteColor
                                      : ColorApp.tBlackColor,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Politique de confidentialité",
                                    style: TextStyle(
                                      color: ColorApp.tsecondaryColor,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: tFormHeight - 20),
                ButtonCustom(
                  text: TextApp.tRegister.toUpperCase(),
                  textSize: 15,
                  buttonBackgroundColor: ColorApp.tsecondaryColor,
                  onPressed: () => controllerForm.signup(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => LoginScreen()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            TextApp.tAlreadyHave,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () => Get.to(() => LoginScreen()),
                            child: Text(
                              TextApp.tLogin,
                              style: TextStyle(
                                color: ColorApp.tsecondaryColor,
                                fontSize: THelperFunctions.w(context, 0.04),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 */


import 'package:smart_service/src/controllers/auth/RegisterController.dart';
import 'package:smart_service/src/screens/auth/login_screen.dart';
import 'package:smart_service/src/screens/settings/policy_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/constants/texts.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:smart_service/src/utils/validators/validator.dart';
import 'package:smart_service/src/utils/widget_theme/header_close_custom.dart';
import 'package:text_custom/text_custom.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controllerForm = Get.put(RegisterController());
  
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    Color(0xFF0A0E14),
                    Color(0xFF1A2332),
                    Color(0xFF0F1419),
                  ]
                : [
                    Color(0xFFF8FAFD),
                    Color(0xFFEFF3F9),
                    Colors.white,
                  ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header animé
                _buildAnimatedHeader(isDark),
                
                const SizedBox(height: 20),
                
                // Logo avec animation
                _buildLogoSection(isDark),
                
                const SizedBox(height: 20),
                
                // Titres avec animations séquentielles
                _buildTitleSection(isDark, context),
                
                const SizedBox(height: 30),
                
                // Formulaire avec animations
                _buildFormSection(controllerForm, isDark, context),
                
                const SizedBox(height: 25),
                
                // Checkbox politique
                _buildPolicySection(controllerForm, isDark, context),
                
                const SizedBox(height: 25),
                
                // Bouton d'inscription
                _buildRegisterButton(controllerForm, isDark),
                
                const SizedBox(height: 20),
                
                // Footer avec animation
                _buildFooterSection(isDark, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader(bool isDark) {
    return SlideInAnimation(
      delay: 0,
      direction: SlideDirection.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton fermer avec effet
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.close_rounded,
                color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
                size: 20,
              ),
            ),
          ),
          
          // Titre discret
          TextCustom(
            TheText: "Inscription",
            TheTextSize: 18,
            TheTextFontWeight: FontWeight.w600,
            TheTextColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.8) : ColorApp.tBlackColor.withOpacity(0.7),
          ),
          
          // Espaceur
          const SizedBox(width: 45),
        ],
      ),
    );
  }

  Widget _buildLogoSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.1,
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(15),
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
              color: isDark
                  ? Colors.orange.shade900.withOpacity(0.4)
                  : Colors.orange.shade300.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: ClipOval(
            child: Image.network(
              "https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/smart-service-49ew28/assets/uoxtvrh4smpk/Logo_smart.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(bool isDark, BuildContext context) {
    return Column(
      children: [
        SlideInAnimation(
          delay: 0.2,
          direction: SlideDirection.left,
          child: TextCustom(
            TheText: "tWelcomeLogin".tr,
            TheTextSize: 17,
            TheTextFontWeight: FontWeight.w800,
            TheTextColor: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
        const SizedBox(height: 8),
        FadeInAnimation(
          delay: 0.3,
          child: TextCustom(
            TheText: "tRegisterTitle".tr,
            TheTextSize: 16,
            TheTextFontWeight: FontWeight.w400,
            TheTextColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.8) : ColorApp.tBlackColor.withOpacity(0.7),
            TheTextAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 4),
        FadeInAnimation(
          delay: 0.4,
          child: TextCustom(
            TheText: "tRegisterSubTitle".tr,
            TheTextSize: 16,
            TheTextFontWeight: FontWeight.w400,
            TheTextColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.8) : ColorApp.tBlackColor.withOpacity(0.7),
            TheTextAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection(RegisterController controllerForm, bool isDark, BuildContext context) {
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
            color: isDark ? Colors.blue.shade800.withOpacity(0.3) : Colors.blue.shade100,
          ),
        ),
        child: Form(
          key: controllerForm.registerformKey,
          child: Column(
            children: [
              // Champ nom complet
              _buildFormField(
                delay: 0.6,
                controller: controllerForm.fullName,
                label: TextApp.tFullName,
                hint: TextApp.tFullName,
                icon: Icons.person_2_outlined,
                validator: (value) => TValidator.validationEmptyText("Nom & Prénoms", value),
                isDark: isDark,
              ),

              const SizedBox(height: 15),

              // Champ téléphone
              _buildFormField(
                delay: 0.7,
                controller: controllerForm.phoneNo,
                label: TextApp.tPhoneNo,
                hint: TextApp.tPhoneNo,
                icon: Icons.phone_android_outlined,
                keyboardType: TextInputType.number,
                validator: (value) => TValidator.validationPhoneNumber(value),
                isDark: isDark,
              ),

              const SizedBox(height: 15),

              // Champ email
              _buildFormField(
                delay: 0.8,
                controller: controllerForm.email,
                label: TextApp.tEmail,
                hint: TextApp.tEmail,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => TValidator.validateEmail(value),
                isDark: isDark,
              ),

              const SizedBox(height: 15),

              // Champ mot de passe
              _buildPasswordField(controllerForm, isDark),
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
        child: TextFormFieldSimpleCustom(
          keyboardType: keyboardType,
          obscureText: false,
          borderRadiusBorder: 15,
          cursorColor: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          borderSideRadiusBorder: Colors.transparent,
          borderRadiusFocusedBorder: 15,
          borderSideRadiusFocusedBorder: ColorApp.tsecondaryColor,
          controller: controller,
          labelText: label,
          labelStyleColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.7) : ColorApp.tBlackColor.withOpacity(0.6),
          hintText: hint,
          hintStyleColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.5) : ColorApp.tBlackColor.withOpacity(0.4),
          prefixIcon: Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            child: Icon(
              icon,
              color: isDark ? ColorApp.tWhiteColor.withOpacity(0.7) : ColorApp.tBlackColor.withOpacity(0.6),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }

  Widget _buildPasswordField(RegisterController controllerForm, bool isDark) {
    return FadeInAnimation(
      delay: 0.9,
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
        child: Obx(
          () => TextFormFieldSimpleCustom(
            keyboardType: TextInputType.text,
            controller: controllerForm.password,
            obscureText: controllerForm.hidePassword.value,
            borderRadiusBorder: 15,
            cursorColor: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
            borderSideRadiusBorder: Colors.transparent,
            borderRadiusFocusedBorder: 15,
            borderSideRadiusFocusedBorder: ColorApp.tsecondaryColor,
            labelText: TextApp.tPassword,
            labelStyleColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.7) : ColorApp.tBlackColor.withOpacity(0.6),
            hintText: TextApp.tPassword,
            hintStyleColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.5) : ColorApp.tBlackColor.withOpacity(0.4),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 15, right: 10),
              child: Icon(
                Icons.fingerprint,
                color: isDark ? ColorApp.tWhiteColor.withOpacity(0.7) : ColorApp.tBlackColor.withOpacity(0.6),
              ),
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () => controllerForm.hidePassword.value = !controllerForm.hidePassword.value,
                icon: Icon(
                  controllerForm.hidePassword.value ? Icons.visibility_off : Icons.visibility,
                  color: isDark ? ColorApp.tWhiteColor.withOpacity(0.7) : ColorApp.tBlackColor.withOpacity(0.6),
                ),
              ),
            ),
            validator: (value) {
              final erreurMessage = TValidator.validatePassword(value);
              if (erreurMessage != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Get.snackbar(
                    'Erreur de mot de passe',
                    erreurMessage,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 4),
                    borderRadius: 10,
                    margin: const EdgeInsets.all(15),
                    animationDuration: const Duration(milliseconds: 500),
                  );
                });
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPolicySection(RegisterController controllerForm, bool isDark, BuildContext context) {
    return FadeInAnimation(
      delay: 1.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: isDark ? Color(0xFF1A2332).withOpacity(0.5) : Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
              ),
            ),
            child: CheckboxListTile(
              value: controllerForm.acceptPolicy.value,
              onChanged: (value) {
                controllerForm.acceptPolicy.value = value!;
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              activeColor: ColorApp.tsecondaryColor,
              checkColor: Colors.white,
              tileColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: GestureDetector(
                onTap: () {
                  Get.to(() => const PrivacyPolicyOwnerHomePage());
                },
                child: RichText(
                  text: TextSpan(
                    text: "J'accepte la ",
                    style: TextStyle(
                      color: isDark ? ColorApp.tWhiteColor.withOpacity(0.8) : ColorApp.tBlackColor.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Politique de confidentialité",
                        style: TextStyle(
                          color: ColorApp.tsecondaryColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(RegisterController controllerForm, bool isDark) {
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
        child: ButtonCustom(
          text: TextApp.tRegister.toUpperCase(),
          textSize: 16,
          buttonBackgroundColor: Colors.transparent,
          onPressed: () => controllerForm.signup(),
        
        ),
      ),
    );
  }

  Widget _buildFooterSection(bool isDark, BuildContext context) {
    return FadeInAnimation(
      delay: 1.2,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Color(0xFF1A2332).withOpacity(0.5) : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextApp.tAlreadyHave,
              style: TextStyle(
                color: isDark ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Get.to(() => LoginScreen()),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorApp.tsecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: ColorApp.tsecondaryColor.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  TextApp.tLogin,
                  style: TextStyle(
                    color: ColorApp.tsecondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final offset = _getOffsetByDirection();
    _animation = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

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
          child: Opacity(
            opacity: _controller.value,
            child: child,
          ),
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
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

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
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}