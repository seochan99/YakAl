import styled, { css } from "styled-components";
import StarIcon from "@mui/icons-material/Star";
import { IconButton } from "@mui/material";
import { Link } from "react-router-dom";

export const OuterDiv = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
`;

export const StyledLink = styled(Link)`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    border-radius: 0.5rem;
    border: 1px solid var(--Gray2, #e9e9ee);
    background: var(--White, #fff);
    text-decoration: none;
    text-align: center;
    flex: 1;
  }

  &:hover {
    background: var(--Gray2, #e9e9ee);
  }
`;

export const NameSpan = styled.span`
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: calc(100% / 4);
  color: var(--Black, #151515);
  font-family: SUIT, serif;
  font-size: 1.2rem;
  font-style: normal;
  font-weight: 600;
  line-height: 1.2rem;
`;

const CommonFontStyle = css`
  display: inline-flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  color: var(--Gray6, #464655);
  font-family: SUIT, serif;
  font-size: 1rem;
  font-style: normal;
  font-weight: 500;
  line-height: 1.2rem;
`;

export const FacilityTypeSpan = styled.span`
  & {
    width: calc(100% / 8);
    ${CommonFontStyle}
  }

  & svg {
    height: 1.2rem;
  }
`;

export const RepresentativeSpan = styled.span`
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: calc(100% / 8);
  ${CommonFontStyle}
`;

export const TelephoneSpan = styled.span`
  width: calc(100% / 4);
  ${CommonFontStyle}
`;

export const RequestDateSpan = styled.span`
  width: calc(100% / 4);
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
