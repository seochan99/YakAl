import { Link } from "react-router-dom";
import styled from "styled-components";

export const Outer = styled.header`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  height: 6.75rem;
  line-height: 6.75rem;
  box-sizing: border-box;
  background-color: var(--color-surface-300);
`;

export const LinkLogo = styled(Link)`
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

export const YakalIcon = styled.img`
  content: url("/src/global/asset/yakal-logo.png");
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
  color: #fff;
  font-size: 1.6rem;
  line-height: 1.6rem;
`;

export const Subtitle = styled.span`
  font-size: 1.1rem;
  font-weight: 600;
  line-height: 1.1rem;
  color: var(--color-primary-500);
`;
