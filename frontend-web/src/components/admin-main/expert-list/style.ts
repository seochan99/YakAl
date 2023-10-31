import { styled } from "styled-components";
import { ReactComponent as SearchIconSvg } from "/public/assets/icons/magnifying-glass-icon.svg";

export const OptionBarDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
`;

export const SearchBarDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  border-radius: 0.5rem;
  border: 0.125rem solid var(--Gray2, #e9e9ee);
  height: 2.5rem;
  gap: 0.8rem;
  flex: 1;
`;

export const StyledSearchIconSvg = styled(SearchIconSvg)`
  /* Variable */
  --IconSize: 1.2rem;

  /* Style */
  width: var(--IconSize);
  height: var(--IconSize);
  margin-left: var(--IconSize);
`;

export const SearchInput = styled.input`
  flex: 1;
  color: var(--Gray4, #90909f);
  text-align: left;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  margin-right: 1.4rem;
  border: 0;
  outline: none;
`;

export const SelectDiv = styled.div`
  position: relative;
  display: flex;
  flex-direction: column;
`;

export const SelectButton = styled.button`
  & {
    display: inline-flex;
    align-items: center;
    justify-content: start;
    padding: 0 0.4rem;
    border: 0;
    border-radius: 0.5rem;
    height: 2.5rem;
    width: 8rem;
    background-color: var(--Gray2, #e9e9ee);
  }

  & svg {
    height: 1.5rem;
  }

  & span {
    flex: 1;
    text-align: center;
    white-space: nowrap;
    color: var(--Black, #151515);
    font-family: Pretendard, serif;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
  }

  &.asc svg {
    transform: rotate(180deg);
  }

  &:hover {
    cursor: pointer;
    background-color: var(--Gray3, #c6c6cf);
  }
`;

export const SelectList = styled.ul`
  position: absolute;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  top: 1.5rem;
  list-style: none;
  border-radius: 0.5rem;
  padding: 0.4rem;
  background-color: var(--White, #fff);
  border: 0.1rem solid var(--Gray3, #c6c6cf);
  right: 0;
  width: 7.1rem;
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
    color: var(--Black, #151515);
    font-family: Pretendard, serif;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    padding: 0.8rem 0;
  }

  &:hover {
    cursor: pointer;
    background-color: var(--Gray2, #e9e9ee);
  }

  &:active {
    background-color: var(--Gray3, #c6c6cf);
  }
`;

export const ListDiv = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  height: 40.7rem;
`;

export const TableHeaderDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  padding: 0.6rem 1rem;
  border: 0;
  color: var(--Gray4, #90909f);
  font-family: SUIT, serif;
  font-size: 1rem;
  font-style: normal;
  font-weight: 500;
  line-height: 1.2rem;
  text-align: center;
`;

export const NameSpan = styled.span`
  width: calc(100% / 8);
`;

export const JobTypeSpan = styled.span`
  width: calc(100% / 8);
`;

export const FacilityNameSpan = styled.span`
  width: calc(100% / 4);
`;

export const TelephoneSpan = styled.span`
  width: calc(100% / 4);
`;

export const RequestDateSpan = styled.span`
  width: calc(100% / 4);
`;

export const PaginationDiv = styled.div`
  & {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    font-family: Pretendard, serif;
    font-weight: 600;
  }

  & .pagination {
    display: flex;
    flex-direction: row;
    gap: 0.4rem;
    margin: 0;
  }

  & ul {
    list-style: none;
    padding: 0;
  }

  & ul.pagination li {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 0.5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 0.0625rem solid var(--Gray3, #c6c6cf);
  }

  & ul.pagination li:hover {
    background-color: var(--Gray2, #e9e9ee);
    cursor: pointer;
  }

  & ul.pagination li:active {
    background-color: var(--Sub1, #5588fd);
  }

  & ul.pagination li.active {
    background-color: var(--Main, #2666f6);
  }

  & ul.pagination li a {
    text-decoration: none;
    color: var(--Black, #151515);
  }

  & ul.pagination li:hover a {
    color: var(--Black, #151515);
  }

  & ul.pagination li:active a {
    color: white;
  }

  & ul.pagination li.active a {
    color: white;
  }
`;
