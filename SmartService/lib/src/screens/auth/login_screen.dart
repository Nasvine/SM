/* 
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

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerForm = Get.put(LoginController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
               /*  HeaderCloseCustom(
                  isDark: isDark,
                  headerIcon1: Icons.arrow_back_sharp,
                  headerText: "",
                ),
                const SizedBox(height: 20), */

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: 100,
                      width: 100,
                      child: Image.network("https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/smart-service-49ew28/assets/uoxtvrh4smpk/Logo_smart.png"),
                    )
                  ],
                ),

                const SizedBox(height: 20),
                TextCustom(
                  TheText: "tWelcomeLogin".tr,
                  TheTextSize: THelperFunctions.w(context, 0.05),
                  TheTextFontWeight: FontWeight.bold,
                  TheTextColor:
                      THelperFunctions.isDarkMode(context)
                          ? ColorApp.tWhiteColor
                          : ColorApp.tBlackColor,
                ),
                const SizedBox(height: tFormHeight - 20),
                TextCustom(
                  TheText: "tWelcomeLogin1".tr,
                  TheTextSize: THelperFunctions.w(context, 0.04),
                  TheTextFontWeight: FontWeight.normal,
                  TheTextColor:
                      THelperFunctions.isDarkMode(context)
                          ? ColorApp.tWhiteColor
                          : ColorApp.tBlackColor,
                ),
                const SizedBox(height: tFormHeight - 20),
                TextCustom(
                  TheText: "tWelcomeLogin2".tr,
                  TheTextSize: THelperFunctions.w(context, 0.04),
                  TheTextFontWeight: FontWeight.normal,
                  TheTextColor:
                      THelperFunctions.isDarkMode(context)
                          ? ColorApp.tWhiteColor
                          : ColorApp.tBlackColor,
                ),
                const SizedBox(height: tFormHeight - 20),
                Form(
                  key: controllerForm.formKeyLogin,
                  child: Column(
                    children: [
                      TextFormFieldSimpleCustom(
                        
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        borderRadiusBorder: 10,
                        cursorColor:
                            THelperFunctions.isDarkMode(context)
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
                        labelStyleColor:
                            THelperFunctions.isDarkMode(context)
                                ? ColorApp.tWhiteColor
                                : ColorApp.tBlackColor,
                        hintText: TextApp.tEmail,
                        hintStyleColor:
                            THelperFunctions.isDarkMode(context)
                                ? ColorApp.tWhiteColor
                                : ColorApp.tBlackColor,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color:
                              THelperFunctions.isDarkMode(context)
                                  ? ColorApp.tWhiteColor
                                  : ColorApp.tBlackColor,
                        ),
                        validator: (value) => TValidator.validateEmail(value),
                      ),

                      const SizedBox(height: tFormHeight - 10),
                      Obx(
                        () => TextFormFieldSimpleCustom(
                          
                          keyboardType: TextInputType.text,
                          controller: controllerForm.password,
                          obscureText: controllerForm.hidePassword.value,
                          borderRadiusBorder: 10,
                          cursorColor:
                              THelperFunctions.isDarkMode(context)
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
                          labelText: TextApp.tPassword,
                          labelStyleColor:
                              THelperFunctions.isDarkMode(context)
                                  ? ColorApp.tWhiteColor
                                  : ColorApp.tBlackColor,
                          hintText: TextApp.tPassword,
                          hintStyleColor:
                              THelperFunctions.isDarkMode(context)
                                  ? ColorApp.tWhiteColor
                                  : ColorApp.tBlackColor,
                          prefixIcon: Icon(
                            Icons.fingerprint,
                            color:
                                THelperFunctions.isDarkMode(context)
                                    ? ColorApp.tWhiteColor
                                    : ColorApp.tBlackColor,
                          ),
                          suffixIcon: IconButton(
                            onPressed:
                                () =>
                                    controllerForm.hidePassword.value =
                                        !controllerForm.hidePassword.value,
                            icon: Icon(
                              controllerForm.hidePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          validator:
                              (value) => TValidator.validatePassword(value),
                        ),
                      ),
                      const SizedBox(height: tFormHeight - 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /*  Row(
                            children: [
                              /*  Checkbox(value: false, onChanged: (g) {}), */
                              TextCustom(
                                TheText: TextApp.tRemerberMe,
                                TheTextSize: THelperFunctions.w(context, 0.03),
                                TheTextColor:
                                    THelperFunctions.isDarkMode(context)
                                        ? ColorApp.tWhiteColor
                                        : ColorApp.tBlackColor,
                              ),
                            ],
                          ), */
                          TextButton(
                            onPressed:
                                () => Get.to(() => ForgetPasswordScreen()),
                            child: TextCustom(
                              TheText: TextApp.tForgetPassword,
                              TheTextSize: THelperFunctions.w(context, 0.04),
                              TheTextColor: ColorApp.tsecondaryColor,
                              TheTextFontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      ButtonCustom(
                        text: TextApp.tLogin,
                        textSize: 15,
                        buttonBackgroundColor: ColorApp.tsecondaryColor,
                        onPressed:
                            () => controllerForm.emailAndPasswordSignIn(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: tFormHeight - 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('OR', textAlign: TextAlign.center),
                    SizedBox(height: tFormHeight - 20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => controllerForm.googleSignIn(),
                        icon: Image.asset(
                          ImageApp.tGoogleLogoImage,
                          width: 20.0,
                        ),
                        label: Text(
                          TextApp.tSignWithGoogle,
                          style: TextStyle(color: ColorApp.tsecondaryColor),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          foregroundColor: ColorApp.tWhiteColor,
                          // side: BorderSide(color: ColorApp.tBlackColor)
                        ),
                      ),
                    ),
                    SizedBox(height: tFormHeight),

                    GestureDetector(
                      onTap: () => Get.to(() => RegisterScreen()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            TextApp.tAlreadyHaveAnAccount,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(width: tFormHeight - 20),
                          Text(
                            TextApp.tRegister,
                            style: TextStyle(
                              color: ColorApp.tsecondaryColor,
                              fontSize: THelperFunctions.w(context, 0.04),
                              fontWeight: FontWeight.bold,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerForm = Get.put(LoginController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [Color(0xFF0A0E14), Color(0xFF1A2332), Color(0xFF0F1419)]
                : [Color(0xFFF8FAFD), Color(0xFFEFF3F9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(
              top: 40,
              left: 25,
              right: 25,
              bottom: 30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header animé
                _buildAnimatedHeader(isDark, context),

                const SizedBox(height: 30),

                // Logo avec animation
                _buildLogoSection(isDark),

                const SizedBox(height: 30),

                // Titres avec animations séquentielles
                _buildTitleSection(isDark, context),

                const SizedBox(height: 40),

                // Formulaire avec animations
                _buildFormSection(controllerForm, isDark, context),

                const SizedBox(height: 30),

                // Section sociale avec animations
                _buildSocialSection(controllerForm, isDark, context),

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

  Widget _buildAnimatedHeader(bool isDark, BuildContext context) {
    return SlideInAnimation(
      delay: 0,
      direction: SlideDirection.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton retour avec effet
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
                size: 20,
              ),
            ),
          ),

          // Titre discret
          TextCustom(
            TheText: "Connexion",
            TheTextSize: THelperFunctions.w(context, 0.045),
            TheTextFontWeight: FontWeight.w600,
            TheTextColor: isDark
                ? ColorApp.tWhiteColor.withOpacity(0.8)
                : ColorApp.tBlackColor.withOpacity(0.7),
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
        width: 120,
        height: 120,
        padding: const EdgeInsets.all(20),
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
              ),
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
            TheTextSize: THelperFunctions.w(context, 0.06),
            TheTextFontWeight: FontWeight.w800,
            TheTextColor: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
        const SizedBox(height: 12),
        FadeInAnimation(
          delay: 0.3,
          child: TextCustom(
            TheText: "tWelcomeLogin1".tr,
            TheTextSize: THelperFunctions.w(context, 0.04),
            TheTextFontWeight: FontWeight.w400,
            TheTextColor: isDark
                ? ColorApp.tWhiteColor.withOpacity(0.8)
                : ColorApp.tBlackColor.withOpacity(0.7),
            TheTextAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        FadeInAnimation(
          delay: 0.4,
          child: TextCustom(
            TheText: "tWelcomeLogin2".tr,
            TheTextSize: THelperFunctions.w(context, 0.04),
            TheTextFontWeight: FontWeight.w400,
            TheTextColor: isDark
                ? ColorApp.tWhiteColor.withOpacity(0.8)
                : ColorApp.tBlackColor.withOpacity(0.7),
            TheTextAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection(
    LoginController controllerForm,
    bool isDark,
    BuildContext context,
  ) {
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
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: isDark
                ? Colors.blue.shade800.withOpacity(0.3)
                : Colors.blue.shade100,
          ),
        ),
        child: Form(
          key: controllerForm.formKeyLogin,
          child: Column(
            children: [
              // Champ email
              FadeInAnimation(
                delay: 0.6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormFieldSimpleCustom(
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    borderRadiusBorder: 15,
                    cursorColor: isDark
                        ? ColorApp.tWhiteColor
                        : ColorApp.tBlackColor,
                    borderSideRadiusBorder: Colors.transparent,
                    borderRadiusFocusedBorder: 15,
                    borderSideRadiusFocusedBorder: ColorApp.tsecondaryColor,
                    controller: controllerForm.email,
                    labelText: TextApp.tEmail,
                    labelStyleColor: isDark
                        ? ColorApp.tWhiteColor.withOpacity(0.7)
                        : ColorApp.tBlackColor.withOpacity(0.6),
                    hintText: TextApp.tEmail,
                    hintStyleColor: isDark
                        ? ColorApp.tWhiteColor.withOpacity(0.5)
                        : ColorApp.tBlackColor.withOpacity(0.4),
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(left: 15, right: 10),
                      child: Icon(
                        Icons.email_outlined,
                        color: isDark
                            ? ColorApp.tWhiteColor.withOpacity(0.7)
                            : ColorApp.tBlackColor.withOpacity(0.6),
                      ),
                    ),

                    validator: (value) => TValidator.validateEmail(value),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Champ mot de passe
              FadeInAnimation(
                delay: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Obx(
                    () => TextFormFieldSimpleCustom(
                      keyboardType: TextInputType.text,
                      controller: controllerForm.password,
                      obscureText: controllerForm.hidePassword.value,
                      borderRadiusBorder: 15,
                      cursorColor: isDark
                          ? ColorApp.tWhiteColor
                          : ColorApp.tBlackColor,
                      borderSideRadiusBorder: Colors.transparent,
                      borderRadiusFocusedBorder: 15,
                      borderSideRadiusFocusedBorder: ColorApp.tsecondaryColor,
                      labelText: TextApp.tPassword,
                      labelStyleColor: isDark
                          ? ColorApp.tWhiteColor.withOpacity(0.7)
                          : ColorApp.tBlackColor.withOpacity(0.6),
                      hintText: TextApp.tPassword,
                      hintStyleColor: isDark
                          ? ColorApp.tWhiteColor.withOpacity(0.5)
                          : ColorApp.tBlackColor.withOpacity(0.4),
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(left: 15, right: 10),
                        child: Icon(
                          Icons.fingerprint,
                          color: isDark
                              ? ColorApp.tWhiteColor.withOpacity(0.7)
                              : ColorApp.tBlackColor.withOpacity(0.6),
                        ),
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () => controllerForm.hidePassword.value =
                              !controllerForm.hidePassword.value,
                          icon: Icon(
                            controllerForm.hidePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: isDark
                                ? ColorApp.tWhiteColor.withOpacity(0.7)
                                : ColorApp.tBlackColor.withOpacity(0.6),
                          ),
                        ),
                      ),

                      validator: (value) => TValidator.validatePassword(value),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Mot de passe oublié
              FadeInAnimation(
                delay: 0.8,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.to(() => ForgetPasswordScreen()),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: TextCustom(
                      TheText: TextApp.tForgetPassword,
                      TheTextSize: THelperFunctions.w(context, 0.035),
                      TheTextColor: ColorApp.tsecondaryColor,
                      TheTextFontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Bouton de connexion
              FadeInAnimation(
                delay: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: ColorApp.tsecondaryColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ButtonCustom(
                    text: TextApp.tLogin,
                    textSize: 16,
                    buttonBackgroundColor: Colors.transparent,
                    onPressed: () => controllerForm.emailAndPasswordSignIn(),
                    /*  gradient: LinearGradient(
                      colors: [
                        ColorApp.tsecondaryColor,
                        ColorApp.tsecondaryColor.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: 15,
                    elevation: 0, */
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialSection(
    LoginController controllerForm,
    bool isDark,
    BuildContext context,
  ) {
    return Column(
      children: [
        // Séparateur
        FadeInAnimation(
          delay: 1.0,
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  color: isDark
                      ? Colors.white.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.4),
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'OU',
                  style: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.5)
                        : Colors.grey.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: isDark
                      ? Colors.white.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.4),
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Bouton Google
        FadeInAnimation(
          delay: 1.1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => controllerForm.googleSignIn(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: isDark ? Color(0xFF1A2332) : Colors.white,
                  foregroundColor: isDark
                      ? Colors.white
                      : ColorApp.tsecondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageApp.tGoogleLogoImage,
                      width: 22.0,
                      height: 22.0,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      TextApp.tSignWithGoogle,
                      style: TextStyle(
                        color: isDark ? Colors.white : ColorApp.tsecondaryColor,
                        fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildFooterSection(bool isDark, BuildContext context) {
    return FadeInAnimation(
      delay: 1.2,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? Color(0xFF1A2332).withOpacity(0.5)
              : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: GestureDetector(
          onTap: () => Get.to(() => RegisterScreen()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                TextApp.tAlreadyHaveAnAccount,
                style: TextStyle(
                  color: isDark
                      ? Colors.white.withOpacity(0.7)
                      : Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                TextApp.tRegister,
                style: TextStyle(
                  color: ColorApp.tsecondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
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
