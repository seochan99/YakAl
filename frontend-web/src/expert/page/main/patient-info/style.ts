import { Link } from "react-router-dom";
import { styled } from "styled-components";

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
    font-family: Pretendard;
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

export const PatientSummary = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  background-color: #fff;
  padding: 1.5rem;
  border-radius: 0.5rem;
  border: 0;
`;

export const NameSex = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

export const Name = styled.span`
  color: #151515;
  font-size: 1.5rem;
  font-weight: 600;
  line-height: 1.5rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.125rem;
  background: var(--color-surface-900);
  margin: 1rem 0;
`;

export const Birthday = styled.span`
  color: #151515;
  font-size: 1.2rem;
  font-weight: 500;
  line-height: 1.2rem;
`;

export const Sex = styled.span`
  & {
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    color: #151515;
    font-size: 1.2rem;
    font-weight: 500;
    line-height: 1.2rem;
    margin-left: 2rem;
  }

  & svg {
    height: 1.4rem;
    margin-left: 0.4rem;
  }
`;

export const NoteAndDoseList = styled.div`
  display: grid;
  gap: 1rem;

  @media only screen and (min-width: 769px) {
    grid-template-columns: repeat(2, 1fr);
    height: 31rem;
  }

  @media only screen and (max-width: 768px) {
    grid-template-rows: repeat(2, 1fr);
    height: 63rem;
  }
`;

export const InnerBox = styled.div`
  display: flex;
  flex-direction: column;
  background-color: #fff;
  padding: 1.5rem;
  border-radius: 0.5rem;
  border: 0;
`;

export const PrescriptionAndHealthFunctionalFood = styled.div`
  display: grid;
  gap: 1rem;

  @media only screen and (min-width: 769px) {
    grid-template-columns: repeat(2, 1fr);
    height: 22.5rem;
  }

  @media only screen and (max-width: 768px) {
    grid-template-rows: repeat(2, 1fr);
    height: 50rem;
  }
`;
