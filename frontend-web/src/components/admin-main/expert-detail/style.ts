import { Link } from "react-router-dom";
import { css, styled } from "styled-components";

import "/src/style/font.css";

import { ReactComponent as LinkIconSvg } from "/public/assets/icons/back-icon.svg";

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: column;
  width: 54rem;
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

export const InnerDiv = styled.div`
  display: flex;
  flex-direction: column;
  background-color: var(--White, #fff);
  box-shadow: 0 4px 4px 0 rgba(0, 0, 0, 0.25);
  padding: 2rem;
  gap: 1.5rem;
`;

export const BelongInfoDiv = styled.div`
  display: flex;
  flex-direction: row;
  gap: 1rem;
`;

export const BelongInnerDiv = styled.div`
  width: 50%;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
`;

export const HeaderSpan = styled.span`
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1.25rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.25rem;
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

export const Bar = styled.hr`
  height: 0.125rem;
  margin: 0;
  border: 0;
  background: var(--Gray3, #c6c6cf);
`;

export const ImgDiv = styled.div`
  display: flex;
  flex-direction: row;
`;

export const InnerImgDiv = styled.div`
  width: 50%;
`;

export const BottomButtonDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: end;
  gap: 1rem;
`;

const BottomButtonCss = css`
  & {
    display: inline-flex;
    padding: 1.125rem 2rem;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    border-radius: 0.5rem;
    border: 0;
    color: var(--White, #fff);
    font-family: Pretendard, serif;
    font-size: 1.25rem;
    font-weight: 600;
    line-height: 1.25rem;
    text-decoration: none;

    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
  }

  &:hover {
    cursor: pointer;
  }
`;

export const ApprovalButton = styled.button`
  ${BottomButtonCss}
  & {
    background-color: var(--Main, #2666f6);
  }

  &:hover {
    background-color: var(--Sub1, #5588fd);
  }
`;

export const RejectionButton = styled.button`
  ${BottomButtonCss}
  & {
    background-color: var(--Red, #fb5d5d);
  }

  &:hover {
    opacity: 0.8;
  }
`;
