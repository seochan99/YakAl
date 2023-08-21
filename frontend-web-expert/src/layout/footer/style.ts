import styled from "styled-components";

export const FooterOuter = styled.footer`
  display: flex;
  flex-direction: row;
  height: 6rem;
  background-color: #e9e9ee;
  padding: 2rem 10rem;
`;

export const ViewPharmIcon = styled.img`
  & {
    content: url("/src/asset/view-pharm-logo.png");
    width: 6rem;
    height: 6rem;
  }
  &:hover {
    filter: invert(50%);
    cursor: pointer;
  }
`;

export const ViewPharmExplain = styled.p`
  margin: auto 0 auto 2rem;
  line-height: 1.6rem;
  font-size: 0.9rem;
  color: #90909f;
  font-weight: 500;
`;
