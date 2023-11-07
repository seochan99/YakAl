import { styled } from "styled-components";
import { Link } from "react-router-dom";

import { ReactComponent as LinkIconSvg } from "/public/assets/icons/back-icon.svg";

export const Outer = styled.div`
  & {
    display: flex;
    flex-direction: column;
    gap: 1.25rem;
    width: 54rem;
    margin: 2rem;
  }

  @media only screen and (max-width: 768px) {
    padding: 1rem;
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
    background-color: var(--Gray2, #e9e9ee);
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

export const ProgressBarWrapper = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 0.6rem;
`;

export const ProgressBar = styled.div`
  & {
    height: 0.6rem;
    width: 4.2rem;
    border-radius: 0.3rem;
  }

  &.off {
    background-color: var(--Gray2, #e9e9ee);
  }

  &.on {
    background-color: #2666f6;
  }
`;

export const ProgressText = styled.span`
  font-size: 1.2rem;
  line-height: 1.2rem;
  font-weight: 600;
  margin-left: 1rem;
`;

export const InnerBox = styled.div`
  display: flex;
  flex-direction: column;
  border-radius: 0.5rem;
  padding: 2rem;
  gap: 1.5rem;
  background-color: #fff;
`;

export const Title = styled.span`
  color: #151515;
  font-size: 1.5rem;
  font-weight: 600;
  line-height: 1.5rem;
`;

export const Subtitle = styled.span`
  color: var(--Gray5, #626272);
  font-size: 1.1rem;
  font-weight: 500;
  line-height: 1.6rem;
`;

export const SelectButtonWrapper = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  align-items: center;
  margin: 1rem;
  gap: 4rem;
`;

export const SelectButtonBox = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    border-radius: 0.5rem;
    background-color: var(--Gray2, #e9e9ee);
    color: var(--Black, #151515);
    font-size: 1.2rem;
    font-weight: 600;
    line-height: 1.2rem;
    padding: 1rem;
    gap: 2rem;
    flex: 1;
  }

  &:hover {
    cursor: pointer;
  }

  &.unselected {
    border: 0.15rem solid var(--Gray2, #e9e9ee);
    opacity: 0.5;
  }

  &.selected {
    border: 0.15rem solid #2666f6;
    opacity: 1;
  }
`;

export const HospitalIcon = styled.img`
  content: url("/assets/icons/hospital-icon.png");
  width: 3rem;
  height: 3rem;
`;

export const PharmacyIcon = styled.img`
  content: url("/assets/icons/pharmacy-icon.png");
  width: 3rem;
  height: 3rem;
`;

export const InputBox = styled.div`
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(10, 1fr);
  padding: 1rem;
  margin: 1rem 0;
  column-gap: 4rem;
  row-gap: 2rem;
`;

export const CertInputBox = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
  flex: 1;
`;

export const CertPostcodeInputBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  gap: 1rem;
  grid-row: 3 / span 3;
  grid-column: 1 / span 2;
  border-radius: 0.25rem;
  border: 0.15rem solid var(--Gray2, #e9e9ee);
  padding: 1.5rem;
`;

export const CertAddressFooter = styled.div`
  display: flex;
  flex-direction: row;
  gap: 2rem;
`;

export const PostcodeBox = styled.div`
  display: flex;
  flex-direction: row;
  align-self: start;
  gap: 1rem;
`;

export const CertImgBox = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
  grid-row: 7 / span 4;
  grid-column: 1 / span 2;
  border-radius: 0.25rem;
  border: 0.15rem solid var(--Gray2, #e9e9ee);
  padding: 1rem;
`;

export const CertImgPreview = styled.img`
  align-self: center;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  width: 90%;
  margin: 1rem;
  height: 20rem;
  object-fit: contain;
`;

export const PostcodeSearchButton = styled.button`
  & {
    border-radius: 0.25rem;
    border: 0;
    background-color: var(--Gray2, #e9e9ee);
    color: #151515;
    font-size: 0.9rem;
    font-weight: 500;
    line-height: 0.9rem;
    padding: 0 1rem;
    white-space: nowrap;
  }

  &:hover {
    color: #fff;
    background-color: var(--Sub1, #5588fd);
  }

  &:active {
    color: #fff;
    background-color: var(--Main, #2666f6);
  }
`;

export const CertInputLabel = styled.span`
  color: var(--Gray5, #626272);
  font-size: 0.9rem;
  font-weight: 500;
  line-height: 0.9rem;
`;

export const CertInput = styled.input`
  & {
    color: #151515;
    text-align: left;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    height: 1rem;
    border: 0.15rem solid var(--Gray2, #e9e9ee);
    border-radius: 0.25rem;
    padding: 0.8rem;
    outline: none;
  }

  &:focus {
    border: 0.15rem solid var(--Main, #2666f6);
  }
`;

export const CertTextarea = styled.textarea`
  & {
    color: #151515;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    border: 0.15rem solid var(--Gray2, #e9e9ee);
    border-radius: 0.25rem;
    resize: none;
    padding: 0.8rem;
    flex: 1;
  }

  &:focus {
    border: 0.15rem solid var(--Main, #2666f6);
  }
`;

export const CertInputImgBox = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    border: 0.15rem solid var(--Gray2, #e9e9ee);
    border-radius: 0.25rem;
    padding: 0.5rem;
    height: 2rem;
  }

  & input[type="text"] {
    color: #151515;
    border: 0;
    text-align: left;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    outline: none;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    width: 10rem;
  }

  & label {
    display: flex;
    flex-direction: row;
    align-items: center;
    align-self: stretch;
    border-radius: 0.25rem;
    border: 0;
    background-color: var(--Gray2, #e9e9ee);
    color: #151515;
    font-size: 0.9rem;
    font-weight: 500;
    line-height: 0.9rem;
    padding: 0 1rem;
  }

  & label:hover {
    background-color: var(--Gray2, #e9e9ee);
  }

  & label:active {
    background-color: var(--Gray3, #c6c6cf);
  }

  & input[type="file"] {
    display: none;
  }
`;

export const CertInputBoxHours = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
  flex: 1;
  grid-column: 1 / span 2;
`;

export const CertInputBoxFeatures = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
  flex: 1;
  grid-column: 1 / span 2;
`;

export const NextButton = styled.button`
  & {
    border-radius: 0.5rem;
    border: 0;
    background-color: var(--Gray2, #e9e9ee);
    color: #151515;
    font-size: 1.25rem;
    font-weight: 600;

    @media only screen and (min-width: 769px) {
      align-self: flex-end;
      padding: 1rem 2.5rem;
      margin-bottom: 2rem;
    }

    @media only screen and (max-width: 768px) {
      align-self: center;
      padding: 1.5rem 4rem;
    }
  }

  &.is-finished {
    background-color: #2666f6;
    color: white;
  }

  &.is-finished:hover {
    background-color: #1348e2;
  }

  &.is-finished:active {
    background-color: #163bb7;
  }
`;
