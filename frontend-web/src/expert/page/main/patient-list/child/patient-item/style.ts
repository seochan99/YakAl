import { NavLink } from "react-router-dom";
import styled from "styled-components";

export const Outer = styled(NavLink)`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    border: 0;
    border-radius: 0.25rem;
    margin: 0.45rem 0;
    text-decoration: none;
    color: #151515;
  }

  &:hover {
    cursor: pointer;
    background-color: var(--color-surface-900);
  }
`;

export const Name = styled.span`
  & {
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    font-weight: 600;
    line-height: 1.1rem;
    text-align: center;
    width: 6rem;
  }

  & svg {
    height: 1.1rem;
  }
`;

export const Sex = styled.span`
  & {
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    width: 4rem;
    gap: 0.1rem;
  }

  & svg {
    height: 1.2rem;
  }
`;

export const TestProgress = styled.span`
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  text-align: center;
  width: 5rem;
`;

export const DateBox = styled.span`
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  text-align: center;

  @media only screen and (min-width: 541px) {
    width: 12rem;
  }

  @media only screen and (max-width: 540px) {
    width: 7rem;
  }
`;
