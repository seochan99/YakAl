import { Link } from "react-router-dom";
import styled from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  width: 54rem;
  padding: 2rem 0;

  @media only screen and (max-width: 768px) {
    margin: 2rem;
  }
`;

export const EnrollBox = styled.div`
  display: flex;
  align-items: center;
  background-color: #fff;
  border: 0.15rem solid #2666f6;
  border-radius: 0.5rem;
  margin: 1rem 0;

  @media only screen and (min-width: 769px) {
    justify-content: space-between;
    flex-direction: row;
    height: 8rem;
    padding: 0 3rem;
  }

  @media only screen and (max-width: 768px) {
    justify-content: center;
    flex-direction: column;
    padding: 2rem;
    gap: 1rem;
  }
`;

export const IconText = styled.div`
  display: flex;
  align-items: center;

  @media only screen and (min-width: 769px) {
    flex-direction: row;
  }

  @media only screen and (max-width: 768px) {
    flex-direction: column;
    gap: 1rem;
  }
`;

export const YakAlIcon = styled.img`
  content: url("/src/global/assets/yakal-logo.png");
  width: 5rem;
`;

export const EnrollText = styled.span`
  color: #000;
  font-size: 1.25rem;
  font-weight: 500;
  line-height: 2.25rem;
  text-align: center;

  @media only screen and (min-width: 769px) {
    margin-left: 2rem;
  }
`;

export const EnrollButton = styled(Link)`
  & {
    display: inline-flex;
    padding: 0.875rem 2.125rem;
    justify-content: center;
    align-items: center;
    border-radius: 0.5rem;
    background-color: #2666f6;
    color: #fff;
    font-family: Pretendard;
    font-size: 1rem;
    font-weight: 700;
    line-height: 1rem;
    text-decoration: none;

    @media only screen and (min-width: 769px) {
      padding: 0.875rem 2.125rem;
      font-size: 1rem;
      font-weight: 700;
      line-height: 1rem;
    }

    @media only screen and (max-width: 768px) {
      padding: 1rem 2.4rem;
      font-size: 1.2rem;
      font-weight: 700;
      line-height: 1.2rem;
    }
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
  content: url("/src/expert/assets/icons/doctor-icon.png");
  width: 5rem;
`;

export const CertTextBox = styled.div`
  display: flex;
  flex-direction: column;

  @media only screen and (min-width: 769px) {
    align-items: start;
  }

  @media only screen and (max-width: 768px) {
    align-items: center;
  }
`;

export const SubEnrollText = styled.span`
  color: #7c7c94;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1.5rem;
  text-align: center;

  @media only screen and (min-width: 769px) {
    margin-left: 2rem;
  }
`;

export const Blue = styled.span`
  color: #2666f6;
  font-weight: 700;
`;

export const Menu = styled.div`
  display: grid;
  margin: 1.5rem 0;
  row-gap: 1rem;
  column-gap: 1rem;

  @media only screen and (min-width: 769px) {
    grid-template-columns: repeat(3, 1fr);
  }

  @media only screen and (max-width: 768px) and (min-width: 541px) {
    grid-template-columns: repeat(2, 1fr);
  }

  @media only screen and (max-width: 540px) {
    grid-template-columns: repeat(1, 1fr);
  }
`;

export const PatientIcon = styled.img`
  content: url("/src/expert/assets/icons/patient-icon.png");
  width: 6rem;
  height: 6rem;
`;
