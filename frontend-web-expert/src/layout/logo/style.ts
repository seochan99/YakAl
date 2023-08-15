import styled from "styled-components";
import { Link } from "react-router-dom";

import { theme } from "@/style/theme";

export const NonBorderOuter = styled(Link)`
  position: relative;
  display: flex;
  align-items: center;
  width: 16rem;
  padding: 0 2rem;
  margin: 0;
  text-decoration: none;
`;

export const Outer = styled(NonBorderOuter)`
  &:after {
    content: "";
    position: absolute;
    top: 1.4rem;
    bottom: 1.4rem;
    right: 0;
    width: 1px;
    border-right: 1px solid ${theme.colors.gray[300]};
  }
`;

export const Icon = styled.img`
  content: url("/src/assets/yakal-logo.png");
  width: 3rem;
  margin: 0 1rem 0 0.6rem;
`;

export const Title = styled.span`
  text-align: center;
  font-size: 2rem;
  font-weight: 700;
  color: #2666f6;
  margin-top: 0.2rem;
  line-height: 3.2rem;
`;

export const Description = styled.span`
  font-size: 1.25rem;
  font-weight: 700;
  color: #90909f;
  margin-left: 1rem;
  margin-top: 0.2rem;
  line-height: 2rem;
`;
