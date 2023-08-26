import { createGlobalStyle } from "styled-components";
import { theme } from "./theme";

export const GlobalStyle = createGlobalStyle`
  * {
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }

  html,
  body,
  #root {
    display: flex;
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
    position: relative;
    font-family: SUIT, Pretendard; 
  }

  @media only screen and (min-width: 1049px) {
    html { font-size: 100%; }
  }

  @media only screen and (max-width: 1048px) and (min-width: 795px) {
    html { font-size: 75%; }
  }

  @media only screen and (max-width: 794px) {
    html { font-size: 62.5%; }
  }

  ::-webkit-scrollber {
    width: 10px;
  }

  ::-webkit-scrollber-track {
    background: ${theme.colors.white}
  }

  ::-webkit-scrollber-thumb {
    background: ${theme.colors.gray[200]}
  }

  ::-webkit-scrollber-track:hover {
    background: ${theme.colors.gray[500]}
  }

  @font-face {
    font-family: "SUIT";
    src: url("/src/asset/SUIT-Variable.ttf") format("truetype");
  }

  @font-face {
    font-family: "Pretendard";
    font-weight: 45 920;
    font-style: normal;
    font-display: swap;
    src: url('/src/asset/PretendardVariable.woff2') format('woff2-variations');
  }
`;
