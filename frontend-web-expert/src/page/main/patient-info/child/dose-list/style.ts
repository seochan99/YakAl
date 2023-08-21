import styled from "styled-components";

export const Header = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
`;

export const PeriodSelectBox = styled.div`
  display: flex;
  flex-direction: column;
`;

export const PeriodSelectButton = styled.button`
  & {
    display: inline-flex;
    padding: 0.4rem 0.8rem 0.4rem 0.4rem;
    justify-content: center;
    align-items: center;
    gap: 0.2rem;
    border: 0;
    border-radius: 2rem;
    height: 2rem;
    background-color: #e9e9ee;
    color: #151515;
    font-family: Pretendard;
    font-size: 0.9rem;
    font-weight: 600;
    line-height: 0.9rem;
  }
  & svg {
    height: 1.2rem;
    transition: 0.3s;
  }
  &:focus svg {
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

export const Title = styled.span`
  color: #151515;
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.25rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.125rem;
  background: #e9e9ee;
  margin: 1rem 0;
`;

export const List = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
  gap: 0.5rem;
`;

export const ListRow = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  padding: 0.75rem;
  border-radius: 0.25rem;
`;

export const TitleHeader = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 700;
  line-height: 1rem;
`;

export const CommonBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  width: 50%;
  align-items: center;
`;

export const RiskHeader = styled.span`
  color: #90909f;
  font-size: 0.9rem;
  font-weight: 700;
  line-height: 0.9rem;
  text-align: left;
`;

export const DateHeader = styled.span`
  color: #90909f;
  font-size: 0.9rem;
  font-weight: 700;
  line-height: 0.9rem;
  margin-right: 3rem;
  text-align: left;
`;

export const ItemTitle = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
`;

export const CommonItem = styled.span`
  color: #90909f;
  font-size: 0.9rem;
  font-weight: 500;
  line-height: 0.9rem;
  text-align: left;
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
