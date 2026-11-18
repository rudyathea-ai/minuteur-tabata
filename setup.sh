#!/usr/bin/env bash
# Prépare le projet Android. À lancer une fois, depuis ce dossier.
# Prérequis : Node.js 20+, Java (JDK 17+) et Android Studio installés.
set -e

# ID d'application AdMob. Celui-ci est un ID de TEST de Google.
# Remplacez-le par le vôtre (forme ca-app-pub-XXXX~YYYY) avant de publier.
ADMOB_APP_ID="ca-app-pub-3940256099942544~3347511713"

npm install @capacitor/core @capacitor/cli @capacitor/android \
            @capacitor-community/admob @capacitor-community/keep-awake

[ -d android ] || npx cap add android

# AdMob exige son ID d'application dans le manifeste, sinon l'appli plante au lancement.
MANIFEST=android/app/src/main/AndroidManifest.xml
if ! grep -q "com.google.android.gms.ads.APPLICATION_ID" "$MANIFEST"; then
  sed -i "s#</application>#        <meta-data android:name=\"com.google.android.gms.ads.APPLICATION_ID\" android:value=\"$ADMOB_APP_ID\"/>\n    </application>#" "$MANIFEST"
fi

npx cap sync android
echo "Terminé. Ouvrez le projet avec : npx cap open android"
