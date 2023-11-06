import * as S from "./style.ts";
import { useLoginMainPageViewController } from "./view.controller.ts";
import { ESnackbarType } from "@type/enum/snackbar-type.ts";
import YakalSnackbar from "@components/snackbar/view.tsx";

function LoginMainPage() {
  const {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, setOpen },
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
      <YakalSnackbar open={open} setOpen={setOpen} type={ESnackbarType.LOGIN_FAILED} />
    </S.OuterDiv>
  );
}

export default LoginMainPage;
