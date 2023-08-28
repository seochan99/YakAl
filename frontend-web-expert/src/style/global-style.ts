import styled, { createGlobalStyle } from "styled-components";
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

  @media only screen and (min-width: 971px) {
    html { font-size: 100%; }
  }

  @media only screen and (max-width: 970px) {
    html { font-size: 75%; }
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

export const ListFooter = styled.div`
  & {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    font-family: Pretendard;
    padding: 1rem 0;
  }
  & .pagination {
    display: flex;
    flex-direction: row;
    gap: 0.8rem;
    margin: 0;
  }
  & ul {
    list-style: none;
    padding: 0;
  }
  & ul.pagination li {
    display: inline-block;
    width: 2.4rem;
    height: 2.4rem;
    border-radius: 2.4rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #b7b5c4;
  }
  & ul.pagination li:hover {
    background-color: #e9e9ee;
    cursor: pointer;
  }
  & ul.pagination li:active {
    background-color: #337ab7;
  }
  & ul.pagination li.active {
    background-color: #337ab7;
  }
  & ul.pagination li a {
    text-decoration: none;
    color: #151515;
  }
  & ul.pagination li:hover a {
    color: #151515;
  }
  & ul.pagination li:active a {
    color: white;
  }
  & ul.pagination li.active a {
    color: white;
  }
`;
