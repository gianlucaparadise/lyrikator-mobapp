# Lyrikator

## Overview

Lyrikator is an application that lets you search songs by lyrics (using [Genius](https://genius.com/)). 
With Lyrikator you can:

* Use the search bar in the app to search lyrics
* Use the Google Assistant search saying "Ok Google, search Excuse while I kiss the sky on Lyrikator".

## Try it

### Android

Lyrikator for Android can be installed from the [Play Store](https://play.google.com/store/apps/details?id=com.gianlucaparadise.lyrikator).

### iOS

Lyrikator for iOS is fully working, but it has not been published yet because I can't afford the Apple Developer License 😢

## Tech notes

I used this project to test the capabilities of the following technologies:

* Flutter
* Dart
* Google assistant integration
* Genius API

## Dev notes

To run this application locally, you need to perform the following steps:

1. Clone the repository

```sh
git clone https://github.com/gianlucaparadise/lyrikator-mobapp.git && cd lyrikator-mobapp
```

2. Fill the example env file with your information

```sh
cp assets/config/secrets.example.json assets/config/secrets.json && vi assets/config/secrets.json # use your favorite editor instead of vi
```

### To Release

To release this application, you need to perform the following steps:

1. Generate or copy the keystore file in `android/app/`

2. Fill the example `key.properties` with your information:

```sh
cp android/key.example.properties android/key.properties && vi android/key.properties # use your favorite editor instead of vi
```

3. From the root of the project, run:

```sh
sh bundle-android.sh
```