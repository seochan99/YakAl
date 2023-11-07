import styled, { css } from "styled-components";
import StarIcon from "@mui/icons-material/Star";
import { IconButton } from "@mui/material";
import { Link } from "react-router-dom";

export const OuterDiv = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 1rem;
    border-radius: 0.5rem;
    border: 1px solid var(--Gray2, #e9e9ee);
    background: var(--White, #fff);
  }

  &:hover {
    background: var(--Gray2, #e9e9ee);
  }
`;

export const StyledLink = styled(Link)`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  align-self: stretch;
  text-decoration: none;
  text-align: center;
  flex: 1;
`;

export const NameSpan = styled.span`
  width: calc(100% / 4);
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1.25rem;
  font-style: normal;
  font-weight: 700;
  line-height: 1.25rem;
`;

const CommonFontStyle = css`
  color: var(--Gray6, #464655);
  font-family: SUIT, serif;
  font-size: 1rem;
  font-style: normal;
  font-weight: 500;
  line-height: 1.2rem;
`;

export const SexBirthdaySpan = styled.span`
  & {
    width: calc(100% / 8 * 3);
    ${CommonFontStyle}
  }

  & svg {
    height: 1rem;
  }
`;

export const TelephoneSpan = styled.span`
  width: calc(100% / 8 * 3);
  ${CommonFontStyle}
`;

export const LastQuestionnaireDateSpan = styled.span`
  width: calc(100% / 2);
  ${CommonFontStyle}
`;

export const StyledStarIcon = styled(StarIcon)`
  & {
    width: 1.5rem;
    height: 1.5rem;
  }

  &.managed {
    fill: var(--yellow, #ffc100);
  }

  &.unmanaged {
    fill: var(--Gray2, #e9e9ee);
  }
`;

export const StyledIconButton = styled(IconButton)``;
