# Minuteur Tabata : projet Android (Capacitor)

Technologie : page web (HTML/JS) emballée dans une application Android avec Capacitor.
Publicité : Google AdMob (bannière en bas). Écran maintenu allumé pendant la séance.

## 1. Prérequis
- Node.js 20 ou plus récent
- Android Studio (il installe le JDK et le SDK Android)

## 2. Préparer le projet
    ./setup.sh
Le script installe Capacitor et les modules, crée le dossier `android/`,
ajoute l'ID AdMob au manifeste et synchronise la page web.

Après chaque modification de `www/index.html` : `npx cap sync android`.

## 3. Lancer sur un téléphone
    npx cap open android
Dans Android Studio : branchez un téléphone (mode développeur + débogage USB)
ou lancez un émulateur, puis bouton « Run ». La bannière affichée est une annonce de TEST.

## 4. Personnaliser avant publication
1. **Identifiant** : changez `appId` dans `capacitor.config.json` (ex. `fr.monnom.minuteurtabata`).
   À faire AVANT `./setup.sh` : il ne peut plus changer ensuite sans effort.
2. **Icône** : placez `assets/icon-only.png` (1024x1024), puis `npx @capacitor/assets generate --android`.
3. **AdMob** (https://admob.google.com) :
   - créez l'application et une unité « Bannière » ;
   - dans `setup.sh`, remplacez `ADMOB_APP_ID` (ou modifiez directement `AndroidManifest.xml`) ;
   - dans `www/index.html`, remplacez `ADMOB_BANNER_ID` et mettez `ADMOB_TEST = false`.
   Laissez `ADMOB_BANNER_ID` vide pour désactiver toute publicité.
4. **Version** : `versionCode` et `versionName` dans `android/app/build.gradle`
   (à augmenter à chaque envoi d'une mise à jour).

## 5. Fabriquer le fichier pour le Play Store (AAB signé)
Dans Android Studio : Build > Generate Signed App Bundle / APK > Android App Bundle.
Créez une clé de signature et SAUVEGARDEZ le fichier .jks et ses mots de passe.
Sans eux, vous ne pourrez plus mettre l'application à jour.
Le fichier obtenu est un `.aab` à envoyer dans la Play Console.

## 6. Play Console (https://play.google.com/console)
- Compte développeur (frais d'inscription uniques de 25 $).
- Créez l'application, envoyez le .aab (piste test interne d'abord).
- Fiche : titre, description, icône 512x512, image de présentation 1024x500, 2 captures d'écran min.
- Politique de confidentialité : une URL publique est obligatoire (l'appli utilise des pubs).
- Section « Sécurité des données » et « Contenu publicitaire » : déclarez l'utilisation d'AdMob.
- Les comptes personnels récents doivent souvent passer par un test fermé avant la production :
  vérifiez les exigences actuelles dans la Play Console.
- Google relève régulièrement le niveau d'API Android exigé : utilisez les dernières versions de Capacitor
  (`npm install @capacitor/android@latest`) si la console signale un problème.

## À savoir
- Le chrono se base sur l'horloge : il reste juste même si l'écran se verrouille.
  Les bips peuvent toutefois être coupés par Android en arrière-plan.
- Le consentement RGPD (formulaire Google) s'affiche automatiquement dans l'Espace économique européen.

## Option sans installation : fabriquer l'APK avec GitHub
1. Créez un compte gratuit sur github.com et un nouveau dépôt.
2. Envoyez-y tout le contenu de ce dossier (y compris `.github/`), branche `main`.
3. Onglet « Actions », workflow « Construire l'APK », bouton « Run workflow ».
4. Après quelques minutes, ouvrez l'exécution terminée et téléchargez l'artefact
   `minuteur-tabata-apk` (un zip contenant `app-debug.apk`).
5. Envoyez l'APK sur le téléphone et installez-le. C'est un APK de test, pas pour le Play Store.
