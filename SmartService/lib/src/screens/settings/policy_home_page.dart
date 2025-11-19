/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/screens/tabs.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PrivacyPolicyOwnerHomePage extends StatelessWidget {
  const PrivacyPolicyOwnerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Politique de Confidentialité'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            LineAwesomeIcons.angle_left_solid,
            color: isDark ? ColorApp.tWhiteColor : ColorApp.tBlackColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            SectionTitle('Dernière mise à jour : 02 août 2025'),
            SizedBox(height: 20),

            SectionTitle('1. Introduction'),
            SectionContent(
              'Bienvenue dans l\'application CarRentalOwner, conçue pour les propriétaires de véhicules souhaitant gérer leur activité de location. '
              'Cette politique de confidentialité explique comment nous collectons, utilisons, stockons et protégeons vos données personnelles.',
            ),

            SectionTitle('2. Données collectées'),
            SectionSubTitle('a) Propriétaires de véhicules :'),
            BulletPoint('Nom et prénom'),
            BulletPoint('Adresse e-mail'),
            BulletPoint('Numéro de téléphone'),
            BulletPoint('Mot de passe (crypté)'),
            BulletPoint('Connexion via email/mot de passe ou Google'),
            BulletPoint('Informations sur les véhicules (modèle, marque, prix)'),
            BulletPoint('Historique des réservations'),
            BulletPoint('Messages échangés avec les clients'),

            SectionTitle('3. Utilisation des données'),
            SectionContent(
              'Vos données sont utilisées pour :\n\n'
              '- Créer et gérer votre compte propriétaire\n'
              '- Ajouter, modifier ou supprimer vos véhicules\n'
              '- Communiquer avec les clients\n'
              '- Gérer les réservations reçues\n'
              '- Confirmer les paiements via Kkiapay\n'
              '- Envoyer des notifications (réservations, paiements, messages)\n'
              '- Garantir la sécurité et la fiabilité de l\'application',
            ),

            SectionTitle('4. Paiement'),
            SectionContent(
              'Les paiements sont assurés par notre partenaire Kkiapay, une solution sécurisée de Mobile Money. '
              'CarRentalOwner ne stocke aucune information bancaire : toutes les transactions sont sécurisées directement par Kkiapay.',
            ),

            SectionTitle('5. Partage des données'),
            SectionContent(
              'Nous ne partageons vos informations personnelles que dans les cas suivants :\n\n'
              '- Lorsqu\'un client réserve un véhicule, certaines informations (nom, téléphone) sont transmises à ce client\n'
              '- En cas d\'obligation légale ou à la demande d\'une autorité compétente\n',
            ),

            SectionTitle('6. Sécurité des données'),
            SectionContent(
              'Toutes vos données sont stockées sur Firebase avec les garanties suivantes :\n\n'
              '- Authentification via Firebase Auth\n'
              '- Données enregistrées dans Firestore avec des règles de sécurité strictes\n\n'
              'Nous nous engageons à mettre en œuvre des pratiques de sécurité avancées pour protéger vos informations.',
            ),

            SectionTitle('7. Vos droits'),
            SectionContent(
              'En tant qu\'utilisateur, vous avez le droit de :\n\n'
              '- Accéder à vos données personnelles\n'
              '- Corriger toute information inexacte\n'
              '- Supprimer votre compte à tout moment\n\n'
              'Pour exercer ces droits, contactez : nassara.kevine@gmail.com',
            ),

            SectionTitle('8. Durée de conservation'),
            SectionContent(
              'Vos données sont conservées aussi longtemps que votre compte est actif. En cas de suppression, vos données seront supprimées dans un délai raisonnable.',
            ),

            SectionTitle('9. Consentement'),
            SectionContent(
              'En utilisant CarRentalOwner, vous acceptez cette politique de confidentialité. '
              'Si vous n’êtes pas en accord, veuillez ne pas utiliser l\'application.',
            ),

            SectionTitle('10. Modifications'),
            SectionContent(
              'Cette politique peut évoluer. Toute modification significative sera affichée dans l\'application.',
            ),

            SectionTitle('11. Contact'),
            SectionContent('Pour toute question ou préoccupation concernant la confidentialité :'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email : vinenassara@gmail.com',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                SizedBox(height: 4),
                Text(
                  'Téléphone : +229 01 91 003 606',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),

            SizedBox(height: 30),
            Center(
              child: Text(
                'Merci d\'utiliser CarRentalOwner 🚗',
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
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class SectionSubTitle extends StatelessWidget {
  final String text;
  const SectionSubTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String text;
  const SectionContent(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      child: Text(text, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
} */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/screens/tabs.dart';

class PrivacyPolicyOwnerHomePage extends StatelessWidget {
  const PrivacyPolicyOwnerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Color(0xFF0F1419) : Colors.grey[50],
      appBar: _buildAppBar(isDark),
      body: const AnimatedPrivacyPolicyContent(),
    );
  }

  AppBar _buildAppBar(bool isDark) {
    return AppBar(
      title: const Text(
        'Politique de Confidentialité',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Get.back();
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

class AnimatedPrivacyPolicyContent extends StatefulWidget {
  const AnimatedPrivacyPolicyContent({super.key});

  @override
  State<AnimatedPrivacyPolicyContent> createState() => _AnimatedPrivacyPolicyContentState();
}

class _AnimatedPrivacyPolicyContentState extends State<AnimatedPrivacyPolicyContent> {
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
            // Header avec badge de mise à jour
            _buildHeaderSection(isDark),
            
            const SizedBox(height: 25),

            // Sections de contenu
            _buildContentSections(isDark),

            // Footer avec remerciement
            _buildFooterSection(isDark),
          ],
        ),

        // Bouton scroll to top flottant amélioré
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Color(0xFF1E88E5).withOpacity(0.1), Color(0xFF0D47A1).withOpacity(0.05)]
                : [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.blue.withOpacity(0.3) : Colors.blue.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorApp.tsecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: ColorApp.tsecondaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Dernière mise à jour',
                    style: TextStyle(
                      color: ColorApp.tsecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '02 août 2025',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSections(bool isDark) {
    return Column(
      children: [
        _buildAnimatedSection(
          index: 0,
          title: '1. Introduction',
          content: 'Bienvenue dans SmartService, une application mobile conçue pour faciliter la gestion de livraisons et de courses de colis. '
              'Cette politique de confidentialité décrit comment nous collectons, utilisons, protégeons et partageons vos informations personnelles '
              'lorsque vous utilisez l\'application en tant que client ou livreur.',
          icon: Icons.security_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 1,
          title: '2. Données collectées',
          icon: Icons.data_usage_rounded,
          isDark: isDark,
          children: [
            const SectionSubTitle('a) Données utilisateur :'),
            AnimatedBulletList([
              'Nom et prénom',
              'Adresse e-mail',
              'Numéro de téléphone',
              'Mot de passe (crypté)',
              'Connexion via email/mot de passe ou Google',
              'Adresse de retrait et adresse de livraison',
              'Type de colis et numéro à contacter',
              'Historique des courses et paiements',
              'Conversations avec les livreurs',
              'Position GPS pour le suivi en temps réel',
            ]),
          ],
        ),

        _buildAnimatedSection(
          index: 2,
          title: '3. Utilisation des données',
          content: 'Les informations collectées sont utilisées pour :\n\n'
              '- Créer et gérer votre compte utilisateur\n'
              '- Permettre la commande et le suivi des courses\n'
              '- Calculer automatiquement la distance et le prix\n'
              '- Faciliter la communication entre client et livreur\n'
              '- Assurer le paiement sécurisé par Mobile Money ou en espèces\n'
              '- Envoyer des notifications concernant le statut de la livraison\n'
              '- Améliorer nos services et garantir la sécurité des transactions',
          icon: Icons.analytics_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 3,
          title: '4. Paiement',
          content: 'Les paiements sont effectués via Mobile Money (MoMo) ou en espèces à la réception du colis. '
              'SmartService ne stocke aucune information bancaire : les transactions sont gérées de manière sécurisée '
              'par les fournisseurs de paiement partenaires.',
          icon: Icons.payment_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 4,
          title: '5. Partage des données',
          content: 'Vos informations ne sont partagées qu\'en cas de nécessité, notamment :\n\n'
              '- Avec le livreur pour exécuter la commande (nom, téléphone, adresses)\n'
              '- Avec les prestataires de services de paiement pour finaliser les transactions\n'
              '- En cas d\'obligation légale ou de demande des autorités compétentes\n\n'
              'Nous ne vendons ni ne louons vos données à des tiers.',
          icon: Icons.share_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 5,
          title: '6. Sécurité des données',
          content: 'Vos données sont hébergées et protégées sur Firebase, bénéficiant de mesures de sécurité strictes :\n\n'
              '- Authentification sécurisée via Firebase Auth\n'
              '- Données enregistrées dans Firestore avec règles de sécurité\n'
              '- Chiffrement des informations sensibles\n\n'
              'Nous mettons en œuvre des pratiques techniques et organisationnelles pour protéger vos informations contre toute perte, utilisation abusive ou accès non autorisé.',
          icon: Icons.lock_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 6,
          title: '7. Vos droits',
          content: 'En tant qu\'utilisateur, vous disposez des droits suivants :\n\n'
              '- Accéder à vos données personnelles\n'
              '- Modifier ou corriger vos informations\n'
              '- Supprimer votre compte à tout moment\n'
              '- Refuser l\'utilisation de vos données à des fins de communication\n\n'
              'Pour exercer ces droits, contactez-nous à : vinenassara@gmail.com',
          icon: Icons.gpp_good_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 7,
          title: '8. Durée de conservation',
          content: 'Vos données sont conservées tant que votre compte reste actif. '
              'En cas de suppression de compte, toutes vos informations personnelles seront définitivement supprimées dans un délai raisonnable.',
          icon: Icons.schedule_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 8,
          title: '9. Géolocalisation',
          content: 'L\'application utilise la géolocalisation uniquement pour calculer la distance, le tarif et permettre le suivi en temps réel du livreur. '
              'Vous pouvez désactiver cette fonctionnalité depuis les paramètres de votre appareil, mais certaines fonctions peuvent alors ne pas fonctionner correctement.',
          icon: Icons.location_on_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 9,
          title: '10. Consentement',
          content: 'En utilisant SmartService, vous acceptez notre politique de confidentialité. '
              'Si vous n\'êtes pas d\'accord avec l\'un des points mentionnés, veuillez ne pas utiliser l\'application.',
          icon: Icons.thumb_up_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 10,
          title: '11. Modifications de la politique',
          content: 'Cette politique de confidentialité peut être mise à jour à tout moment. '
              'Toute modification majeure sera communiquée directement dans l\'application ou par notification.',
          icon: Icons.update_rounded,
          isDark: isDark,
        ),

        _buildAnimatedSection(
          index: 11,
          title: '12. Contact',
          icon: Icons.contact_support_rounded,
          isDark: isDark,
          children: [
            const SectionContent('Pour toute question ou réclamation relative à la confidentialité :'),
            FadeInAnimation(
              delay: 12 * 0.1 + 0.3,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.05) : Colors.blue.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    ContactInfoItem(
                      icon: Icons.email_rounded,
                      text: 'Email : vinenassara@gmail.com',
                      isDark: isDark,
                    ),
                    const SizedBox(height: 12),
                    ContactInfoItem(
                      icon: Icons.phone_rounded,
                      text: 'Téléphone : +229 01 91 003 606',
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedSection({
    required int index,
    required String title,
    required bool isDark,
    String? content,
    List<Widget>? children,
    IconData? icon,
  }) {
    return FadeInAnimation(
      delay: (index + 1) * 0.1,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête de section avec icône
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null)
                  Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.only(right: 12, top: 2),
                    decoration: BoxDecoration(
                      color: ColorApp.tsecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 18,
                      color: ColorApp.tsecondaryColor,
                    ),
                  ),
                Expanded(
                  child: SectionTitle(title),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Contenu
            if (content != null) SectionContent(content),
            if (children != null) ...children!,
          ],
        ),
      ),
    );
  }

  Widget _buildFooterSection(bool isDark) {
    return FadeInAnimation(
      delay: 13 * 0.1,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 40),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Color(0xFF1E88E5).withOpacity(0.1), Color(0xFF0D47A1).withOpacity(0.05)]
                : [ColorApp.tsecondaryColor.withOpacity(0.05), ColorApp.tsecondaryColor.withOpacity(0.02)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? ColorApp.tsecondaryColor.withOpacity(0.2) : ColorApp.tsecondaryColor.withOpacity(0.1),
          ),
        ),
        child: const ThankYouMessage(),
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

  const AnimatedBulletList(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        for (int i = 0; i < items.length; i++)
          FadeInAnimation(
            delay: 0.05 * i,
            child: Container(
              margin: const EdgeInsets.only(bottom: 6),
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
                        fontSize: 15,
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

class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: ColorApp.tsecondaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: ColorApp.tsecondaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class ThankYouMessage extends StatelessWidget {
  const ThankYouMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        Icon(
          Icons.rocket_launch_rounded,
          size: 48,
          color: ColorApp.tsecondaryColor,
        ),
        const SizedBox(height: 16),
        Text(
          'Merci d\'utiliser SmartService 🚚',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ColorApp.tsecondaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Votre confiance est notre priorité absolue',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: isDark ? Colors.white.withOpacity(0.7) : Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

// Classes existantes améliorées
class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }
}

class SectionSubTitle extends StatelessWidget {
  final String text;
  const SectionSubTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
        ),
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String text;
  const SectionContent(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          height: 1.6,
          color: isDark ? Colors.white.withOpacity(0.8) : Colors.black87,
        ),
      ),
    );
  }
}