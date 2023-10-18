# 🌿 AI를 이용한 복약 도움 플랫폼, 약 알

## 🤔 This Repo?

AI를 이용한 복약 도움 플랫폼, 약 알 Front Flutter Repository입니다.

## 🛠️ How do I build it?

### 0️⃣ 만약 Flutter 기본 셋팅이 안되어 있나요?

그러면 아래 공식 문서를 참고해봐요!

> -   [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
> -   [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

### 1️⃣ 환경변수 설정

> frontend-hybrid/yakal/assets/config/.env 경로에 .env파일 생성

```
KAKAO_NATIVE_APP_KEY = YOUR KAKAO KEY
IDENTIFICATION_MID = YOUR PASS KEY
YAKAL_SERVER_HOST = YOUR SERVER
KIMS_SERVER_HOST = YOUR KIMS SERVER
KIMS_SERVER_USERNAME = YOUR KIMS SERVER USERNAME 
KIMS_SERVER_PASSWORD = YOUR KIMS SERVER PASSWORD
```

를 설정해준다.

### 1️⃣ 실행

```
flutter run // 플러터 실행
```

을 통해서 실행해주자

### 2️⃣ 실행이 안될때

#### 1. flutter ERROR

```dart
flutter clean // 플러터 의존성 제거
flutter pub get  // 의존성 패키지 재설치
```

을 통해서 플러터 의존성을 다시 받아주자.

#### 2. iOS ERROR

```dart
cd ios // ios 폴더 이동
rm -rf Podfile.lock // Podfile.lock 제거
pod install --repo-update // 의존성 패키지 재설치

```
