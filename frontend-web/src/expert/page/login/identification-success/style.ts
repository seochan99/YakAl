import styled from "styled-components";

import { ReactComponent as LogoShadeSvg } from "@/expert/asset/logo-shade.svg";
import { Link } from "react-router-dom";

export const LogoSection = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 1rem;

  @media only screen and (min-width: 481px) {
    width: 27rem;
  }
`;

export const Description = styled.span`
  color: var(--color-surface-100);
  font-size: 1.5rem;
  font-weight: 500;
  text-align: center;
  margin-bottom: 2rem;
`;

export const BigLogo = styled.img`
  content: url("/src/global/asset/yakal-logo.png");
  width: 50%;
  z-index: 1;
`;

export const LogoShade = styled(LogoShadeSvg)`
  width: 100%;
  margin-top: -3.5rem;
  fill: radial-gradient(50% 50% at 50% 50%, #8ca9d4 0%, rgba(246, 246, 246, 0) 100%);
`;

export const NextButton = styled(Link)`
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
