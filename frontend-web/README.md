# 약알 전문가 / 관리자 웹 어플리케이션

## 로컬 서버로 시작하기

---

1. 의존성 패키지 다운로드

```shell
npm i
```

2. 로컬 개발 서버 가동

```shell
npm run dev
```

3. 네트워크 개발 서버 가동

```shell
npm run dev -- --host
```

## Cooperation Rule

---

### Commit Convention

- feat : 새로운 기능 추가
- fix : 버그 수정
- docs : 문서 수정
- style : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
- refactor: 코드 리펙토링
- test: 테스트 코드, 리펙토링 테스트 코드 추가
- chore : 빌드 업무 수정, 패키지 매니저 수정

### Pull Request Convention

| 아이콘 | 코드                         | 설명              |
|-----|----------------------------|-----------------|
| 🎨  | :art                       | 코드의 구조/형태 개선    |
| ⚡️  | :zap                       | 성능 개선           |
| 🔥  | :fire                      | 코드/파일 삭제        |
| 🐛  | :bug                       | 버그 수정           |
| 🚑  | :ambulance                 | 긴급 수정           |
| ✨   | :sparkles                  | 새 기능            |
| 💄  | :lipstick                  | UI/스타일 파일 추가/수정 |
| ⏪   | :rewind                    | 변경 내용 되돌리기      |
| 🔀  | :twisted_rightwards_arrows | 브랜치 합병          |
| 💡  | :bulb                      | 주석 추가/수정        |
| 🗃  | :card_file_box             | 데이버베이스 관련 수정    |

## Design Pattern

![](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FI0Ia7%2FbtrEaN93m03%2FQvgBPWN6BlfR7dcRQ9g2a0%2Fimg.jpg)

* 소수의 컴포넌트에 종속된 로컬 데이터는 MVVM 패턴을 적용하여 데이터와 뷰를 분리

![](https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/1OLd/image/JHTtx7AD-xlDJHdutxQBnUdnXQo.png)

* 다수의 컴포넌트에 종속된 글로벌 데이터는 Redux를 활용한 MVI 패턴을 이용하여 데이터의 변화를 쉽게 반영할 수 있도록 함

## Styling Rule

* 본 프로젝트는 Styled-Component를 이용해 컴포넌트에 독립적으로 스타일링을 한다.
* `import * as S from "./global_style.ts"`의 형식으로 스타일 ts 파일을 import한다.
* 이로 인해 Styled Component와 Non-Styled Component가 구별된다.
* 또한 스타일된 HTMl 태그는 이름 맨 뒤에 어떤 태그인지 표시해야 한다.
* ex) `S.OuterFooter`는 스타일링된 `<footer>`, `WarningPage`는 일반 컴포넌트