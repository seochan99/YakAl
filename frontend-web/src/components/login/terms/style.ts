import { styled } from "styled-components";

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: column;

  @media only screen and (max-width: 768px) {
    flex: 1;
    background-color: #fff;
  }
`;

export const TermsDiv = styled.div`
  display: flex;
  flex-direction: column;
  background-color: white;
  padding: 2rem;

  @media only screen and (min-width: 769px) {
    width: 48rem;
    border-radius: 1rem;
    margin-top: 2rem;
  }
`;

export const TermsHeader = styled.h1`
  color: #151515;
  font-size: 1.5rem;
  font-weight: 700;
  margin: 0.5rem 0 1.5rem;
`;

export const TermsContentDiv = styled.div`
  color: #464655;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1.8rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 1px;
  background: var(--color-surface-900);
  margin: 1.5rem 0;
`;

export const AgreementCheckInput = styled.input`
  & {
    display: none;
  }

  & + label {
    cursor: pointer;
    padding-left: 3rem;
    background-repeat: no-repeat;
    background-image: url("/assets/icons/checker-off-icon.svg");
    background-size: contain;
    color: #151515;
    font-family: Pretendard, serif;
    font-size: 1.25rem;
    font-weight: 700;
    line-height: 2.4rem;
    align-self: flex-start;
  }

  &:checked + label {
    background-image: url("/assets/icons/checker-on-icon.svg");
  }
`;

export const NextButton = styled.button`
  & {
    border-radius: 0.5rem;
    border: 0;
    background-color: var(--color-surface-900);
    color: #151515;
    font-size: 1.25rem;
    font-weight: 600;
    margin: 1.5rem 0;

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
