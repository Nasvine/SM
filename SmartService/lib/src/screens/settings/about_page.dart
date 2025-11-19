/* import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/screens/tabs.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AboutOwnerPage extends StatelessWidget {
  const AboutOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos de CarRentalOwner'),
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => TabsScreen(initialIndex: 3));
          },
          icon: Icon(
            LineAwesomeIcons.angle_left_solid,
            color: isDark
                ? ColorApp.tWhiteColor
                : ColorApp.tBlackColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'CarRentalOwner',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ColorApp.tsecondaryColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'CarRentalOwner est l’application mobile dédiée aux propriétaires de véhicules souhaitant gérer leur activité de location. Elle permet de publier des voitures, fixer les prix par jour, discuter avec les clients, gérer les marques, accepter les réservations et confirmer les paiements via MoMo.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Fonctionnalités clés :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            bulletPoint('Inscription par email, mot de passe ou Google'),
            bulletPoint('Ajout de voitures avec prix journalier'),
            bulletPoint('Création et gestion de marques'),
            bulletPoint('Chat intégré avec les clients'),
            bulletPoint('Réception des commandes'),
            bulletPoint('Confirmation du paiement MoMo via KKiaPay'),
            bulletPoint('Notifications en temps réel'),
            const SizedBox(height: 20),
            const Text(
              'Une contribution pour un service durable 🔧',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorApp.tsecondaryColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Certaines fonctionnalités avancées peuvent être soumises à une contribution symbolique dans le futur. Cette contribution permettra de maintenir un service fiable, sécurisé et en constante amélioration.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: ColorApp.tsecondaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pourquoi une contribution ? 💡',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ColorApp.tsecondaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Cela nous permet de :',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                  SizedBox(height: 8),
                  Text('• Garantir la disponibilité du service'),
                  Text('• Sécuriser les données de vos véhicules et clients'),
                  Text('• Intégrer des outils avancés de gestion'),
                  Text('• Offrir un support rapide en cas de souci'),
                  Text('• Déployer des mises à jour régulières'),
                  SizedBox(height: 10),
                  Text(
                    'Merci pour votre confiance et votre collaboration 🤝',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: ColorApp.tsecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Développé par :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            infoLine('Nom', 'NASSARA Kévine'),
            infoLine('Métier', 'Développeur mobile Flutter (Android & iOS)'),
            infoLine('Pays', 'Bénin'),
            const SizedBox(height: 20),
            const Text(
              'Technologies utilisées :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            bulletPoint('Flutter'),
            bulletPoint('Dart'),
            bulletPoint('Firebase (Auth, Firestore, Cloud Functions)'),
            bulletPoint('Kkiapay (paiement Mobile Money)'),
            const SizedBox(height: 20),
            const Text(
              'Version de l\'application :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Version 1.0.0', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Merci d\'utiliser CarRentalOwner ❤️',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: ColorApp.tsecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget bulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 18)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
      ],
    );
  }

  static Widget infoLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label : ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
 */

import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AboutOwnerPage extends StatelessWidget {
  const AboutOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Color(0xFF0F1419) : Colors.grey[50],
      appBar: _buildAppBar(isDark),
      body: const AnimatedAboutContent(),
    );
  }

  AppBar _buildAppBar(bool isDark) {
    return AppBar(
      title: const Text(
        'À propos de SmartService',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Get.offAll(() => TabsScreen(initialIndex: 3));
        },
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
          ),
          child: Icon(
            LineAwesomeIcons.angle_left_solid,
            color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
            size: 20,
          ),
        ),
      ),
      elevation: 0,
      scrolledUnderElevation: 4,
      backgroundColor: Colors.transparent,
      foregroundColor: isDark ? Colors.white : Colors.black,
    );
  }
}

class AnimatedAboutContent extends StatefulWidget {
  const AnimatedAboutContent({super.key});

  @override
  State<AnimatedAboutContent> createState() => _AnimatedAboutContentState();
}

