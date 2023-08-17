import { styled } from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  min-height: 100dvh;
`;

export const Center = styled.main`
  display: flex;
  flex-direction: row;
  height: 100%;
  background-color: #f5f5f9;
`;

export const TopRight = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  margin: 0;
  padding: 0 2rem;
`;

export const Detail = styled.section`
  & {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 2rem;
  }
  &.loading {
    opacity: 0.25;
    transition: opacity 200ms;
    transition-delay: 200ms;
  }
`;
