import { styled } from "styled-components";
import { Link } from "react-router-dom";

import { ReactComponent as LinkIconSvg } from "/src/expert/asset/back-icon.svg";

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

export const MainSection = styled.div`
  display: flex;
  flex-direction: column;
  padding: 2rem;
  gap: 1.5rem;
  border-radius: 0.5rem;
  border: 0;
  background-color: #fff;
`;

export const InnerBox = styled.div`
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(2, 1fr);
  row-gap: 2rem;
  column-gap: 3rem;
  margin: 1rem 0;
`;

export const MainHeader = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 2rem;
`;

export const VerifiedIcon = styled.img`
  content: url("/src/expert/asset/verified-icon.png");
  height: 1.2rem;
  width: 1.2rem;
`;

export const UnverifiedIcon = styled.img`
  content: url("/src/expert/asset/unverified-icon.png");
  height: 1.2rem;
  width: 1.2rem;
`;

export const VerifiedText = styled.span`
  color: var(--color-surface-100);
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

export const InputBox = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
  flex: 1;
`;

export const BelongInputBox = styled(InputBox)`
  grid-column: 1 / span 2;
`;

export const StyledInputLabel = styled.span`
  color: var(--color-surface-500);
  font-size: 0.9rem;
  font-weight: 500;
  line-height: 0.9rem;
`;

export const StyledInput = styled.input`
  & {
    color: #151515;
    text-align: left;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    height: 1rem;
    border: 0.15rem solid var(--color-surface-900);
    border-radius: 0.25rem;
    padding: 0.5rem;
    outline: none;
  }

  &:focus {
    border: 0.15rem solid var(--color-primary-100);
  }
`;