class _AnimatedAboutContentState extends State<AnimatedAboutContent> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 300 && !_showScrollToTop) {
      setState(() => _showScrollToTop = true);
    } else if (_scrollController.offset <= 300 && _showScrollToTop) {
      setState(() => _showScrollToTop = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Stack(
      children: [
        // Fond décoratif
        _buildBackground(isDark),
        
        ListView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            // Header avec logo et titre
            _buildHeaderSection(isDark),
            
            const SizedBox(height: 25),

            // Description principale
            _buildDescriptionSection(isDark),

            // Fonctionnalités clés
            _buildFeaturesSection(isDark),

            // Section solution moderne
            _buildModernSolutionSection(isDark),

            // Notre engagement
            _buildCommitmentSection(isDark),

            // Développeur
            _buildDeveloperSection(isDark),

            // Technologies
            _buildTechnologiesSection(isDark),

            // Version
            _buildVersionSection(isDark),

            // Footer avec remerciement
            _buildFooterSection(isDark),
          ],
        ),

        // Bouton scroll to top flottant
        _buildFloatingActionButton(isDark),
      ],
    );
  }

  Widget _buildBackground(bool isDark) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    Color(0xFF0F1419),
                    Color(0xFF1A2129),
                    Color(0xFF0F1419),
                  ]
                : [
                    Colors.white,
                    Colors.grey[50]!,
                    Colors.white,
                  ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isDark) {
    return FadeInAnimation(
      delay: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Color(0xFF1E88E5).withOpacity(0.1), Color(0xFF0D47A1).withOpacity(0.05)]
                : [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? Colors.blue.withOpacity(0.3) : Colors.blue.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: ColorApp.tsecondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.rocket_launch_rounded,
                size: 30,
                color: ColorApp.tsecondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'SmartService',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: ColorApp.tsecondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Votre partenaire de livraison intelligent',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.1,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Text(
          'SmartService est une application mobile conçue pour faciliter la gestion des livraisons et des courses de colis. '
          'Elle permet aux clients d\'indiquer facilement le point de retrait et de livraison sur la carte, de connaître automatiquement le prix et la distance, '
          'et de suivre le livreur en temps réel jusqu\'à la réception du colis. '
          'Les paiements peuvent être effectués par Mobile Money (MoMo) ou en espèces.',
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: isDark ? Colors.white.withOpacity(0.8) : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.2,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: ColorApp.tsecondaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.star_rounded,
                    size: 18,
                    color: ColorApp.tsecondaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Fonctionnalités clés',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AnimatedBulletList([
              'Connexion via email, mot de passe ou compte Google',
              'Choix du point de retrait et de livraison sur la carte',
              'Calcul automatique du prix et de la distance',
              'Système de notification lorsqu\'un livreur accepte la course',
              'Suivi de la position du livreur en temps réel',
              'Chat intégré entre client et livreur',
              'Paiement sécurisé par MoMo ou en espèces',
              'Notation et avis après chaque livraison',
            ], isDark: isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildModernSolutionSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.3,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Color(0xFF4CAF50).withOpacity(0.1), Color(0xFF2E7D32).withOpacity(0.05)]
                : [Color(0xFFE8F5E8), Color(0xFFC8E6C9)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.green.withOpacity(0.3) : Colors.green.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.flash_on_rounded,
                  size: 24,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Une solution moderne pour vos livraisons 🚚',
                    maxLines: 2,
                    style: TextStyle(
                      
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'SmartService simplifie la gestion des livraisons pour les particuliers et les entreprises. '
              'L\'objectif est d\'offrir un service rapide, fiable et sécurisé, tout en permettant aux livreurs de travailler en toute autonomie.',
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: isDark ? Colors.white.withOpacity(0.8) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitmentSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.4,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Color(0xFFFF9800).withOpacity(0.1), Color(0xFFF57C00).withOpacity(0.05)]
                : [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.orange.withOpacity(0.3) : Colors.orange.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.verified_user_rounded,
                  size: 24,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Notre engagement 💡',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Nous nous engageons à :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            AnimatedBulletList([
              'Offrir une expérience fluide et intuitive',
              'Garantir la sécurité des paiements et des données',
              'Améliorer en continu les performances de l\'application',
              'Assurer une communication transparente entre client et livreur',
              'Proposer un support réactif en cas de besoin',
            ], isDark: isDark),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Merci pour votre confiance et votre fidélité 🤝',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.5,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    size: 18,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Développé par',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard('👨‍💻 Nom', 'NASSARA Kévine', isDark),
            const SizedBox(height: 8),
            _buildInfoCard('💼 Métier', 'Développeur mobile Flutter (Android & iOS)', isDark),
            const SizedBox(height: 8),
            _buildInfoCard('🇧🇯 Pays', 'Bénin', isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white.withOpacity(0.8) : Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologiesSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.6,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.code_rounded,
                    size: 18,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Technologies utilisées',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTechChip('Flutter', Colors.blue),
                _buildTechChip('Dart', Colors.blueAccent),
                _buildTechChip('Firebase', Colors.orange),
                _buildTechChip('Google Maps', Colors.red),
                _buildTechChip('MoMo API', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        tech,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildVersionSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.7,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_rounded,
                size: 18,
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Version de l\'application',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 15,
                      color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[700],
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

  Widget _buildFooterSection(bool isDark) {
    return FadeInAnimation(
      delay: 0.8,
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 40),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorApp.tsecondaryColor.withOpacity(0.1),
              ColorApp.tsecondaryColor.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ColorApp.tsecondaryColor.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.favorite_rounded,
              size: 40,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Merci d\'utiliser SmartService ❤️',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: ColorApp.tsecondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Votre satisfaction est notre plus grande récompense',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(bool isDark) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 400),
        offset: _showScrollToTop ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: _showScrollToTop ? 1.0 : 0.0,
          child: InkWell(
            onTap: _scrollToTop,
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorApp.tsecondaryColor,
                    ColorApp.tsecondaryColor.withOpacity(0.8),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorApp.tsecondaryColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
      ),
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
          offset: Offset(0, 30 * (1 - _animation.value)),
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

class AnimatedBulletList extends StatelessWidget {
  final List<String> items;
  final bool isDark;

  const AnimatedBulletList(this.items, {super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < items.length; i++)
          FadeInAnimation(
            delay: 0.05 * i,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 12),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: ColorApp.tsecondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      items[i],
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}