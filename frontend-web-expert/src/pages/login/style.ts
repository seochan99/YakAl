import { theme } from "@/style/theme";
import { css, styled } from "styled-components";
import { ReactComponent as KakaoIconSvg } from "@/assets/kakao-logo.svg";
import { ReactComponent as GoogleIconSvg } from "@/assets/google-logo.svg";
import { ReactComponent as AppleIconSvg } from "@/assets/apple-logo.svg";
import { ReactComponent as LogoShadeSvg } from "@/assets/logo-shade.svg";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  min-height: 100dvh;
`;

export const Main = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  place-items: center;
  background-color: #f5f5f9;
  height: 100%;
  flex: 1;
`;

export const InnerMain = styled.div`
  display: flex;
  flex-direction: row;
`;

export const LogoSection = styled.div`
  display: flex;
  flex-direction: column;
  width: 27rem;
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
  content: url("/src/assets/yakal-logo.png");
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
  width: 22rem;
  padding: 5rem;
  margin-left: 4rem;
`;

export const YakalSymbol = styled.img`
  content: url("/src/assets/yakal-logo.png");
  width: 16rem;
  aspect-ratio: auto;
`;

export const LoginTitle = styled.span`
  color: #151515;
  text-align: center;
  font-size: 1.6rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.5;
  margin-bottom: 2.5rem;
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

export const Footer = styled.div`
  height: 10rem;
  background-color: #e9e9ee;
`;
