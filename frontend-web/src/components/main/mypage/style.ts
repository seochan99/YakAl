import { styled } from "styled-components";
import { Link } from "react-router-dom";

import { ReactComponent as LinkIconSvg } from "/public/assets/icons/back-icon.svg";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
  margin: 2rem;
  width: 54rem;
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
    background-color: var(--Gray2, #e9e9ee);
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

export const MainSection = styled.div`
  display: flex;
  flex-direction: column;
  padding: 2rem;
  gap: 1.5rem;
  border-radius: 0.5rem;
  border: 0;
  background-color: #fff;
`;

export const InnerDiv = styled.div`
  display: flex;
  flex-direction: column;
  gap: 2rem;
  margin: 1rem 0;
`;

export const MainHeader = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 2rem;
`;

export const VerifiedIcon = styled.img`
  content: url("/assets/icons/verified-icon.png");
  height: 1.2rem;
  width: 1.2rem;
`;

export const UnverifiedIcon = styled.img`
  content: url("/assets/icons/unverified-icon.png");
  height: 1.2rem;
  width: 1.2rem;
`;

export const VerifiedText = styled.span`
  color: var(--Black, #151515);
  font-size: 1.1rem;
  font-weight: 500;
  line-height: 1.1rem;
  display: inline-flex;
  flex-direction: row;
  align-items: center;
  gap: 0.4rem;
`;

export const Title = styled.span`
  color: #151515;
  font-size: 1.5rem;
  font-weight: 600;
  line-height: 1.5rem;
`;

export const OneItemSpan = styled.span`
  display: inline-flex;
  flex-direction: row;
  align-items: start;
  gap: 1rem;
`;

export const NormalSpan = styled.span`
  color: var(--Gray5, #626272);
  font-family: SUIT, serif;
  font-size: 1rem;
  font-style: normal;
  font-weight: 500;
  line-height: 1.1rem;
  flex: 1;
`;

export const NameSpan = styled.span`
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1.1rem;
  font-style: normal;
  font-weight: 600;
  line-height: 1.1rem;
  white-space: nowrap;
  width: 8rem;
`;
