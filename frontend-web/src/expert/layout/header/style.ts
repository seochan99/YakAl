import { Link } from "react-router-dom";
import styled from "styled-components";

export const HeaderOuter = styled.header`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  height: 6.75rem;
  line-height: 6.75rem;
  box-sizing: border-box;
`;

export const LogoOuter = styled(Link)`
  position: relative;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  height: 6.75rem;
  padding: 0 2rem;
  gap: 1rem;
  text-decoration: none;
`;

export const Icon = styled.img`
  content: url("/src/expert/asset/yakal-logo.png");
  width: 4.2rem;
`;

export const LogoText = styled.div`
  display: flex;
  align-items: start;
  flex-direction: column;
  gap: 0.4rem;
`;

export const Title = styled.span`
  text-align: center;
  font-weight: 700;
  color: #2666f6;
  font-size: 1.6rem;
  line-height: 1.6rem;
`;

export const Description = styled.span`
  font-size: 1.1rem;
  font-weight: 600;
  line-height: 1.1rem;
  color: #90909f;
`;
