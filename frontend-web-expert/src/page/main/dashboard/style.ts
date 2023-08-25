import { Link } from "react-router-dom";
import styled from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: stretch;
  width: 100%;
`;

export const EnrollBox = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  height: 8rem;
  background-color: #fff;
  border: 0.15rem solid #2666f6;
  border-radius: 0.5rem;
  padding: 0 3rem;
  margin: 1rem 0;
`;

export const IconText = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

export const YakAlIcon = styled.img`
  content: url("/src/asset/yakal-logo.png");
  width: 5rem;
`;

export const EnrollText = styled.span`
  color: #000;
  font-size: 1.25rem;
  font-weight: 500;
  line-height: 2.25rem;
  margin-left: 2rem;
`;

export const EnrollButton = styled(Link)`
  & {
    display: inline-flex;
    padding: 0.875rem 2.125rem;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    border-radius: 0.5rem;
    background-color: #2666f6;
    color: #fff;
    font-family: Pretendard;
    font-size: 1rem;
    font-weight: 700;
    line-height: 1rem;
    text-decoration: none;
  }
  &:hover {
    cursor: pointer;
    background-color: #1348e2;
  }
  &:active {
    background-color: #163bb7;
  }
`;

export const DoctorIcon = styled.img`
  content: url("/src/asset/doctor-icon.png");
  width: 5rem;
`;

export const CertTextBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: start;
`;

export const SubEnrollText = styled.span`
  color: #7c7c94;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1.5rem;
  margin-left: 2rem;
`;

export const Blue = styled.span`
  color: #2666f6;
  font-weight: 700;
`;

export const Menu = styled.div`
  display: grid;
  margin: 1.5rem 0;
  grid-template-columns: repeat(3, 1fr);
  row-gap: 1rem;
  column-gap: 1rem;
`;

export const PatientIcon = styled.img`
  content: url("/src/asset/patient-icon.png");
  width: 6rem;
  height: 6rem;
`;
