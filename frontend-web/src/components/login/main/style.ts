import styled, { css } from "styled-components";
import "/src/style/font.css";

import { ReactComponent as KakaoIconSvg } from "/public/assets/logos/kakao-logo.svg";
import { ReactComponent as GoogleIconSvg } from "/public/assets/logos/google-logo.svg";
import { ReactComponent as LogoShadeSvg } from "/public/assets/logos/logo-shade.svg";

export const OuterDiv = styled.div`
  display: flex;
  justify-content: center;

  @media only screen and (min-width: 769px) {
    flex-direction: row;
    gap: 4rem;
  }

  @media only screen and (max-width: 768px) {
    flex-direction: column;
    align-items: center;
    gap: 8rem;
  }
`;

export const ServiceIntroDiv = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 6rem;

  @media only screen and (min-width: 481px) {
    width: 27rem;
  }
`;

export const TextDiv = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1.5rem;
`;

export const TitleDiv = styled.div`
  display: inline-flex;
  align-items: flex-end;
  gap: 1rem;
`;

export const TitleSpan = styled.span`
  color: var(--main, #2666f6);
  text-align: center;
  font-family: SUIT, serif;
  font-size: 2.5rem;
  font-style: normal;
  font-weight: 700;
  line-height: 2.5rem;
`;

export const SubtitleSpan = styled.span`
  color: var(--Gray4, #90909f);
  font-family: SUIT, serif;
  font-size: 2rem;
  font-style: normal;
  font-weight: 700;
  line-height: 2rem;
`;

export const DescriptionSpan = styled.span`
  color: var(--Gray4, #90909f);
  font-family: SUIT, serif;
  font-size: 1.5rem;
  font-style: normal;
  font-weight: 500;
  line-height: 1.5rem;
`;

export const LogoDiv = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
`;

export const LogoImg = styled.img`
  content: url("/assets/yakal-logo.png");
  z-index: 1;
  width: 12.78538rem;
  height: 7.53425rem;
  flex-shrink: 0;
`;

export const StyledLogoShadeSvg = styled(LogoShadeSvg)`
  /* Variables */
  --ShadeHeight: 4.395rem;

  /* Styles */
  width: 25rem;
  height: var(--ShadeHeight);
  margin-top: calc((-1) * var(--ShadeHeight) / 2);
  flex-shrink: 0;
`;

export const LoginDiv = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border-radius: 1rem;
  background: var(--White, #fff);
  padding: 3rem;
`;

export const LoginTitleSpan = styled.span`
  color: var(--Black, #151515);
  text-align: center;
  font-family: Pretendard, serif;
  font-size: 1.5rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.5rem;
`;

export const InnerButtonsDiv = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
`;

const CommonButton = styled.button`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 1rem;
  border-radius: 0.5rem;
  width: 20rem;
  height: 4rem;
  flex-shrink: 0;
`;

const ButtonSymbolCSS = css`
  width: 1.5rem;
  height: 1.5rem;
  flex-shrink: 0;
`;

export const ButtonTextSpan = styled.span`
  color: var(--Black, #151515);
  text-align: center;
  font-family: SUIT, serif;
  font-size: 1.125rem;
  font-style: normal;
  font-weight: 600;
  line-height: 1.89563rem;
`;

export const KakaoButton = styled(CommonButton)`
  & {
    background-color: #fee500;
    border: 0;
  }

  &:hover {
    background-color: #fff40d;
  }

  &:active {
    background-color: #feff41;
  }
`;

export const StyledKakaoIconSvg = styled(KakaoIconSvg)`
  ${ButtonSymbolCSS}
`;

export const GoogleButton = styled(CommonButton)`
  & {
    background-color: var(--White, #fff);
    border: 1px solid var(--Gray3, #c6c6cf);
  }

  &:hover {
    background-color: #efefef;
  }

  &:active {
    background-color: #dcdcdc;
  }
`;

export const StyledGoogleSymbol = styled(GoogleIconSvg)`
  ${ButtonSymbolCSS}
`;
