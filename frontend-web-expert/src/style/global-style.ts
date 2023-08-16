import { createGlobalStyle } from "styled-components";
import { theme } from "./theme";

export const GlobalStyle = createGlobalStyle`
  html,
  body,
  #root {
    display: flex;
    height: 100%;
    width: 100%;
    margin: 0;
    padding: 0;
    position: relative;
    font-family: "SUIT"; 
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
    src: url("./src/asset/SUIT-Variable.ttf") format("truetype");
  }
`;
