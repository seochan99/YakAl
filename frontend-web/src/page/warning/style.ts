import styled from "styled-components";

export const OuterDiv = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  gap: 6rem;
`;

export const IconImg = styled.img`
  height: 8rem;
`;

export const ContentDiv = styled.div`
  display: flex;
  flex-direction: column;
  align-items: start;
  gap: 2.5rem;

  @media only screen and (max-width: 768px) {
    margin: 0 15%;
  }
`;

export const TitleSpan = styled.span`
  font-size: 3rem;
  font-weight: 600;
  line-height: 3rem;
`;

export const SubtitleSpan = styled.span`
  font-size: 1.6rem;
  font-weight: 500;
  line-height: 1.6rem;
`;

export const DescriptionParagraph = styled.p`
  font-size: 1.2rem;
  line-height: 2rem;
  font-weight: 400;
  white-space: pre-line;
  margin: 0;
`;
