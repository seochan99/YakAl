import styled from "styled-components";

import { ReactComponent as RedIconSvg } from "@/asset/red-icon.svg";
import { ReactComponent as YellowIconSvg } from "@/asset/yellow-icon.svg";
import { ReactComponent as GreenIconSvg } from "@/asset/green-icon.svg";

export const Header = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
`;

export const PeriodSelectBox = styled.div`
  position: relative;
  display: flex;
  flex-direction: column;
`;

export const PeriodSelectButton = styled.button`
  & {
    display: inline-flex;
    padding: 0.4rem 0.8rem 0.4rem 0.4rem;
    align-items: center;
    gap: 0.2rem;
    border: 0;
    border-radius: 2rem;
    width: 5.5rem;
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

export const PeriodList = styled.ul`
  position: absolute;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  align-items: center;
  top: 1.2rem;
  right: 0;
  list-style: none;
  border-radius: 0.25rem;
  padding: 0.4rem;
  width: 4.6rem;
  background-color: #fff;
  border: 1px solid #b7b5c4;
`;

export const PeriodItem = styled.li`
  width: 100%;
`;

export const PeriodItemButton = styled.button`
  & {
    width: 100%;
    background-color: transparent;
    border: 0;
    border-radius: 0.25rem;
    color: #151515;
    font-family: Pretendard;
    font-size: 0.9rem;
    font-weight: 500;
    line-height: 0.9rem;
    padding: 0.5rem;
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
  font-weight: 600;
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

export const ListHeader = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  padding: 0.5rem;
  border-radius: 0.25rem;
`;

export const Item = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  padding: 1rem 0.5rem;
  border-radius: 0.25rem;
`;

export const TitleHeader = styled.span`
  color: #151515;
  font-size: 1.1rem;
  font-weight: 600;
  line-height: 1.1rem;
  width: 8rem;
`;

export const RiskHeader = styled.span`
  color: #90909f;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  text-align: center;
  width: 2.7rem;
`;

export const DateHeader = styled.span`
  color: #90909f;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  width: 7rem;
`;

export const ItemTitle = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  width: 8rem;
`;

export const ItemIcon = styled.span`
  & {
    display: flex;
    flex-direction: row;
    justify-content: start;
    align-items: center;
    width: 2.7rem;
  }
  & svg {
    position: absolute;
    height: 1.2rem;
    width: 1.2rem;
  }
`;

export const ItemDate = styled.span`
  color: #90909f;
  font-size: 0.9rem;
  font-weight: 400;
  line-height: 0.9rem;
  text-align: left;
  width: 7rem;
`;

export const GreenIcon = styled(GreenIconSvg)`
  height: 0.9rem;
`;

export const YellowIcon = styled(YellowIconSvg)`
  height: 0.9rem;
`;

export const RedIcon = styled(RedIconSvg)`
  height: 0.9rem;
`;
