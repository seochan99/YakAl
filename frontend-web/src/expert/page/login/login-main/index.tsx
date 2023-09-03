import axios, { HttpStatusCode, isAxiosError } from "axios";
import {
  BigLogo,
  ButtonBox,
  Description,
  GoogleButton,
  GoogleSymbol,
  GoogleText,
  InnerCenter,
  KakaoButton,
  KakaoSymbol,
  KakaoText,
  LoginSection,
  LoginTitle,
  LogoSection,
  LogoShade,
  Subtitle,
  Title,
  TitleBox,
} from "./style.ts";

function LoginMain() {
  const handleKakaoLoginClick = async () => {
    try {
      const response = await axios.get(`${import.meta.env.VITE_SERVER_HOST}/auth/kakao`);

      if (response.status === HttpStatusCode.Ok) {
        window.location.href = response.data.data.url;
      }
    } catch (error) {
      if (isAxiosError(error)) {
        console.log(error);
      }
    }
  };

  const handleGoogleLoginClick = async () => {
    try {
      const response = await axios.get(`${import.meta.env.VITE_SERVER_HOST}/auth/google`);

      if (response.status === HttpStatusCode.Ok) {
        window.location.href = response.data.data.url;
      }
    } catch (error) {
      if (isAxiosError(error)) {
        console.log(error);
      }
    }
  };

  return (
    <InnerCenter>
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
          <KakaoButton onClick={handleKakaoLoginClick}>
            <KakaoSymbol />
            <KakaoText>카카오로 로그인</KakaoText>
          </KakaoButton>
          <GoogleButton onClick={handleGoogleLoginClick}>
            <GoogleSymbol />
            <GoogleText>Google 계정으로 로그인</GoogleText>
          </GoogleButton>
        </ButtonBox>
      </LoginSection>
    </InnerCenter>
  );
}

export default LoginMain;
