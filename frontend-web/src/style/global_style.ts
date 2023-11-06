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
