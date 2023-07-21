# YakAl REST API SERVER

* Java 버전: Java 17
* 프레임워크: Spring Boot 3.1.1
* DBMS: mysql
* 요구사항
  1. `application-dev.yml` 내에 있는 대괄호 빈칸(`[]`) 채우기 (DB 설정은 주석으로 설명되어 있음, jwt.secret은 임의의 문자열로 설정)
  2. 개발 중에는 프로젝트 실행 구성에서 "활성화된 프로파일"을 "dev"로 설정해야 함

## 시작하기

* 빌드 (Build project)

```sh
./gradlew clean build
```

* Spring REST Docs 생성

```sh
./gradlew clean doctest
```

* 생성된 REST Docs 확인

```url
build/docs/index.html
```

* 애플리케이션 실행(테스트 -> 문서 생성 -> 빌드)

```sh
./gradlew apibuild
cd build/libs
java -jar application.jar
```

* [http://localhost:8080/api-docs.html](http://localhost:8080/api-docs.html)로 접속하여
 Swagger UI로 포멧팅된 API 문서를 열람할 수 있음


## 협업 규칙
> 1. PR 시 본인이 받지 않는다.
> 2. Commit 및 PR은 아래 Role을 따른다.
> 3. 계층형 구조를 따른다.

### Commit Convention

-   feat : 새로운 기능 추가
-   fix : 버그 수정
-   docs : 문서 수정
-   style : 코드 포맷팅, 세미콜론 누락, 코드 변경이 없는 경우
-   refactor: 코드 리펙토링
-   test: 테스트 코드, 리펙토링 테스트 코드 추가
-   chore : 빌드 업무 수정, 패키지 매니저 수정

### Pull Request Convention

| 아이콘 | 코드                       | 설명                     |
| ------ | -------------------------- | ------------------------ |
| 🎨     | :art                       | 코드의 구조/형태 개선    |
| ⚡️    | :zap                       | 성능 개선                |
| 🔥     | :fire                      | 코드/파일 삭제           |
| 🐛     | :bug                       | 버그 수정                |
| 🚑     | :ambulance                 | 긴급 수정                |
| ✨     | :sparkles                  | 새 기능                  |
| 💄     | :lipstick                  | UI/스타일 파일 추가/수정 |
| ⏪     | :rewind                    | 변경 내용 되돌리기       |
| 🔀     | :twisted_rightwards_arrows | 브랜치 합병              |
| 💡     | :bulb                      | 주석 추가/수정           |
| 🗃      | :card_file_box             | 데이버베이스 관련 수정   |
