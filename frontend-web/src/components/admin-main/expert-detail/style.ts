import { Link } from "react-router-dom";
import { styled } from "styled-components";

import "/src/style/font.css";

import { ReactComponent as LinkIconSvg } from "/public/assets/icons/back-icon.svg";

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: column;
  width: 74rem;
  margin: 2rem 0;
  gap: 2.5rem;
`;

export const HeaderDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
`;

export const StyledLinkIconSvg = styled(LinkIconSvg)`
  transform: scaleX(-1);
  margin-left: -0.4rem;
`;

export const BackLink = styled(Link)`
  & {
    display: inline-flex;
    padding: 1rem 1.2rem;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    border-radius: 0.5rem;
    background-color: var(--Gray2, #e9e9ee);
    color: var(--Black, #151515);
    font-family: Pretendard, serif;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1rem;
    text-decoration: none;
  }

  &:hover {
    cursor: pointer;
    background-color: var(--Gray3, #c6c6cf);
  }
`;

export const NameSpan = styled.span`
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1.25rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.25rem;
`;

export const BodyDiv = styled.div`
  display: flex;
  flex-direction: column;
`;

export const InnerDiv = styled.div`
  display: flex;
  flex-direction: column;
  background-color: var(--White, #fff);
  box-shadow: 0 4px 4px 0 rgba(0, 0, 0, 0.25);
  padding: 2rem 1.25rem;
`;
