import { styled } from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
`;

export const TermsBox = styled.div`
  display: flex;
  flex-direction: column;
  background-color: white;
  width: 48rem;
  border-radius: 1rem;
  padding: 2rem;
`;

export const TermsHeader = styled.h1`
  color: #151515;
  font-size: 1.5rem;
  font-weight: 700;
  margin: 0.5rem 0 1.5rem;
`;

export const TermsContent = styled.div`
  color: #464655;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1.8rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 1px;
  background: #e9e9ee;
  margin: 1.5rem 0;
`;

export const Agreement = styled.input`
  & {
    display: none;
  }
  & + label {
    cursor: pointer;
    padding-left: 3rem;
    background-repeat: no-repeat;
    background-image: url("/src/asset/checker-off.svg");
    background-size: contain;
    color: #151515;
    font-family: Pretendard;
    font-size: 1.25rem;
    font-weight: 700;
    line-height: 2.4rem;
    align-self: flex-start;
  }
  &:checked + label {
    background-image: url("/src/asset/checker-on.svg");
  }
`;

export const NextButton = styled.button`
  & {
    align-self: flex-end;
    border-radius: 0.5rem;
    border: 0;
    background-color: #e9e9ee;
    color: #151515;
    font-family: Pretendard;
    font-size: 1.25rem;
    font-weight: 600;
    padding: 1rem 2.5rem;
    margin: 1.5rem 0;
  }
  &.is-agreed {
    background-color: #2666f6;
    color: white;
  }
  &.is-agreed:hover {
    background-color: #1348e2;
  }
  &.is-agreed:active {
    background-color: #163bb7;
  }
`;
