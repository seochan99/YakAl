import { styled } from "styled-components";

import { ReactComponent as SearchIconSvg } from "@/asset/magnifying-glass.svg";
import { ReactComponent as PageLeftIconSvg } from "@/asset/page-left.svg";
import { ReactComponent as PageRightIconSvg } from "@/asset/page-right.svg";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  border-radius: 0.5rem;
  background-color: #fff;
  padding: 2rem;
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
  padding: 1rem 0;
  margin: 0;
  overflow: auto;
  width: 100%;
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
    width: 5rem;
    text-align: center;
  }
  & svg {
    height: 1.2rem;
  }
`;

export const TestProgress = styled.span`
  line-height: 1rem;
  text-align: center;
  width: 6rem;
`;

export const Risk = styled.span`
  line-height: 1rem;
  text-align: center;
  width: 14rem;
`;

export const Birthday = styled.span`
  text-align: right;
  line-height: 1rem;
  text-align: center;
  width: 10rem;
`;

export const PagingButtonBox = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 2rem;
`;

export const PageLeftButton = styled(PageLeftIconSvg)``;

export const PageButton = styled.span``;

export const PageRightButton = styled(PageRightIconSvg)``;

export const PatientInfoContainer = styled.div`
  display: flex;
  flex-direction: column;
  flex: 1;
  border-radius: 0.5rem;
  background: #fff;
`;
