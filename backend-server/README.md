# YakAl REST API SERVER

* Java 버전: Java 17
* 프레임워크: Spring Boot 3.1.1
* DBMS: mysql
  
| 속성 | 값 |
| --- | --- |
| innodb_version | 5.7.42 |
| protocol_version | 10 |
| slave_type_conversions |  |
| tls_version | TLSv1, TLSv1.1, TLSv1.2 |
| version | 5.7.42-0ubuntu0.18.04.1 (Ubuntu) |
| version_compile_machine | x86_64 |
| version_compile_os | Linux |
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

## QueryDsl

* Q Class 생성

```sh
./gradlew compileJava
```

## 협업 규칙
> 1. PR 시 본인이 받지 않는다.
> 2. Commit 및 PR은 <a href =https://github.com/View-Pharm/YakAl/wiki#%ED%98%91%EC%97%85>협업 규칙<a/>을 따른다.
> 3. 도메인형 구조를 따른다.

## 사용한 라이브러리
1. **Spring Boot Framework**
    - [org.springframework.boot:spring-boot-starter-data-jpa](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-jpa-and-spring-data)
    - [org.springframework.boot:spring-boot-starter-oauth2-client](https://spring.io/guides/tutorials/spring-boot-oauth2/)
    - [org.springframework.boot:spring-boot-starter-security](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-security)
    - [org.springframework.boot:spring-boot-starter-webflux](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-webflux)
    - [org.springframework.boot:spring-boot-starter-web](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-developing-web-applications)
2. **JSON Web Tokens (JWT)**
    - [io.jsonwebtoken:jjwt-api:0.11.5](https://github.com/jwtk/jjwt)
    - [jakarta.xml.bind:jakarta.xml.bind-api:4.0.0](https://jakarta.ee/specifications/xml-bind/4.0/)
3. **Validation**
    - [com.google.code.findbugs:jsr305:3.0.2](https://github.com/find-sec-bugs/find-sec-bugs)
    - [org.springframework.boot:spring-boot-starter-validation](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-validation)
4. **OpenAPI**
    - [org.springdoc:springdoc-openapi-starter-webmvc-ui:2.1.0](https://springdoc.org/)
5. **Spring REST Docs**
    - [org.springframework.restdocs:spring-restdocs-mockmvc](https://docs.spring.io/spring-restdocs/docs/current/reference/html5/)
    - [com.epages:restdocs-api-spec:0.17.1](https://github.com/ePages-de/restdocs-api-spec)
    - [com.epages:restdocs-api-spec-mockmvc:0.17.1](https://github.com/ePages-de/restdocs-api-spec-mockmvc)
    - [org.springframework.restdocs:spring-restdocs-asciidoctor](https://docs.spring.io/spring-restdocs/docs/current/reference/html5/)
6. **Apache Commons IO**
    - [commons-io:commons-io:2.13.0](https://commons.apache.org/proper/commons-io/)
7. **Bouncy Castle**
    - [org.bouncycastle:bcpkix-jdk18on:1.72](https://www.bouncycastle.org/)
8. **Firebase**
    - [com.google.firebase:firebase-admin:9.2.0](https://firebase.google.com/docs/admin/setup)
9. **IOS Push**
    - [com.squareup.okhttp3:okhttp:4.10.0](https://square.github.io/okhttp/)
    - [org.drjekyll:javapns:2.4.2](https://github.com/jeffgortmaker/JavaPNS)
10. **Schedule Lock**
    - [net.javacrumbs.shedlock:shedlock-spring:5.6.0](https://github.com/lukas-krecan/ShedLock)
    - [net.javacrumbs.shedlock:shedlock-provider-jdbc-template:5.6.0](https://github.com/lukas-krecan/ShedLock)
11. **Testing**
    - [junit:junit:4.13.1](https://junit.org/junit4/)
    - [org.springframework.boot:spring-boot-starter-test](https://docs.spring.io/spring-boot/docs/current/reference/html5/#boot-features-testing)
    - [org.springframework.security:spring-security-test](https://spring.io/guides/gs/securing-web/)
12. **Lombok**
    - [org.projectlombok:lombok](https://projectlombok.org/)
13. **MYSQL Driver**
    - [com.mysql:mysql-connector-j](https://dev.mysql.com/downloads/connector/j/)
14. **Configuration Metadata**
    - [org.springframework.boot:spring-boot-configuration-processor](https://docs.spring.io/spring-boot/docs/current/reference/html5/#configuration-metadata-annotation-processor)
15. **Excel**
    - [org.apache.poi:poi:5.0.0](https://poi.apache.org/)
    - [org.apache.poi:poi-ooxml:5.0.0](https://poi.apache.org/)
16. **Geometry**
    - [org.locationtech.jts:jts-core:1.16.1](https://locationtech.github.io/jts/)
    - [org.hibernate:hibernate-spatial:6.2.2.Final](https://hibernate.org/spatial/)
