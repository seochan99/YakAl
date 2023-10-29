import { styled } from "styled-components";
import "/src/style/font.css";

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: column;
  align-items: stretch;
  justify-content: start;
  width: 100vw;
`;

export const CenteringMain = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-color: var(--Gray1, #f5f5f9);
  flex: 1;
`;
