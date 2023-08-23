import axios, { HttpStatusCode, isAxiosError } from "axios";
import {
  AppleButton,
  AppleSymbol,
  AppleText,
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
} from "./style";

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
    </InnerCenter>
  );
}

export default LoginMain;
