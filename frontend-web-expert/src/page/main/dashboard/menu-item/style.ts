import { Link } from "react-router-dom";
import styled from "styled-components";

export const NonLinkOuter = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: 1px solid;
  text-decoration: none;
  border-radius: 0.5rem;
  border: 0.15rem solid #b7b5c4;
  background-color: #fff;
  padding: 2rem;
  height: 18rem;
`;

export const CoomingSoonTitle = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: #b7b5c4;
  font-size: 1.4rem;
  font-weight: 700;
  margin: 1.5rem 0 1rem;
`;

export const CoomingSoonIcon = styled.img`
  content: url("/src/asset/cooming-soon-icon.png");
  width: 6rem;
  height: 6rem;
`;

export const CoomingSoonDescription = styled.div`
  & {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    color: #b7b5c4;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1.6rem;
    flex: 1;
  }
  & * {
    line-height: 1.6rem;
  }
`;

export const Outer = styled(Link)`
  & {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    border: 1px solid;
    text-decoration: none;
    border-radius: 0.5rem;
    border: 0.15rem solid #b7b5c4;
    background-color: #fff;
    padding: 2rem;
    height: 18rem;
  }
  &:hover {
    transform: scale(1.05);
    transition: all 0.5s;
  }
`;

export const ImgBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 8rem;
`;

export const Title = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: #2666f6;
  font-size: 1.4rem;
  font-weight: 700;
  margin: 1.5rem 0 1rem;
`;

export const Description = styled.div`
  & {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    color: #151515;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1.6rem;
    flex: 1;
  }
  & * {
    line-height: 1.6rem;
  }
`;
