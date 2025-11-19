import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/screens/auth/login_screen.dart';
import 'package:smart_service/src/utils/texts/button_custom.dart';
import 'package:smart_service/src/utils/texts/text_custom.dart';

class OnboardingStartScreen extends StatefulWidget {
  @override
  _OnboardingStartScreenState createState() => _OnboardingStartScreenState();
}

class _OnboardingStartScreenState extends State<OnboardingStartScreen>
    with SingleTickerProviderStateMixin {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        gradient: isActive 
            ? LinearGradient(
                colors: [ColorApp.tPrimaryColor, ColorApp.tsecondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [Color(0xffD6D6D6).withOpacity(0.5), Color(0xffD6D6D6)],
              ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: ColorApp.tPrimaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                )
              ]
            : [],
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFFF8F9FA),
                Color(0xFFE3F2FD).withOpacity(0.3),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Header avec bouton passer
                _buildHeader(),
                
                // PageView principal
                Expanded(
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: <Widget>[
                      _buildOnboardingPage(
                        image: 'assets/Img1.jpg',
                        title: 'Livrez tout, partout',
                        description: 'Des colis aux repas, SmartServices vous accompagne partout',
                        icon: Icons.local_shipping_rounded,
                      ),
                      _buildOnboardingPage(
                        image: 'assets/Image3.jpg',
                        title: 'Un suivi en direct',
                        description: 'Gardez un œil sur votre livraison à chaque instant',
                        icon: Icons.gps_fixed_rounded,
                      ),
                      _buildOnboardingPage(
                        image: 'assets/Image1.jpg',
                        title: 'Vos courses en un clic',
                        description: 'Faites vos achats au marché ou au supermarché sans vous déplacer',
                        icon: Icons.shopping_cart_rounded,
                      ),
                      _buildOnboardingPage(
                        image: 'assets/Image4.jpg',
                        title: 'SmartServices, partout avec vous',
                        description: 'Une seule application pour tout livrer, simplement',
                        icon: Icons.rocket_launch_rounded,
                      ),
                    ],
                  ),
                ),
                
                // Indicateurs et bouton
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_currentPage != _numPages - 1)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ColorApp.tPrimaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () {
                  _pageController.animateToPage(
                    _numPages - 1,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextCustom(
                      TheText: 'Passer',
                      TheTextSize: 14,
                      TheTextColor: ColorApp.tPrimaryColor,
                      TheTextFontWeight: FontWeight.w600,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: ColorApp.tPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(_scaleAnimation.value)
            ..translate(0.0, (1 - _fadeAnimation.value) * 50),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Illustration avec effet de profondeur
            Stack(
              alignment: Alignment.center,
              children: [
                // Fond décoratif
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ColorApp.tPrimaryColor.withOpacity(0.1),
                        ColorApp.tsecondaryColor.withOpacity(0.05),
                      ],
                      stops: [0.1, 1.0],
                    ),
                  ),
                ),
                
                // Image principale
                Hero(
                  tag: 'onboarding-$image',
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(125),
                      boxShadow: [
                        BoxShadow(
                          color: ColorApp.tPrimaryColor.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(125),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                
                // Badge avec icône
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: ColorApp.tPrimaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 60),
            
            // Titre avec animation
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: TextCustom(
                TheText: title,
                TheTextSize: 24,
                TheTextFontWeight: FontWeight.w800,
                TheTextColor: Color(0xFF2D3748),
                TheTextAlign: TextAlign.center,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Description avec animation
            AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.easeOut,
              child: TextCustom(
                TheText: description,
                TheTextSize: 16,
                TheTextColor: Color(0xFF718096),
                TheTextMaxLines: 3,
                TheTextAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          )
        ],
      ),
      child: Column(
        children: [
          // Indicateurs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          
          SizedBox(height: 30),
          
          // Bouton d'action
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scale(_currentPage == _numPages - 1 ? 1.05 : 1.0),
            child: ButtonCustom(
              onPressed: () {
                if (_currentPage == _numPages - 1) {
                  // Animation de transition vers le login
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var curve = Curves.easeInOut;
                        var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
                        
                        return FadeTransition(
                          opacity: animation.drive(tween),
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 800),
                    ),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                }
              },
              text: _currentPage != _numPages - 1 ? 'Suivant' : 'Commencer',
              textSize: 16,
              buttonBackgroundColor: ColorApp.tPrimaryColor,
             
            ),
          ),
          
          SizedBox(height: 10),
          
          // Texte secondaire pour la dernière page
          if (_currentPage == _numPages - 1)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextCustom(
                  TheText: 'Rejoignez notre communauté de confiance',
                  TheTextSize: 12,
                  TheTextColor: Color(0xFF718096),
                  TheTextFontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}