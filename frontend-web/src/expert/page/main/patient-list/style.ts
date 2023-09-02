import { styled } from "styled-components";

import { ReactComponent as SearchIconSvg } from "@/expert/asset/magnifying-glass.svg";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  border-radius: 0.5rem;
  background-color: #fff;

  @media only screen and (min-width: 541px) {
    padding: 2rem;
  }

  @media only screen and (max-width: 540px) {
    padding: 1.5rem;
  }

  @media only screen and (min-width: 381px) {
    border-radius: 0.5rem;
  }

  @media only screen and (max-width: 380px) {
    border-radius: 0;
  }
`;

export const OptionBar = styled.div`
  display: flex;

  @media only screen and (min-width: 481px) {
    flex-direction: row;
    align-items: center;
    gap: 2rem;
  }

  @media only screen and (max-width: 480px) {
    flex-direction: column;
    align-items: stretch;
    gap: 1rem;
  }
`;

export const SearchBar = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  border-radius: 2rem;
  border: 2px solid var(--color-surface-900);
  height: 3rem;

  @media only screen and (min-width: 481px) {
    flex: 1;
  }
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

export const SelectBox = styled.div`
  position: relative;
  display: flex;
  flex-direction: column;
`;

export const SelectButton = styled.button`
  & {
    display: inline-flex;
    padding: 0.4rem 0.8rem 0.4rem 0.4rem;
    align-items: center;
    border: 0;
    border-radius: 3rem;
    height: 3rem;
    background-color: var(--color-surface-900);
    color: #151515;
    font-family: Pretendard;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;

    @media only screen and (min-width: 481px) {
      width: 8rem;
    }
  }
  & svg {
    height: 1.5rem;
    transition: 0.3s;
    margin-left: 0.4rem;
  }
  & span {
    flex: 1;
    text-align: center;
  }
  &.open svg {
    transform: rotate(180deg);
  }
  &:hover {
    cursor: pointer;
    background-color: #e0dfe6;
  }
  &:active {
    background-color: #cbcbd6;
  }
`;

export const SelectList = styled.ul`
  position: absolute;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  align-items: center;
  top: 2rem;
  list-style: none;
  border-radius: 0.5rem;
  padding: 0.4rem;
  background-color: #fff;
  border: 1px solid #b7b5c4;

  @media only screen and (min-width: 481px) {
    right: 0;
    width: 7rem;
  }

  @media only screen and (max-width: 480px) {
    left: 0;
    width: calc(100% - 1rem);
  }
`;

export const SelectItem = styled.li`
  width: 100%;
`;

export const SelectItemButton = styled.button`
  & {
    width: 100%;
    background-color: transparent;
    border: 0;
    border-radius: 0.5rem;
    color: #151515;
    font-family: Pretendard;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    padding: 1rem;
  }
  &:hover {
    cursor: pointer;
    background-color: #e0dfe6;
  }
  &:active {
    background-color: #cbcbd6;
  }
`;

export const List = styled.div`
  display: flex;
  flex-direction: column;
  padding: 1.5rem 0;
  margin: 0;
  width: 100%;
  flex: 1;
`;

export const TableHeader = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  padding: 0.8rem 1rem;
  border: 0;
  color: #7c7c94;
  font-weight: 500;
  font-size: 1rem;
`;

export const Name = styled.span`
  line-height: 1rem;
  text-align: center;
  width: 6rem;
`;

export const Sex = styled.span`
  & {
    line-height: 1rem;
    width: 4rem;
    text-align: center;
  }
  & svg {
    height: 1.2rem;
  }
`;

export const TestProgress = styled.span`
  line-height: 1rem;
  text-align: center;
  width: 5rem;
`;

export const DateBox = styled.span`
  line-height: 1rem;
  text-align: center;

  @media only screen and (min-width: 541px) {
    width: 12rem;
  }

  @media only screen and (max-width: 540px) {
    width: 7rem;
  }
`;
