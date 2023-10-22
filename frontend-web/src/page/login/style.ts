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
  background-color: #f5f5f9;
  height: 100%;
  flex: 1;
`;
