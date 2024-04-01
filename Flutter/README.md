
# To generate "g" file run this command
flutter pub run build_runner build --delete-conflicting-outputs
# How to get model: 
https://app.quicktype.io
# http request online: 
https://jsonplaceholder.typicode.com



#How to change icon: 
1. pub dev : flutter_launcher_icons: ^0.11.0

2. Generate icon 
https://icon.kitchen

3. add icon into image folder

4. add into pubspec.yamal:
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icons/2.png"

4. run the command:
flutter pub run flutter_launcher_icons:main
