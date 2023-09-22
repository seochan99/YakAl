import { styled } from "styled-components";
import { Link } from "react-router-dom";

import { ReactComponent as LinkIconSvg } from "@/expert/assets/icons/back-icon.svg";
import { ReactComponent as SearchIconSvg } from "@/expert/assets/icons/magnifying-glass-icon.svg";

export const Outer = styled.div`
  & {
    display: flex;
    flex-direction: column;
    gap: 1.25rem;
  }

  @media only screen and (max-width: 768px) {
    padding: 1rem;
  }
`;

export const CertHeader = styled.div`
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
    background-color: var(--color-surface-900);
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
  color: var(--color-surface-500);
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
    background-color: var(--color-surface-900);
    color: var(--color-surface-100);
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
    border: 0.15rem solid var(--color-surface-900);
    opacity: 0.5;
  }

  &.selected {
    border: 0.15rem solid #2666f6;
    opacity: 1;
  }
`;

export const DoctorIcon = styled.img`
  content: url("/src/expert/assets/icons/doctor-icon.png");
  width: 3rem;
  height: 3rem;
`;

export const PharmacistIcon = styled.img`
  content: url("/src/expert/assets/icons/pharmacist-icon.png");
  width: 3rem;
  height: 3rem;
`;

export const SearchBar = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  border-radius: 2rem;
  border: 2px solid var(--color-surface-900);
  min-height: 2.5rem;

  @media only screen and (min-width: 481px) {
    flex: 1;
  }
`;

export const SearchResultBox = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
  padding: 0 1rem;
  height: 19.1rem;
`;

export const SearchButton = styled(SearchIconSvg)`
  width: 1.4rem;
  height: 1.4rem;
  margin-left: 1.4rem;
`;

export const SearchInput = styled.input`
  flex: 1;
  color: #90909f;
  text-align: left;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  margin-left: 0.8rem;
  margin-right: 1.4rem;
  border: 0;
  outline: none;
`;

export const CertImgBox = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1rem;
  border-radius: 0.25rem;
  border: 0.15rem solid var(--color-surface-800);
  padding: 1.5rem;
  flex: 1;
`;

export const CertImgPreviewBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  height: 24rem;
`;

export const CertExampleBox = styled.div`
  display: flex;
  flex-direction: column;
  flex: 1;
`;

export const CertDoctorImgExample = styled.img`
  content: url("/src/expert/assets/images/doctor-example.jpeg");
  object-fit: contain;
  height: 21rem;
`;

export const CertPharmacistEmgExample = styled.img`
  content: url("/src/expert/assets/images/pharmacist-example.jpg");
  object-fit: contain;
  height: 21rem;
`;

export const CertExampleText = styled.span`
  color: var(--color-surface-600);
  font-size: 0.9rem;
  line-height: 1.2rem;
  font-weight: 500;
  margin: 0 1rem;
`;

export const CertImgPreviewWrapper = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 24rem;
  height: 24rem;
`;

export const CertImgPreview = styled.img`
  object-fit: contain;
  width: 24rem;
  height: 24rem;
`;

export const CertBelongImgPreview = styled.img`
  object-fit: contain;
  margin: 1rem;
  height: 20rem;
`;

export const BelongInputBoxWrapper = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1rem;
  border-radius: 0.25rem;
  border: 0.15rem solid var(--color-surface-800);
  padding: 1.5rem;
`;

export const CertInputLabel = styled.span`
  color: var(--color-surface-500);
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
`;

export const BelongInputBox = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.6rem;
`;

export const BelongInput = styled.input`
  & {
    color: #151515;
    text-align: left;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    height: 1rem;
    border: 0.15rem solid var(--color-surface-900);
    border-radius: 0.25rem;
    padding: 0.5rem;
    outline: none;
  }

  &:focus {
    border: 0.15rem solid var(--color-primary-100);
  }
`;

export const CertInputImgBox = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    border: 0.15rem solid var(--color-surface-900);
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
    background-color: var(--color-surface-900);
    color: #151515;
    font-size: 0.9rem;
    font-weight: 500;
    line-height: 0.9rem;
    padding: 0 1rem;
  }

  & label:hover {
    background-color: var(--color-surface-800);
  }

  & label:active {
    background-color: var(--color-surface-700);
  }

  & input[type="file"] {
    display: none;
  }
`;

export const ListHeader = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  padding: 0.5rem;
  border-radius: 0.25rem;
`;

export const Item = styled.div`
  & {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    padding: 1rem 0.5rem;
    border-radius: 0.25rem;
  }

  &:hover {
    cursor: pointer;
    background-color: #f5f5f9;
  }

  &:active {
    background-color: var(--color-surface-900);
  }
`;

export const NameHeader = styled.span`
  color: #151515;
  font-size: 1.1rem;
  font-weight: 600;
  line-height: 1.1rem;
  width: 16rem;
`;

export const AddressHeader = styled.span`
  color: #90909f;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  width: 28rem;
`;

export const ItemName = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  width: 16rem;
`;

export const ItemAddress = styled.span`
  color: #90909f;
  font-size: 0.9rem;
  font-weight: 500;
  line-height: 0.9rem;
  width: 28rem;
`;

export const NextButton = styled.button`
  & {
    border-radius: 0.5rem;
    border: 0;
    background-color: var(--color-surface-900);
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

export const CertBelongExplanation = styled.span`
  color: var(--color-surface-600);
  font-size: 1rem;
  font-weight: 500;
  line-height: 1.4rem;
`;

export const Emphasis = styled.span`
  color: var(--color-primary-100);
  font-weight: 600;
`;
