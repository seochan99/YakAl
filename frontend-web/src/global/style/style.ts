import { createGlobalStyle } from "styled-components";

export const GlobalStyle = createGlobalStyle`
  * {
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;

    --width-standard: 54rem;

    --red-50: #fff0f0;
    --red-100: #ffdddd;
    --red-200: #ffc0c0;
    --red-300: #ff9494;
    --red-400: #ff5757;
    --red-500: #ff2323;
    --red-600: #ff0000;
    --red-700: #d70000;
    --red-800: #b10303;
    --red-900: #920a0a;
    --red-950: #500000;

    /** CSS DARK THEME PRIMARY COLORS */
    --color-primary-100: #2666f6;
    --color-primary-200: #5375f8;
    --color-primary-300: #7085f9;
    --color-primary-400: #8996fb;
    --color-primary-500: #9fa6fc;
    --color-primary-600: #b4b7fd;

    /** CSS DARK THEME SURFACE COLORS */
    --color-surface-100: #151515;
    --color-surface-150: #202020;
    --color-surface-200: #2a2a2a;
    --color-surface-300: #414141;
    --color-surface-400: #595959;
    --color-surface-500: #727272;
    --color-surface-600: #8d8d8d;
    --color-surface-700: #b5b5b5;
    --color-surface-800: #dcdcdc;
    --color-surface-900: #e9e9ee;

    /** CSS DARK THEME MIXED SURFACE COLORS */
    --color-surface-mixed-100: #1c1c28;
    --color-surface-mixed-200: #31313c;
    --color-surface-mixed-300: #474752;
    --color-surface-mixed-400: #5f5f68;
    --color-surface-mixed-500: #787780;
    --color-surface-mixed-600: #919198;
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
    font-family: Pretendard, SUIT, serif;
  }

  @media only screen and (min-width: 971px) {
    html {
      font-size: 100%;
    }
  }

  @media only screen and (max-width: 970px) {
    html {
      font-size: 85%;
    }
  }

  @font-face {
    font-family: "SUIT";
    src: url("/src/expert/asset/SUIT-Variable.ttf") format("truetype");
  }

  @font-face {
    font-family: "Pretendard";
    font-weight: 45 920;
    font-style: normal;
    font-display: swap;
    src: url('/src/expert/asset/PretendardVariable.woff2') format('woff2-variations');
  }
`;
