import { theme } from "@/style/theme";
import { Badge, IconButton } from "@mui/material";
import styled, { keyframes } from "styled-components";

const swing = keyframes`
  0%,
  30%,
  50%,
  70%,
  100% {
    transform: rotate(0deg);
  }
  10% {
    transform: rotate(10deg);
  }
  40% {
    transform: rotate(-10deg);
  }
  60% {
    transform: rotate(5deg);
  }
  80% {
    transform: rotate(-5deg);
  }
`;

export const Outer = styled.div`
  display: flex;
  flex-direction: row;
  padding: 0 1rem;
`;

export const SwingIconButton = styled(IconButton)`
  &:hover {
    color: ${theme.colors.indigo[500]};
  }
  &:hover svg {
    animation: ${swing} ease-in-out 0.5s 1 alternate;
  }
`;

export const SmallBadge = styled(Badge)`
  & .MuiBadge-badge {
    border: 2px solid white;
    font-size: 0.2rem;
  }
`;
