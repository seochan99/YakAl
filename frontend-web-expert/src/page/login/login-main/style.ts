import { theme } from "@/style/theme";
import styled, { css } from "styled-components";

import { ReactComponent as KakaoIconSvg } from "@/asset/kakao-logo.svg";
import { ReactComponent as GoogleIconSvg } from "@/asset/google-logo.svg";
import { ReactComponent as AppleIconSvg } from "@/asset/apple-logo.svg";
import { ReactComponent as LogoShadeSvg } from "@/asset/logo-shade.svg";

export const InnerCenter = styled.div`
  display: flex;

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

  @media only screen and (min-width: 481px) {
    width: 27rem;
  }
`;

export const TitleBox = styled.div`
  margin-top: 3.2rem;
  text-align: center;
`;

export const Title = styled.span`
  text-align: center;
  font-size: 2.5rem;
  font-weight: 700;
  color: #2666f6;
  margin-top: 0.2rem;
  line-height: 4rem;
`;

export const Subtitle = styled.span`
  font-size: 2rem;
  font-weight: 700;
  color: #90909f;
  margin-left: 1rem;
  margin-top: 0.2rem;
  line-height: 3.2rem;
`;

export const Description = styled.span`
  color: #90909f;
  font-size: 1.5rem;
  font-weight: 500;
  line-height: 2.4rem;
  margin-top: 0.75em;
  text-align: center;
`;

export const BigLogo = styled.img`
  content: url("/src/asset/yakal-logo.png");
  width: 16rem;
  margin: 3rem auto;
  z-index: 1;
`;

export const LogoShade = styled(LogoShadeSvg)`
  margin: -5.75rem auto;
  width: 100%;
  fill: radial-gradient(50% 50% at 50% 50%, #8ca9d4 0%, rgba(246, 246, 246, 0) 100%);
`;

export const LoginSection = styled.div`
  display: flex;
  flex-direction: column;
  border-radius: 1rem;
  background-color: white;

  @media only screen and (min-width: 481px) {
    width: 22rem;
    padding: 5rem;
    gap: 2.5rem;
  }

  @media only screen and (max-width: 480px) {
    margin: 0 2rem 4rem;
    padding: 1.5rem;
    gap: 1rem;
  }
`;

export const YakalSymbol = styled.img`
  content: url("/src/asset/yakal-logo.png");
  width: 16rem;
`;

export const LoginTitle = styled.span`
  color: #151515;
  text-align: center;
  font-size: 1.6rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.5;
`;

export const ButtonBox = styled.div`
  display: flex;
  flex-direction: column;
  background-color: ${theme.colors.white};
  border: 0;
`;

// Button Style
const Button = styled.button`
  padding: 0.5rem;
  margin: 0.75rem;
  border-radius: 0.25rem;
  padding: 1rem;
`;

const ButtonSymbol = css`
  display: inline-block;
  height: 1.125rem;
  vertical-align: -0.25rem;
  margin: 0 0.4rem 0 3rem;
`;

const ButtonText = styled.span`
  font-size: 1rem;
  font-weight: 600;
  vertical-align: -0.1rem;
  margin: 0 3rem 0 0.4rem;
`;

export const KakaoButton = styled(Button)`
  & {
    background-color: ${theme.colors.yellow[500]};
    border: 0.5px solid ${theme.colors.yellow[600]};
  }
  &:hover {
    background-color: ${theme.colors.yellow[400]};
  }
  &:active {
    background-color: ${theme.colors.yellow[300]};
  }
`;

export const KakaoSymbol = styled(KakaoIconSvg)`
  ${ButtonSymbol}
`;

export const KakaoText = styled(ButtonText)`
  color: #000000 85%;
`;

export const GoogleButton = styled(Button)`
  & {
    background-color: ${theme.colors.white};
    border: 0.5px solid ${theme.colors.gray[300]};
  }
  &:hover {
    background-color: ${theme.colors.gray[100]};
  }
  &:active {
    background-color: ${theme.colors.gray[200]};
  }
`;

export const GoogleSymbol = styled(GoogleIconSvg)`
  ${ButtonSymbol}
`;

export const GoogleText = styled(ButtonText)`
  color: ${theme.colors.gray[900]};
`;

export const AppleButton = styled(Button)`
  & {
    background-color: ${theme.colors.black};
    border: 0;
  }
  &:hover {
    background-color: ${theme.colors.gray[900]};
  }
  &:active {
    background-color: ${theme.colors.gray[800]};
  }
`;

export const AppleSymbol = styled(AppleIconSvg)`
  ${ButtonSymbol}
`;

export const AppleText = styled(ButtonText)`
  color: ${theme.colors.white};
`;
