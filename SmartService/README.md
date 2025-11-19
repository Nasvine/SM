# 🚚 SmartService – Application Mobile de Gestion de Courses et Livraisons

## 📱 À propos du projet

**SmartService** est une application mobile innovante développée pour faciliter la **gestion des livraisons et courses** entre clients et livreurs.
L’objectif est d’offrir une solution simple, rapide et sécurisée permettant aux utilisateurs de **commander un service de livraison**, de **suivre le livreur en temps réel**, et de **payer facilement** via **Mobile Money** ou en espèces.

---

## 🧩 Fonctionnalités principales

### 🔐 Authentification

* Connexion via **email et mot de passe**
* Connexion rapide via **Google**

### 📦 Gestion des courses

* Saisie de l’**adresse de retrait** et de l’**adresse de livraison** directement sur une **carte interactive (Google Maps)**
* Indication du **type de colis** et du **numéro de contact** au point de retrait
* Calcul **automatique du prix et de la distance** entre les deux points
* Possibilité de **confirmer** ou **abandonner** la course (avec motif d’annulation)

### 🚴‍♂️ Suivi en temps réel

* Notification envoyée dès qu’un livreur **accepte la course**
* **Chat intégré** entre le client et le livreur
* **Suivi de la position en direct** du livreur sur la carte

### 💳 Paiement & évaluation

* Paiement **Mobile Money (MoMo)** ou **en espèces**
* Évaluation et **avis client** après la livraison

---

## 🛠️ Technologies utilisées

| Catégorie            | Technologie                                           |
| -------------------- | ----------------------------------------------------- |
| **Framework mobile** | Flutter                                               |
| **Backend**          | Firebase (Firestore, Authentication, Cloud Messaging) |
| **API Map**          | Google Maps API                                       |
| **Paiement**         | Mobile Money API                                      |
| **Gestion d’état**   | GetX                                                  |
| **Notifications**    | Firebase Cloud Messaging (FCM)                        |

---

## 📲 Expérience utilisateur

1. L’utilisateur crée ou se connecte à son compte
2. Il saisit les informations de sa livraison
3. Le système calcule la distance et le tarif
4. Il confirme la commande
5. Un livreur accepte la course → le client reçoit une notification
6. Le client suit la position du livreur et communique avec lui
7. À la livraison, le client valide la réception et procède au paiement
8. Il donne une note et un avis sur le service

---

## 🔔 Notifications

Les notifications en temps réel sont gérées via **Firebase Cloud Messaging**, permettant d’informer le client :

* lorsqu’un livreur accepte sa course,
* à l’arrivée du livreur,
* et à la fin de la livraison.

---

## 💡 Valeur ajoutée

SmartService apporte :

* Une **solution complète** pour gérer les livraisons de proximité
* Une **meilleure communication** entre client et livreur
* Un **suivi transparent** et en temps réel des colis
* Des **paiements rapides et sécurisés**

---

## 👨‍💻 Auteur

**Développé par :** Kévine NASSARA (alias NASSARA Rock)
**Rôle :** Mobile Fullstack Developer (Flutter & Firebase)
**Contact :** [LinkedIn](#) | [Email](#) | [GitHub](#)

---


