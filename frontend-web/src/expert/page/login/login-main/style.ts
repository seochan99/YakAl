import styled, { css } from "styled-components";

import { ReactComponent as KakaoIconSvg } from "@/expert/asset/kakao-logo.svg";
import { ReactComponent as GoogleIconSvg } from "@/expert/asset/google-logo.svg";
import { ReactComponent as LogoShadeSvg } from "@/expert/asset/logo-shade.svg";

export const InnerCenter = styled.div`
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

export const LogoSection = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 1rem;

  @media only screen and (min-width: 481px) {
    width: 27rem;
  }
`;

export const TitleBox = styled.div`
  text-align: center;
  align-items: center;
`;

export const Title = styled.span`
  text-align: center;
  font-size: 2.5rem;
  font-weight: 700;
  color: #2666f6;
  line-height: 4rem;
`;

export const Subtitle = styled.span`
  font-size: 2rem;
  font-weight: 600;
  color: #90909f;
  margin-left: 1rem;
  line-height: 3.2rem;
`;

export const Description = styled.span`
  color: #90909f;
  font-size: 1.5rem;
  font-weight: 500;
  text-align: center;
  margin-bottom: 2rem;
`;

export const BigLogo = styled.img`
  content: url(");
  width: 60%;
  z-index: 1;
`;

export const LogoShade = styled(LogoShadeSvg)`
  width: 100%;
  margin-top: -6rem;
  fill: radial-gradient(50% 50% at 50% 50%, #8ca9d4 0%, rgba(246, 246, 246, 0) 100%);
`;

export const LoginSection = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  border-radius: 1rem;
  background-color: white;

  @media only screen and (min-width: 541px) {
    width: 22rem;
    padding: 3rem 2rem;
    gap: 2.5rem;
  }

  @media only screen and (max-width: 540px) {
    margin: 0 2rem 4rem;
    padding: 1.5rem;
    gap: 1rem;
  }
`;

export const YakalSymbol = styled.img`
  content: url("/src/global/asset/yakal-logo.png");
  width: 16rem;
`;

export const LoginTitle = styled.span`
  color: #151515;
  text-align: center;
  font-size: 1.6rem;
  font-style: normal;
  font-weight: 600;
  line-height: 1.5;
`;

export const ButtonBox = styled.div`
  display: flex;
  flex-direction: column;
  background-color: #fff;
  border: 0;
`;

// Button Style
const Button = styled.button`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 1rem;
  padding: 0.5rem;
  margin: 0.75rem;
  border-radius: 0.25rem;
`;

const ButtonSymbol = css`
  display: inline-block;
  height: 1.125rem;
  vertical-align: -0.25rem;
`;

const ButtonText = styled.span`
  font-size: 1.2rem;
  font-weight: 600;
  vertical-align: -0.1rem;
`;

export const KakaoButton = styled(Button)`
  & {
    background-color: #FEE500;
    border: 0.5px solid #d1aa00;
  }

  &:hover {
    background-color: #fff40d;
  }

  &:active {
    background-color: #feff41;
  }
`;

export const KakaoSymbol = styled(KakaoIconSvg)`
  ${ButtonSymbol}
`;

export const KakaoText = styled(ButtonText)`
  color: #151515;
`;

export const GoogleButton = styled(Button)`
  & {
    background-color: #fff;
    border: 0.5px solid #bdbdbd;
  }

  &:hover {
    background-color: #efefef;
  }

  &:active {
    background-color: #dcdcdc;
  }
`;

export const GoogleSymbol = styled(GoogleIconSvg)`
  ${ButtonSymbol}
`;

export const GoogleText = styled(ButtonText)`
  color: #151515;
`;
