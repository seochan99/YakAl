import { Header } from "@/layout/root/style";
import {
  KakaoSymbol,
  GoogleSymbol,
  KakaoText,
  Main,
  Outer,
  ButtonBox,
  KakaoButton,
  LoginTitle,
  GoogleButton,
  GoogleText,
  AppleButton,
  AppleSymbol,
  AppleText,
  InnerMain,
  LogoSection,
  LoginSection,
  Title,
  Subtitle,
  Description,
  TitleBox,
  BigLogo,
  LogoShade,
} from "./style";
import Logo from "@/layout/logo";
import Footer from "@/layout/footer";

export default function Login() {
  return (
    <Outer>
      <Header>
        <Logo hasBorder={false} path="/login" />
      </Header>
      <Main>
        <InnerMain>
          <LogoSection>
            <TitleBox>
              <Title>약 알</Title>
              <Subtitle>전문가 WEB</Subtitle>
            </TitleBox>
            <Description>쉽고 편한 환자관리 솔루션</Description>
            <BigLogo />
            <LogoShade />
          </LogoSection>
          <LoginSection>
            <LoginTitle>로그인</LoginTitle>
            <ButtonBox>
              <KakaoButton onClick={() => console.log("kakao!!!")}>
                <KakaoSymbol />
                <KakaoText>카카오로 로그인</KakaoText>
              </KakaoButton>
              <GoogleButton onClick={() => console.log("google!!!")}>
                <GoogleSymbol />
                <GoogleText>Google 계정으로 로그인</GoogleText>
              </GoogleButton>
              <AppleButton onClick={() => console.log("apple!!!")}>
                <AppleSymbol />
                <AppleText>Apple로 로그인</AppleText>
              </AppleButton>
            </ButtonBox>
          </LoginSection>
        </InnerMain>
      </Main>
      <Footer />
    </Outer>
  );
}
