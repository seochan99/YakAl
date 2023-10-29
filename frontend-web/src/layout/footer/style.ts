import styled from "styled-components";

export const OuterFooter = styled.footer`
  display: flex;
  flex-direction: row;
  align-items: center;
  padding: 1rem 0;
  background-color: var(--color-surface-900);
`;

export const IconImg = styled.img`
  & {
    content: url("/assets/logos/view-pharm-logo.png");
    margin-left: 10vw;
    width: 5rem;
    height: 5rem;
  }

  &:hover {
    filter: invert(50%);
    cursor: pointer;
  }
`;

export const ExplanationParagraph = styled.p`
  margin-left: 2rem;
  margin-right: 10vw;
  color: var(--Gray4, #90909f);
  font-family: SUIT, serif;
  font-size: 0.9375rem;
  font-style: normal;
  font-weight: 500;
  line-height: 1.6875rem;
`;
