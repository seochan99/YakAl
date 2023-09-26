import * as S from "./style.ts";
import { useLoginMainPageViewController } from "./view.controller.ts";
import { Alert, Slide, SlideProps, Snackbar } from "@mui/material";

function LoginMainPage() {
  const {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, onClose },
  } = useLoginMainPageViewController();

  return (
    <S.OuterDiv>
      <S.ServiceIntroDiv>
        <S.TextDiv>
          <S.TitleDiv>
            <S.TitleSpan>{"약 알"}</S.TitleSpan>
            <S.SubtitleSpan>{"전문가 WEB"}</S.SubtitleSpan>
          </S.TitleDiv>
          <S.DescriptionSpan>{"쉽고 편한 환자관리 솔루션"}</S.DescriptionSpan>
        </S.TextDiv>
        <S.LogoDiv>
          <S.LogoImg />
          <S.StyledLogoShadeSvg />
        </S.LogoDiv>
      </S.ServiceIntroDiv>
      <S.LoginDiv>
        <S.LoginTitleSpan>{"로그인"}</S.LoginTitleSpan>
        <S.InnerButtonsDiv>
          <S.KakaoButton onClick={onKakaoLoginClick}>
            <S.StyledKakaoIconSvg />
            <S.ButtonTextSpan>{"카카오로 로그인"}</S.ButtonTextSpan>
          </S.KakaoButton>
          <S.GoogleButton onClick={onGoogleLoginClick}>
            <S.StyledGoogleSymbol />
            <S.ButtonTextSpan>{"Google로 로그인"}</S.ButtonTextSpan>
          </S.GoogleButton>
        </S.InnerButtonsDiv>
      </S.LoginDiv>
      <Snackbar
        open={open}
        autoHideDuration={4000}
        onClose={onClose}
        anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
        TransitionComponent={(props: SlideProps) => <Slide {...props} direction="up" children={props.children} />}
      >
        <Alert onClose={onClose} severity="error" elevation={6} variant="filled">
          {"로그인 화면으로 이동하는데 실패했습니다. 다시 시도해주세요."}
        </Alert>
      </Snackbar>
    </S.OuterDiv>
  );
}

export default LoginMainPage;
