import styled from "styled-components";

export const FooterOuter = styled.footer`
  display: flex;
  flex-direction: row;
  align-items: center;
  padding: 1rem 0;
  background-color: var(--color-surface-900);
`;

export const ViewPharmIcon = styled.img`
  & {
    content: url("/src/expert/asset/view-pharm-logo.png");
    margin-left: 10vw;
    width: 6rem;
    height: 6rem;
  }

  &:hover {
    filter: invert(50%);
    cursor: pointer;
  }
`;

export const ViewPharmExplain = styled.p`
  margin-left: 2rem;
  margin-right: 10vw;
  line-height: 1.6rem;
  font-size: 0.9rem;
  color: #90909f;
  font-weight: 500;
`;
