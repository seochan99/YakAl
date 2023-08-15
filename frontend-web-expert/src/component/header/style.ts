import { theme } from "@/style/theme";
import { styled } from "styled-components";

export const OuterDiv = styled.div`
  background-color: ${theme.colors.indigo[100]};
  border-radius: 0.75rem;
  display: flex;
  flex-direction: column;
  box-shadow: 0.05rem 0.05rem 0.05rem 0.05rem gray;
`;

export const Title = styled.span`
  font-size: 1.4rem;
  font-weight: 600;
  color: ${theme.colors.indigo[900]};
  vertical-align: middle;
  padding: 1.5rem 2rem 0.7rem;
`;

export const Description = styled.span`
  font-size: 0.85rem;
  color: ${theme.colors.indigo[900]};
  vertical-align: middle;
  padding: 0rem 2rem 1.5rem;
`;
