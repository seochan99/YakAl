import { NavLink } from "react-router-dom";
import styled from "styled-components";

import { ReactComponent as RedIconSvg } from "@/asset/red-icon.svg";
import { ReactComponent as YellowIconSvg } from "@/asset/yellow-icon.svg";
import { ReactComponent as GreenIconSvg } from "@/asset/green-icon.svg";

export const Outer = styled(NavLink)`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    border: 0;
    border-radius: 0.25rem;
    margin: 0.45rem 0;
    text-decoration: none;
    color: #151515;
  }
  &:hover {
    cursor: pointer;
    background-color: #e9e9ee;
  }
`;

export const Name = styled.span`
  font-size: 1.2rem;
  font-weight: 600;
  line-height: 1.2rem;
  text-align: center;
  width: 6rem;
`;

export const Sex = styled.span`
  & {
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1rem;
    width: 4rem;
    gap: 0.1rem;
  }
  & svg {
    height: 1.2rem;
  }
`;

export const TestProgress = styled.span`
  font-size: 1rem;
  font-weight: 600;
  line-height: 1rem;
  text-align: center;
  width: 5rem;
`;

export const IconBox = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  width: 16rem;
  gap: 0.1rem;
`;

export const TotalCount = styled.span`
  font-size: 1rem;
  line-height: 1rem;
  font-weight: 600;
  margin-right: 0.4rem;
`;

export const GreenIcon = styled(GreenIconSvg)`
  height: 1rem;
`;

export const YellowIcon = styled(YellowIconSvg)`
  height: 1rem;
`;

export const RedIcon = styled(RedIconSvg)`
  height: 1rem;
`;

export const Birthday = styled.span`
  font-size: 1rem;
  font-weight: 600;
  line-height: 1rem;
  text-align: center;
  width: 12em;
`;
