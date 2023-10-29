import styled, { createGlobalStyle } from "styled-components";
import "./font.css";

export const GlobalStyle = createGlobalStyle`
  * {
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;

    --Main: #2666F6;
    --Sub1: #5588FD;
    --Sub2: #C1D2FF;
    --Sub3: #F1F5FE;
    --Black: #151515;
    --Gray6: #464655;
    --Gray5: #626272;
    --Gray4: #90909F;
    --Gray3: #C6C6CF;
    --Gray2: #E9E9EE;
    --Gray1: #F5F5F9;
    --White: #FFF;
    --Green: #63DC68;
    --Yellow: #FFC100;
    --Red: #FB5D5D;
    --TextRed: #E01029;

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

  @media only screen and (min-width: 1081px) {
    html {
      font-size: 100%;
    }
  }

  @media only screen and (max-width: 1080px) {
    html {
      font-size: 85%;
    }
  }
`;

export const ListFooter = styled.div`
  & {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    font-family: Pretendard, serif;
    font-weight: 600;
  }

  & .pagination {
    display: flex;
    flex-direction: row;
    gap: 0.4rem;
    margin: 0;
  }

  & ul {
    list-style: none;
    padding: 0;
  }

  & ul.pagination li {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 0.5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 0.0625rem solid var(--Gray3, #c6c6cf);
  }

  & ul.pagination li:hover {
    background-color: var(--Gray2, #e9e9ee);
    cursor: pointer;
  }

  & ul.pagination li:active {
    background-color: var(--Sub1, #5588fd);
  }

  & ul.pagination li.active {
    background-color: var(--Main, #2666f6);
  }

  & ul.pagination li a {
    text-decoration: none;
    color: var(--Black, #151515);
  }

  & ul.pagination li:hover a {
    color: var(--Black, #151515);
  }

  & ul.pagination li:active a {
    color: white;
  }

  & ul.pagination li.active a {
    color: white;
  }
`;
