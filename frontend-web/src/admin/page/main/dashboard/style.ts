import { styled } from "styled-components";

export const Outer = styled.div`
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  grid-template-rows: repeat(4, 10rem);
  gap: 2rem;
  padding: 2rem;
`;

export const InnerBox = styled.div`
  background-color: var(--color-surface-300);
  border-radius: 0.5rem;
  padding: 1rem 1.2rem;
`;

export const InnerBoxTitle = styled.span`
  & {
    display: flex;
    flex-direction: row;
    align-items: center;
    color: #fff;
    font-size: 1rem;
    line-height: 1rem;
    font-weight: 500;
    gap: 0.6rem;
  }

  & svg {
    height: 1.5rem;
  }
`;

export const IconButtonBox = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

export const UserStatistics = styled(InnerBox)`
  grid-column: 1 / span 6;
  grid-row: 1 / span;
`;

export const DoseStatistics = styled(InnerBox)`
  grid-column: 7 / span 6;
  grid-row: 1 / span;
`;

export const NotificationStatistics = styled(InnerBox)`
  grid-column: 1 / span 3;
  grid-row: 2 / span;
`;

export const CommunityStatistics = styled(InnerBox)`
  grid-column: 4 / span 5;
  grid-row: 2 / span;
`;

export const OCRAnalysis = styled(InnerBox)`
  grid-column: 9 / span 4;
  grid-row: 2 / span 3;
`;

export const ExpertAnalysis = styled(InnerBox)`
  grid-column: 1 / span 4;
  grid-row: 3 / span 2;
`;

export const PartnerAnalysis = styled(InnerBox)`
  grid-column: 5 / span 4;
  grid-row: 3 / span 2;
`;
