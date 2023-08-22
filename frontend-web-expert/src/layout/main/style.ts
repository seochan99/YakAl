import { styled } from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
`;

export const MainSection = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  flex: 1;
  width: 100%;
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

export const Detail = styled.div`
  & {
    width: 50rem;
    display: flex;
    flex-direction: column;
    padding: 2rem;
    align-items: center;
  }
  &.loading {
    opacity: 0.25;
    transition: opacity 200ms;
    transition-delay: 200ms;
  }
`;
