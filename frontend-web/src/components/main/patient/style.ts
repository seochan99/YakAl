import { Link } from "react-router-dom";
import { styled } from "styled-components";

import { ReactComponent as LinkIconSvg } from "@/expert/assets/icons/back-icon.svg";

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

export const BaseInfoDiv = styled.div`
  /* Variable */
  --WidthPadding: 1.5rem;
  --HeightPadding: 1rem;

  /* Style */
  display: flex;
  flex-direction: row;
  justify-content: start;
  align-items: center;
  gap: 1.5rem;
  width: calc(30rem - var(--WidthPadding) * 2);
  height: calc(6rem - var(--HeightPadding) * 2);
  padding: var(--HeightPadding) var(--WidthPadding);
  border-radius: 0.5rem;
  background: var(--White, #fff);
`;

export const NokComingSoonDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  justify-self: center;
  width: 100%;
  color: var(--Gray4, #90909f);
  font-family: SUIT, serif;
  font-size: 1.2rem;
  font-style: normal;
  font-weight: 600;
  line-height: 1.2rem;
`;

export const SelfBaseTitle = styled.div`
  display: inline-flex;
  flex-direction: column;
  justify-content: start;
  color: var(--Gray4, #90909f);
  font-family: SUIT, serif;
  font-size: 1rem;
  font-style: normal;
  font-weight: 500;
  height: 100%;
`;

export const PatientImg = styled.img`
  width: 4rem;
  height: 4rem;
`;

export const InfoTextDiv = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: start;
  gap: 1rem;
`;

export const NameSexBirthDiv = styled.div`
  display: inline-flex;
  flex-direction: row;
  align-items: end;
  gap: 1rem;
`;

export const NameSpan = styled.span`
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1.25rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.25rem;
`;

export const NormalSpan = styled.span`
  color: var(--Gray6, #464655);
  font-family: SUIT, serif;
  font-size: 1rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1rem;
`;

export const IconContainedSpan = styled.span`
  & {
    color: var(--Gray6, #464655);
    font-family: SUIT, serif;
    font-size: 1rem;
    font-style: normal;
    font-weight: 500;
    line-height: 1rem;
  }

  & svg {
    height: 1rem;
  }
`;

export const BodyDiv = styled.div`
  display: flex;
  flex-direction: column;
`;

export const TabBarDiv = styled.div`
  display: flex;
  flex-direction: row;
  gap: 0.25rem;
`;

export const TabDiv = styled.div`
  & {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 50%;
    border-radius: 0.25rem 0.25rem 0 0;
    font-family: SUIT, serif;
    font-style: normal;
    font-weight: 700;
    text-align: center;
    padding: 0.5rem 0;
  }

  &:hover {
    cursor: pointer;
  }

  &.unselected {
    border: 1px solid var(--Gray3, #c6c6cf);
    background: var(--Gray1, #f5f5f9);
    color: var(--Gray4, #90909f);
  }

  &.selected {
    border: 1px solid var(--Sub2, #c1d2ff);
    border-bottom: 0.3125rem solid var(--Sub1, #5588fd);
    background: var(--Sub3, #f1f5fe);
    color: var(--main, #2666f6);
  }
`;

export const TabTitleSpan = styled.span`
  font-size: 1.25rem;
  line-height: 1.75rem;
`;

export const TabSubtitleSpan = styled.span`
  font-size: 1rem;
  line-height: 1.75rem;
`;

export const InnerDiv = styled.div`
  display: flex;
  flex-direction: column;
  background-color: var(--White, #fff);
  box-shadow: 0 4px 4px 0 rgba(0, 0, 0, 0.25);
  padding: 2rem 1.25rem;
`;
