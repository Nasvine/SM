import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_service/src/constants/colors.dart';
import 'package:smart_service/src/constants/sizes.dart';
import 'package:smart_service/src/utils/helpers/helper_function.dart';
import 'package:smart_service/src/utils/texts/text_custom.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  String _selectedLanguage = 'Français';
  String _selectedCurrency = 'FCFA';

  final List<String> _languages = ['Français', 'English', 'Español'];
  final List<String> _currencies = ['FCFA', 'EUR', 'USD', 'XOF'];

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Choisir la langue',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:
                    THelperFunctions.isDarkMode(context)
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            backgroundColor:
                THelperFunctions.isDarkMode(context)
                    ? ColorApp.tdarkColor
                    : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _languages[index],
                      style: TextStyle(
                        color:
                            THelperFunctions.isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    trailing:
                        _selectedLanguage == _languages[index]
                            ? Icon(Icons.check, color: ColorApp.tsecondaryColor)
                            : null,
                    onTap: () {
                      setState(() {
                        _selectedLanguage = _languages[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Choisir la devise',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:
                    THelperFunctions.isDarkMode(context)
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            backgroundColor:
                THelperFunctions.isDarkMode(context)
                    ? ColorApp.tdarkColor
                    : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _currencies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _currencies[index],
                      style: TextStyle(
                        color:
                            THelperFunctions.isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                    trailing:
                        _selectedCurrency == _currencies[index]
                            ? Icon(Icons.check, color: ColorApp.tsecondaryColor)
                            : null,
                    onTap: () {
                      setState(() {
                        _selectedCurrency = _currencies[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Déconnexion',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:
                    THelperFunctions.isDarkMode(context)
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            backgroundColor:
                THelperFunctions.isDarkMode(context)
                    ? ColorApp.tdarkColor
                    : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Text(
              'Êtes-vous sûr de vouloir vous déconnecter ?',
              style: TextStyle(
                color:
                    THelperFunctions.isDarkMode(context)
                        ? Colors.white70
                        : Colors.black54,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Annuler',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implémenter la déconnexion
                  Navigator.pop(context);
                  Get.offAllNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Déconnexion',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: isDark ? ColorApp.tdarkColor : ColorApp.tWhiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: TextCustom(
          TheText: "Paramètres",
          TheTextSize: 18,
          TheTextFontWeight: FontWeight.bold,
          TheTextColor: isDark ? Colors.white : Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête du profil
            /* _buildProfileHeader(isDark),
            
            const SizedBox(height: 32), */

            // Section Apparence
            _buildSectionTitle('Apparence', isDark),
            const SizedBox(height: 16),
            _buildThemeSwitchCard(isDark),

            const SizedBox(height: 24),

            // Section Préférences
            /* _buildSectionTitle('Préférences', isDark),
            const SizedBox(height: 16),
            _buildPreferencesSection(isDark), */

            const SizedBox(height: 24),

            // Section Compte
            _buildSectionTitle('Compte', isDark),
            const SizedBox(height: 16),
            _buildAccountSection(isDark),

            const SizedBox(height: 40),

            // Boutons d'action
            // _buildActionButtons(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorApp.tsecondaryColor.withOpacity(0.2),
              border: Border.all(color: ColorApp.tsecondaryColor, width: 2),
            ),
            child: Icon(
              Icons.person,
              size: 30,
              color: ColorApp.tsecondaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  TheText: "John Doe",
                  TheTextSize: 18,
                  TheTextFontWeight: FontWeight.bold,
                  TheTextColor: isDark ? Colors.white : Colors.black,
                ),
                const SizedBox(height: 4),
                TextCustom(
                  TheText: "john.doe@example.com",
                  TheTextSize: 14,
                  TheTextColor: isDark ? Colors.white70 : Colors.grey[600],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorApp.tsecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextCustom(
                    TheText: "Membre depuis 2024",
                    TheTextSize: 12,
                    TheTextColor: ColorApp.tsecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Naviguer vers l'édition du profil
            },
            icon: Icon(Icons.edit, color: ColorApp.tsecondaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextCustom(
        TheText: title,
        TheTextSize: 16,
        TheTextFontWeight: FontWeight.bold,
        TheTextColor: isDark ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildThemeSwitchCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ColorApp.tsecondaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            color: ColorApp.tsecondaryColor,
          ),
        ),
        title: TextCustom(
          TheText: 'Mode ${isDark ? 'Sombre' : 'Clair'}',
          TheTextSize: 16,
          TheTextFontWeight: FontWeight.w600,
          TheTextColor: isDark ? Colors.white : Colors.black,
        ),
        subtitle: TextCustom(
          TheText: isDark ? 'Thème sombre activé' : 'Thème clair activé',
          TheTextSize: 12,
          TheTextColor: isDark ? Colors.white60 : Colors.grey[600],
        ),
        trailing: Transform.scale(
          scale: 1.2,
          child: Switch(
            value: isDark,
            onChanged: (value) {
              setState(() {
                Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
                );
              });
            },
            activeColor: ColorApp.tsecondaryColor,
            activeTrackColor: ColorApp.tsecondaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(bool isDark) {
    return Column(
      children: [
        _buildSettingItem(
          icon: Iconsax.notification,
          title: 'Notifications',
          subtitle: 'Activer/désactiver les notifications',
          isDark: isDark,
          trailing: Switch(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            activeColor: ColorApp.tsecondaryColor,
          ),
        ),
      /*   _buildSettingItem(
          icon: Iconsax.finger_cricle,
          title: 'Authentification biométrique',
          subtitle: 'Déverrouiller avec empreinte/visage',
          isDark: isDark,
          trailing: Switch(
            value: _biometricEnabled,
            onChanged: (value) {
              setState(() {
                _biometricEnabled = value;
              });
            },
            activeColor: ColorApp.tsecondaryColor,
          ),
        ),
        _buildSettingItem(
          icon: Iconsax.language_circle,
          title: 'Langue',
          subtitle: _selectedLanguage,
          isDark: isDark,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark ? Colors.white60 : Colors.grey[600],
          ),
          onTap: _showLanguageDialog,
        ),
        _buildSettingItem(
          icon: Iconsax.dollar_circle,
          title: 'Devise',
          subtitle: _selectedCurrency,
          isDark: isDark,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark ? Colors.white60 : Colors.grey[600],
          ),
          onTap: _showCurrencyDialog,
        ), */
      ],
    );
  }

  Widget _buildAccountSection(bool isDark) {
    return Column(
      children: [
        _buildSettingItem(
          icon: Iconsax.security_user,
          title: 'Sécurité du compte',
          subtitle: 'Modifier mot de passe, 2FA',
          isDark: isDark,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark ? Colors.white60 : Colors.grey[600],
          ),
          onTap: () {},
        ),
        _buildSettingItem(
          icon: Icons.privacy_tip,
          title: 'Confidentialité',
          subtitle: 'Gérer vos données',
          isDark: isDark,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark ? Colors.white60 : Colors.grey[600],
          ),
          onTap: () {},
        ),
        _buildSettingItem(
          icon: Icons.help,
          title: 'Centre d\'aide',
          subtitle: 'FAQ et support',
          isDark: isDark,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark ? Colors.white60 : Colors.grey[600],
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ColorApp.tsecondaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ColorApp.tsecondaryColor, size: 20),
        ),
        title: TextCustom(
          TheText: title,
          TheTextSize: 16,
          TheTextFontWeight: FontWeight.w600,
          TheTextColor: isDark ? Colors.white : Colors.black,
        ),
        subtitle: TextCustom(
          TheText: subtitle,
          TheTextSize: 12,
          TheTextColor: isDark ? Colors.white60 : Colors.grey[600],
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _buildActionButtons(bool isDark) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Sauvegarder les paramètres
              Get.snackbar(
                'Succès',
                'Paramètres sauvegardés',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorApp.tsecondaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Sauvegarder les paramètres',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _showLogoutDialog,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: Colors.red.withOpacity(0.5)),
            ),
            child: Text(
              'Se déconnecter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
