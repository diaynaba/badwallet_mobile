# BadWallet Mobile

Application mobile Flutter réalisée dans le cadre de l'examen Flutter L3 S2 2026.

## Technologies

- Flutter
- Dart
- Provider
- HTTP
- Spring Boot REST API

## Fonctionnalités

- Splash Screen
- Authentification par numéro de téléphone
- Consultation du solde
- Consultation de l'historique
- Transfert d'argent
- Paiement de factures (prévu)

## API

Backend Spring Boot

```
http://localhost:8080
```

Emulateur Android

```
http://10.0.2.2:8080
```

## Build

```
flutter pub get

flutter run

flutter build apk --release
```

APK généré :

```
build/app/outputs/flutter-apk/app-release.apk
```