import styled from "styled-components";

import { ReactComponent as LinkIconSvg } from "@/asset/back-icon.svg";

export const Title = styled.span`
  & {
    color: #151515;
    font-size: 1.25rem;
    font-weight: 700;
    line-height: 1.25rem;
    display: flex;
    flex-direction: row;
    align-items: center;
  }
`;

export const LinkButton = styled.button`
  & {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    margin-left: 1rem;
    padding: 0.2rem 0.4rem;
    border: 0;
    background-color: transparent;
  }
  &:hover {
    cursor: pointer;
  }
`;

export const Progress = styled.span`
  color: #151515;
  font-size: 1.25rem;
  font-weight: 500;
  line-height: 1.25rem;
  flex: 1;
  text-align: right;
`;

export const LinkIcon = styled(LinkIconSvg)`
  height: 1.25rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.125rem;
  background: #e9e9ee;
  margin: 1rem 0;
`;

export const Content = styled.div`
  display: grid;
  grid-template-columns: repeat(2, 1fr);
`;

export const List = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0.8rem 0 0 1rem;
  gap: 1.4rem;
`;

export const FirstList = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0.8rem 0;
  gap: 1.4rem;
  background-image: linear-gradient(black 33%, rgba(255, 255, 255, 0) 0%);
  background-position: right;
  background-size: 0.1rem 0.6rem;
  background-repeat: repeat-y;
`;

export const Item = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  width: 100%;
`;

export const ItemTitle = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
`;

export const ItemResult = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  margin-right: 1rem;
`;
