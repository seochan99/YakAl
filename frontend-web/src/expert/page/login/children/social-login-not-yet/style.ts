import styled from "styled-components";
import { Link } from "react-router-dom";

export const BackLink = styled(Link)`
  & {
    display: inline-flex;
    padding: 1rem 2.25rem;
    justify-content: center;
    align-items: center;
    border-radius: 0.5rem;
    background-color: var(--Main, #2666f6);
    color: var(--White, #fff);
    font-size: 1rem;
    font-weight: 700;
    line-height: 1rem;
    text-decoration: none;
  }

  &:hover {
    cursor: pointer;
    opacity: 0.85;
  }

  &:active {
    opacity: 0.7;
  }
`;
