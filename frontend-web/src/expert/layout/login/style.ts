import { styled } from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  min-height: 100vh;
  min-height: -webkit-fill-available;
`;

export const Center = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  place-items: center;
  background-color: #f5f5f9;
  height: 100%;
  flex: 1;
`;
