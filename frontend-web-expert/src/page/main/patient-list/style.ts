import { styled } from "styled-components";

import { ReactComponent as SearchIconSvg } from "@/asset/magnifying-glass.svg";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  border-radius: 0.5rem;
  background-color: #fff;
  padding: 2rem;
  height: 52.5rem;
`;

export const OptionBar = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-top: 0.5rem;
  height: 3rem;
  border-radius: 2rem;
  border: 2px solid #e9e9ee;
  width: 100%;
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

export const Risk = styled.span`
  line-height: 1rem;
  text-align: center;
  width: 16rem;
`;

export const Birthday = styled.span`
  text-align: right;
  line-height: 1rem;
  text-align: center;
  width: 12em;
`;

export const ListFooter = styled.div`
  & {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: 0.9rem;
    font-family: Pretendard;
  }
  & .pagination {
    display: flex;
    flex-direction: row;
    gap: 0.8rem;
    margin: 0;
  }
  & ul {
    list-style: none;
    padding: 0;
  }
  & ul.pagination li {
    display: inline-block;
    width: 1.8rem;
    height: 1.8rem;
    border-radius: 1.8rem;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #b7b5c4;
  }
  & ul.pagination li:hover {
    background-color: #e9e9ee;
    cursor: pointer;
  }
  & ul.pagination li:active {
    background-color: #337ab7;
  }
  & ul.pagination li.active {
    background-color: #337ab7;
  }
  & ul.pagination li a {
    text-decoration: none;
    color: #151515;
  }
  & ul.pagination li:hover a {
    color: #151515;
  }
  & ul.pagination li:active a {
    color: white;
  }
  & ul.pagination li.active a {
    color: white;
  }
`;
