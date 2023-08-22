import { Link } from "react-router-dom";
import { styled } from "styled-components";

import { ReactComponent as LinkIconSvg } from "@/asset/back-icon.svg";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
  width: 100%;
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
    background-color: #e9e9ee;
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
  padding: 0 0.5rem;
  background-color: #fff;
  padding: 1.5rem;
`;

export const NameSex = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

export const Name = styled.span`
  color: #151515;
  font-size: 1.5rem;
  font-weight: 700;
  line-height: 1.5rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.125rem;
  background: #e9e9ee;
  margin: 1rem 0;
`;

export const Description = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
`;

export const Sex = styled(Description)`
  margin-left: 0.5rem;
`;

export const NoteAndDoseList = styled.div`
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  height: 30rem;
`;

export const InnerBox = styled.div`
  display: flex;
  flex-direction: column;
  background-color: #fff;
  padding: 1.5rem;
`;

export const PrescriptionAndHealthFunctionalFood = styled.div`
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1rem;
  height: 25rem;
`;
