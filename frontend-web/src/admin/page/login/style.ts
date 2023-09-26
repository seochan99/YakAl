import { styled } from "styled-components";
import { Link } from "react-router-dom";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  min-height: 100vh;
  min-height: -webkit-fill-available;
`;

export const HeaderOuter = styled.header`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  height: 5rem;
  line-height: 5rem;
  box-sizing: border-box;
  background-color: var(--color-surface-200);
`;

export const LinkLogo = styled(Link)`
  position: relative;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  height: 5rem;
  padding: 0 3rem;
  gap: 1rem;
  text-decoration: none;
`;

export const LogoText = styled.div`
  display: flex;
  align-items: center;
  flex-direction: row;
  gap: 1rem;
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

export const Main = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  flex: 1;

  @media only screen and (min-width: 481px) {
    background-color: var(--color-surface-150);
  }

  @media only screen and (max-width: 480px) {
    background-color: var(--color-surface-300);
  }
`;

export const LoginBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border-radius: 0.5rem;
  background-color: var(--color-surface-300);
  padding: 3rem;
  gap: 2rem;

  @media only screen and (min-width: 481px) {
    width: 18rem;
  }

  @media only screen and (max-width: 480px) {
    align-self: stretch;
  }
`;

export const LogoBox = styled.div`
  & {
    position: relative;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    align-self: center;
    gap: 2rem;
  }

  & svg {
    position: absolute;
    bottom: -0.6rem;
    right: -0.8rem;
    fill: var(--color-primary-600);
    height: 2rem;
    width: 2rem;
  }
`;

export const YakalIcon = styled.img`
  content: url("/src/global/assets/yakal-logo.png");
  height: 3rem;
`;

export const LoginHeader = styled.span`
  color: #fff;
  font-size: 1.4rem;
  line-height: 1.4rem;
  font-weight: 600;
  text-align: center;
`;

export const InputBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  gap: 0.8rem;
`;

export const LoginInput = styled.input`
  & {
    flex: 1;
    color: #151515;
    text-align: left;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    border: 0.15rem solid #fff;
    border-radius: 0.25rem;
    padding: 0.5rem;
    outline: none;
  }

  &:focus {
    border: 0.15rem solid var(--color-primary-500);
  }
`;

export const WarningText = styled.span`
  color: var(--red-400);
  font-size: 0.9rem;
  font-weight: 500;
  line-height: 0.9rem;
`;

export const LoginButton = styled.button`
  & {
    width: 100%;
    background-color: var(--color-primary-500);
    border: 0;
    border-radius: 0.25rem;
    color: #151515;
    font-size: 1rem;
    font-weight: 500;
    line-height: 1rem;
    padding: 0.75rem;
  }

  &:hover {
    cursor: pointer;
    background-color: var(--color-primary-600);
  }

  &:active {
    background-color: var(--color-primary-400);
  }
`;
