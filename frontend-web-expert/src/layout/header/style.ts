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
  content: url("/src/asset/yakal-logo.png");
  width: 4.2rem;
`;

export const LogoText = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 1rem;
`;

export const Title = styled.span`
  text-align: center;
  font-size: 2rem;
  font-weight: 700;
  line-height: 2rem;
  color: #2666f6;
`;

export const Description = styled.span`
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.25rem;
  color: #90909f;
`;
