import { Link } from "react-router-dom";
import styled from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
`;

export const Icon = styled.h1`
  font-size: 6rem;
  margin: 0 8rem 0 0;
`;

export const Text = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: start;
  height: 15rem;
`;

export const Header = styled.span`
  font-size: 3rem;
  font-weight: 700;
`;

export const Description = styled.span`
  font-size: 1.4rem;
  font-weight: 600;
`;

export const BackButton = styled(Link)`
  & {
    display: inline-flex;
    padding: 0.875rem 2.125rem;
    justify-content: center;
    align-items: center;
    border-radius: 0.5rem;
    background-color: #2666f6;
    color: #fff;
    font-family: Pretendard;
    font-size: 1rem;
    font-weight: 700;
    line-height: 1rem;
    text-decoration: none;
  }
  &:hover {
    cursor: pointer;
    background-color: #1348e2;
  }
  &:active {
    background-color: #163bb7;
  }
`;
