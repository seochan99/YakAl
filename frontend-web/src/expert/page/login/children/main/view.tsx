import * as S from "./style.ts";
import { useLoginMainPageViewController } from "./view.controller.ts";
import { Snackbar } from "@mui/material";

function LoginMainPage() {
  const {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, onClose, actionComponent },
  } = useLoginMainPageViewController();

  return (
    <S.InnerCenter>
      <S.LogoSection>
        <S.TitleBox>
          <S.Title>{"약 알"}</S.Title>
          <S.Subtitle>{"전문가 WEB"}</S.Subtitle>
        </S.TitleBox>
        <S.Description>{"쉽고 편한 환자관리 솔루"}션</S.Description>
        <S.BigLogo />
        <S.LogoShade />
      </S.LogoSection>
      <S.LoginSection>
        <S.LoginTitle>{"로그인"}</S.LoginTitle>
        <S.ButtonBox>
          <S.KakaoButton onClick={onKakaoLoginClick}>
            <S.KakaoSymbol />
            <S.KakaoText>{"카카오로 로그인"}</S.KakaoText>
          </S.KakaoButton>
          <S.GoogleButton onClick={onGoogleLoginClick}>
            <S.GoogleSymbol />
            <S.GoogleText>{"Google로 로그인"}</S.GoogleText>
          </S.GoogleButton>
        </S.ButtonBox>
      </S.LoginSection>
      <Snackbar
        open={open}
        autoHideDuration={6000}
        onClose={onClose}
        message="Note archived"
        action={actionComponent}
      />
    </S.InnerCenter>
  );
}

export default LoginMainPage;
