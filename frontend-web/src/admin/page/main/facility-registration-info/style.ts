import { styled } from "styled-components";
import { Link } from "react-router-dom";

import { ReactComponent as LinkIconSvg } from "@/expert/asset/back-icon.svg";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1.25rem;

  @media only screen and (min-width: 769px) {
    margin: 0;
  }

  @media only screen and (max-width: 768px) {
    margin: 1rem;
  }
`;

export const Header = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
`;

export const BackIcon = styled(LinkIconSvg)`
  transform: scaleX(-1);
  margin-left: -0.4rem;
`;

export const BackButton = styled(Link)`
  & {
    display: inline-flex;
    padding: 0.875rem 1.2rem;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    border-radius: 0.5rem;
    background-color: var(--color-surface-900);
    color: #151515;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1rem;
    text-decoration: none;
  }

  &:hover {
    cursor: pointer;
    background-color: #e0dfe6;
  }

  &:active {
    background-color: #cbcbd6;
  }
`;

export const FacilityMain = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  background-color: #fff;
  padding: 1.5rem;
  border-radius: 0.5rem;
  border: 0;
`;
