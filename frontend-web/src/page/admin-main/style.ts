import { styled } from "styled-components";
import "/src/style/font.css";
import { NavLink } from "react-router-dom";

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: column;
  align-items: stretch;
  justify-content: start;
  width: 100vw;
`;

export const CenteringMain = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-color: var(--Gray1, #f5f5f9);
  flex: 1;
`;

export const NavOuterDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 1rem;
  padding-right: 4rem;
`;

export const ItemNavLink = styled(NavLink)`
  & {
    color: #151515;
    font-size: 1.1rem;
    font-weight: 600;
    line-height: 1.1rem;
    width: 6rem;
    padding: 0.5rem 0;
    border-radius: 0.25rem;
    text-decoration: none;
    text-align: center;
  }

  &:hover {
    color: #2666f6;
    background-color: #f5f5f9;
    transition: color 0.2s;
  }

  &.active {
    background-color: var(--Gray2, #e9e9ee);
  }
`;

export const LogoutButton = styled.div`
  & {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 0.65rem 2.25rem;
    border: 0;
    border-radius: 0.25rem;
    font-size: 0.9rem;
    line-height: 0.9rem;
    font-weight: 600;
    color: #fff;
    background-color: #c61a24;
  }

  &:hover {
    background-color: #b7141f;
    cursor: pointer;
  }

  &:active {
    background-color: #cf5658;
  }
`;
