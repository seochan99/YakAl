import styled from "styled-components";
import { Link } from "react-router-dom";

export const NextLink = styled(Link)`
  & {
    border-radius: 0.5rem;
    border: 0;
    background-color: #2666f6;
    padding: 1rem 2rem;
    color: white;
    font-size: 1.25rem;
    font-weight: 600;
    text-decoration: none;
  }

  &:hover {
    background-color: #1348e2;
  }

  &:active {
    background-color: #163bb7;
  }
`;
