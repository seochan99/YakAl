import { styled } from "styled-components";

export const TooltipDiv = styled.div`
  & {
    display: flex;
    flex-direction: column;
    padding: 0.8rem;
    gap: 0.8rem;
    background-color: var(--White, #fff);
    border-radius: 0.5rem;
    border: 0.125rem solid var(--Gray2, #e9e9ee);
  }

  & span {
    font-family: SUIT, serif;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1rem;
  }
`;

export const BlackSpan = styled.span`
  color: var(--Black, #151515);
`;

export const BlueSpan = styled.span`
  color: var(--Main, #2666f6) !important;
`;
