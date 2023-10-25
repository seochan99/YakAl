import { Link } from "react-router-dom";
import styled from "styled-components";

export const OuterHeader = styled.header`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  height: 6.875rem;
  line-height: 6.875rem;
  box-sizing: border-box;
  background-color: var(--White, #fff);
`;

export const LogoLink = styled(Link)`
  display: flex;
  flex-direction: row;
  align-items: center;
  height: 6.875rem;
  padding: 0 3rem;
  gap: 1rem;
  text-decoration: none;
`;

export const IconImg = styled.img`
  content: url("/assets/yakal-logo.png");
  width: 5rem;
`;

export const LogoTextDiv = styled.div`
  display: flex;
  align-items: center;
  flex-direction: row;
  justify-content: space-between;
  gap: 1.25rem;
`;

export const TitleSpan = styled.span`
  color: var(--main, #2666f6);
  font-family: SUIT, serif;
  font-size: 2rem;
  font-style: normal;
  font-weight: 700;
  line-height: 3.2rem;
`;

export const DescriptionSpan = styled.span<{ $isAdmin?: boolean }>`
  color: var(--Gray4, #90909f);
  font-family: SUIT, serif;
  font-size: 1.25rem;
  font-style: normal;
  font-weight: 700;
  line-height: 2rem;
`;
