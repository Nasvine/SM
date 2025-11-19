/* 
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/constants/texts.dart';
import 'package:smart_service/src/controllers/auth/ForgetPasswordController.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:smart_service/src/utils/validators/validator.dart';
import 'package:smart_service/src/utils/widget_theme/header_close_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_custom/text_custom.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final controllerForm = Get.put(ForgetPasswordController());
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
                  headerIcon1: Icons.arrow_back_sharp,
                  headerText: "",
                ),
                const SizedBox(height: 20),
                TextCustom(
                  TheText: TextApp.tForgetPassword,
                  TheTextSize: THelperFunctions.w(context, 0.04),
                  TheTextFontWeight: FontWeight.bold,
                  TheTextColor:
                      THelperFunctions.isDarkMode(context)
                          ? ColorApp.tWhiteColor
                          : ColorApp.tBlackColor,
                ),

                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCustom(
                      TheText: "tForgetLongText".tr,
                      TheTextSize: THelperFunctions.w(context, 0.03),
                      TheTextFontWeight: FontWeight.normal,
                      TheTextColor:
                          THelperFunctions.isDarkMode(context)
                              ? ColorApp.tWhiteColor
                              : ColorApp.tBlackColor,
                      TheTextMaxLines: 4
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: controllerForm.forgetPasswordFormKeyLogin,
                  child: Column(
                    children: [
                      TextFormFieldSimpleCustom(
                       
                        keyboardType: TextInputType.emailAddress,
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

                      const SizedBox(height: tFormHeight),
                      ButtonCustom(
                        text: TextApp.tSend,
                        textSize: 15,
                        buttonBackgroundColor: ColorApp.tsecondaryColor,
                        onPressed:
                            () => controllerForm.sendPasswordResetEmail(),
                      ),
                    ],
                  ),
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

import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/constants/texts.dart';
import 'package:smart_service/src/controllers/auth/ForgetPasswordController.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/text_form_field_simple_custom.dart';
import 'package:smart_service/src/utils/validators/validator.dart';
import 'package:smart_service/src/utils/widget_theme/header_close_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_custom/text_custom.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final controllerForm = Get.put(ForgetPasswordController());

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
                
                const SizedBox(height: 30),
                
                // Icône principale avec animation
                _buildMainIcon(isDark),
                
                const SizedBox(height: 25),
                
                // Titres avec animations séquentielles
                _buildTitleSection(isDark, context),
                
                const SizedBox(height: 30),
                
                // Formulaire avec animations
                _buildFormSection(controllerForm, isDark, context),
                
                const SizedBox(height: 25),
                
                // Informations supplémentaires
                _buildInfoSection(isDark),
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
          // Bouton retour avec effet
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
                Icons.arrow_back_ios_rounded,
                color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
                size: 20,
              ),
            ),
          ),
          
          // Titre discret
          TextCustom(
            TheText: "Mot de passe oublié",
            TheTextSize: 16,
            TheTextFontWeight: FontWeight.w600,
            TheTextColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.8) : ColorApp.tBlackColor.withOpacity(0.7),
          ),
          
          // Espaceur
          const SizedBox(width: 45),
        ],
      ),
    );
  }

  Widget _buildMainIcon(bool isDark) {
    return FadeInAnimation(
      delay: 0.1,
      child: Container(
        width: 120,
        height: 120,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    Color(0xFFEF4444).withOpacity(0.8),
                    Color(0xFFDC2626).withOpacity(0.6),
                    Color(0xFF991B1B).withOpacity(0.4),
                  ]
                : [
                    Color(0xFFEF4444),
                    Color(0xFFF87171),
                    Color(0xFFFCA5A5),
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.red.shade900.withOpacity(0.4) : Colors.red.shade300.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
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
          child: Icon(
            Icons.lock_reset_rounded,
            size: 40,
            color: Color(0xFFEF4444),
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
            TheText: TextApp.tForgetPassword,
            TheTextSize: 18,
            TheTextFontWeight: FontWeight.w800,
            TheTextColor: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
        const SizedBox(height: 16),
        FadeInAnimation(
          delay: 0.3,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Color(0xFF1A2332).withOpacity(0.5) : Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.1),
              ),
            ),
            child: TextCustom(
              TheText: "tForgetLongText".tr,
              TheTextSize: 15,
              TheTextFontWeight: FontWeight.w400,
              TheTextColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.8) : ColorApp.tBlackColor.withOpacity(0.7),
              TheTextAlign: TextAlign.center,
              TheTextMaxLines: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection(ForgetPasswordController controllerForm, bool isDark, BuildContext context) {
    return SlideInAnimation(
      delay: 0.4,
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
          key: controllerForm.forgetPasswordFormKeyLogin,
          child: Column(
            children: [
              // Titre section email
              FadeInAnimation(
                delay: 0.5,
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                        ),
                      ),
                      child: Icon(
                        Icons.email_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Votre adresse email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Champ email
              FadeInAnimation(
                delay: 0.6,
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
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    borderRadiusBorder: 15,
                    cursorColor: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
                    borderSideRadiusBorder: Colors.transparent,
                    borderRadiusFocusedBorder: 15,
                    borderSideRadiusFocusedBorder: ColorApp.tsecondaryColor,
                    controller: controllerForm.email,
                    labelText: TextApp.tEmail,
                    labelStyleColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.7) : ColorApp.tBlackColor.withOpacity(0.6),
                    hintText: "exemple@email.com",
                    hintStyleColor: isDark ? ColorApp.tWhiteColor.withOpacity(0.5) : ColorApp.tBlackColor.withOpacity(0.4),
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(left: 15, right: 10),
                      child: Icon(
                        Icons.alternate_email_rounded,
                        color: isDark ? ColorApp.tWhiteColor.withOpacity(0.7) : ColorApp.tBlackColor.withOpacity(0.6),
                      ),
                    ),
                    validator: (value) => TValidator.validateEmail(value),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Bouton d'envoi - CORRIGÉ : Suppression de Obx() inutile
              FadeInAnimation(
                delay: 0.7,
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
                    text: TextApp.tSend,
                    textSize: 16,
                    buttonBackgroundColor: Colors.transparent,
                    onPressed: () => controllerForm.sendPasswordResetEmail(),
                   
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.8,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Color(0xFF1A2332).withOpacity(0.5) : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isDark ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.1),
              ),
              child: Icon(
                Icons.info_rounded,
                color: Colors.green,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Instructions importantes",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Un lien de réinitialisation vous sera envoyé par email. Vérifiez votre boîte de réception et vos spams.",
                    style: TextStyle(
                      color: isDark ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
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