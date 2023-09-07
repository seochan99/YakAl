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
    text-decoration: none;
    color: #fff;
  }

  &:hover {
    cursor: pointer;
    background-color: var(--color-surface-400);
  }
`;

export const DummyOuter = styled.div`
  height: 3.2rem;
`;
