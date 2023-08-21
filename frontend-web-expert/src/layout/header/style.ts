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
  align-items: center;
  padding: 0 3rem;
  margin: 0;
  text-decoration: none;
`;

export const Icon = styled.img`
  content: url("/src/asset/yakal-logo.png");
  width: 4.2rem;
  margin: 0 1rem 0 0.6rem;
`;

export const Title = styled.span`
  text-align: center;
  font-size: 2rem;
  font-weight: 700;
  color: #2666f6;
  margin: 0.2rem 0.5rem 0;
`;

export const Description = styled.span`
  font-size: 1.25rem;
  font-weight: 700;
  color: #90909f;
  margin-left: 1rem;
  margin-top: 0.2rem;
`;
