import styled from "styled-components";
import { Link } from "react-router-dom";

export const Outer = styled(Link)`
  position: relative;
  display: flex;
  align-items: center;
  width: 18rem;
  padding: 0 2rem;
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
  margin-top: 0.2rem;
`;

export const Description = styled.span`
  font-size: 1.25rem;
  font-weight: 700;
  color: #90909f;
  margin-left: 1rem;
  margin-top: 0.2rem;
`;
