import { styled } from "styled-components";

export const CenteringOuterDiv = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: var(--Gray1, #f5f5f9);
  width: 100%;
  min-height: 100vh;

  /* iOS Viewport Bug Fix */
  @supports (-webkit-touch-callout: none) {
    min-height: calc(var(--vh) * 100);
  }
`;

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  min-height: 100vh;

  /* iOS Viewport Bug Fix */
  @supports (-webkit-touch-callout: none) {
    min-height: calc(var(--vh) * 100);
  }
`;

export const CenteringMain = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  place-items: center;
  background-color: var(--Gray1, #f5f5f9);
  height: 100%;
  flex: 1;
`;

export const UsernamePasswordDiv = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  gap: 0.6rem;
  border-radius: 1rem;
  background-color: var(--White, #fff);
  padding: 3rem;
`;

export const LoginTitleSpan = styled.span`
  color: var(--Black, #151515);
  text-align: center;
  font-family: Pretendard, serif;
  font-size: 1.5rem;
  font-style: normal;
  font-weight: 700;
  line-height: 4rem;
`;

export const TextInput = styled.input`
  & {
    width: 20rem;
    padding: 0.8rem 1rem;
    border-radius: 8px;
    border: 2px solid var(--Gray2, #e9e9ee);
    color: var(--Black, #151515);
    font-family: SUIT, serif;
    font-size: 1rem;
    font-style: normal;
    font-weight: 500;
    line-height: 1rem;
  }

  &:focus {
    outline: none;
    border: 2px solid var(--Sub1, #5588fd);
  }

  &::placeholder {
    color: var(--Gray3, #151515);
    font-family: SUIT, serif;
    font-size: 1rem;
    font-style: normal;
    font-weight: 500;
    line-height: 1rem;
  }
`;

export const LoginButton = styled.button`
  & {
    /* Button */
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    padding: 1rem;
    border-radius: 0.5rem;
    border: 0;
    background-color: var(--Main, #2666f6);
    /* Text */
    color: var(--White, #fff);
    text-align: center;
    font-family: SUIT, serif;
    font-size: 1.25rem;
    font-style: normal;
    font-weight: 600;
    line-height: 1.25rem;
  }

  &:hover {
    background-color: var(--Sub1, #5588fd);
  }

  &:disabled {
    background-color: var(--Gray2, #e9e9ee);
    color: var(--Gray3, #c6c6cf);
  }
`;

export const LoginButtonSpan = styled.span<{ $disabled: boolean }>`
  color: ${({ $disabled }) => ($disabled ? "var(--Gray3, #C6C6CF)" : "var(--White, #fff)")};
`;
