import { styled } from "styled-components";

import { ReactComponent as SearchIconSvg } from "@/expert/asset/magnifying-glass.svg";

export const Outer = styled.div`
  & {
    display: flex;
    flex-direction: column;
    border-radius: 0.5rem;
    background-color: var(--color-surface-300);
    padding: 2rem;
    gap: 1.5rem;
    width: var(--width-standard);
    align-self: center;
  }

  @media only screen and (max-width: 768px) {
    padding: 1rem;
  }
`;

export const Title = styled.span`
  color: #fff;
  font-size: 1.5rem;
  font-weight: 600;
  line-height: 1.5rem;
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
  & {
    flex: 1;
    background-color: transparent;
    color: #fff;
    text-align: left;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    margin-left: 0.8rem;
    margin-right: 1.4rem;
    border: 0;
    outline: none;
  }

  &::placeholder {
    color: var(--color-surface-800);
  }
`;

export const List = styled.div`
  display: flex;
  flex-direction: column;
  margin: 0;
  width: 100%;
  gap: 0.9rem;
  flex: 1;
`;

export const TableHeader = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  padding: 0.8rem 1rem;
  border: 0;
  color: var(--color-surface-800);
  font-weight: 500;
  font-size: 1rem;
`;

export const FacilityType = styled.span`
  & {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    line-height: 1rem;
    text-align: center;
    width: 5rem;
    gap: 0.2rem;
  }

  & svg {
    height: 1.2rem;
  }
`;

export const DirectorPhone = styled.span`
  line-height: 1rem;
  text-align: center;
  width: 8rem;
`;

export const DirectorName = styled.span`
  & {
    line-height: 1rem;
    width: 4rem;
    text-align: center;
  }

  & svg {
    height: 1.2rem;
  }
`;

export const Name = styled.span`
  line-height: 1rem;
  text-align: center;
  width: 12rem;
`;

export const RequestedAt = styled.span`
  line-height: 1rem;
  text-align: center;
  width: 7rem;
`;
