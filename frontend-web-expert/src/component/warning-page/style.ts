import styled from "styled-components";

export const Outer = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
`;

export const Icon = styled.span`
  font-size: 6rem;
  font-weight: 700;
`;

export const Text = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: start;
  align-items: start;

  @media only screen and (min-width: 769px) {
    margin: 0 8rem;
  }

  @media only screen and (max-width: 768px) {
    margin: 0 15%;
  }
`;

export const Header = styled.h1`
  font-size: 3rem;
`;

export const Description = styled.p`
  font-size: 1.4rem;
  font-weight: 600;
`;

export const Content = styled.p`
  white-space: pre-line;
`;
