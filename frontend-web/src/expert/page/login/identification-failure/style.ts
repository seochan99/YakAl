import styled from "styled-components";
import { Link } from "react-router-dom";

export const BackButton = styled(Link)`
  & {
    display: inline-flex;
    padding: 0.875rem 2.125rem;
    justify-content: center;
    align-items: center;
    border-radius: 0.5rem;
    background-color: #2666f6;
    color: #fff;
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
