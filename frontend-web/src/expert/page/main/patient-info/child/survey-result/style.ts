import styled from "styled-components";

import { ReactComponent as LinkIconSvg } from "@/expert/asset/back-icon.svg";

export const Header = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

export const Title = styled.span`
  color: #151515;
  font-size: 1.25rem;
  font-weight: 600;
  line-height: 1.25rem;
`;

export const LinkButton = styled.button`
  & {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    margin-left: 1rem;
    padding: 0.2rem 0;
    border: 0;
    background-color: transparent;
  }
  &:hover {
    cursor: pointer;
  }
`;

export const Progress = styled.span`
  color: #151515;
  font-size: 1.2rem;
  font-weight: 500;
  line-height: 1.2rem;
  flex: 1;
  text-align: right;

  @media only screen and (max-width: 380px) {
    font-size: 1.05rem;
    font-weight: 500;
    line-height: 1.05rem;
  }
`;

export const LinkIcon = styled(LinkIconSvg)`
  height: 1.25rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.125rem;
  background: var(--color-surface-900);
  margin: 1rem 0;
`;

export const Content = styled.div`
  display: grid;

  @media only screen and (min-width: 769px) {
    grid-template-columns: repeat(2, 1fr);
  }

  @media only screen and (max-width: 768px) {
    grid-template-rows: repeat(2, 1fr);
  }
`;

export const List = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 0.7rem;
  gap: 1.4rem;

  @media only screen and (min-width: 769px) {
    padding-left: 1rem;
  }
`;

export const FirstList = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0.7rem 0;
  gap: 1.4rem;

  @media only screen and (min-width: 769px) {
    background-image: linear-gradient(black 33%, rgba(255, 255, 255, 0) 0%);
    background-position: right;
    background-size: 0.1rem 0.6rem;
    background-repeat: repeat-y;
  }
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
