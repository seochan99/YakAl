import styled from "styled-components";

export const ButtonDiv = styled.div`
  & {
    display: inline-flex;
    padding: 1rem 2.25rem;
    justify-content: center;
    align-items: center;
    border-radius: 0.5rem;
    background-color: var(--Main, #2666f6);
    color: var(--White, #2666f6);
    font-size: 1.2rem;
    font-weight: 600;
    line-height: 1.2rem;
  }

  &:hover {
    cursor: pointer;
    opacity: 0.85;
  }

  &:active {
    opacity: 0.7;
  }
`;
