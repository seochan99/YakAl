import { styled } from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  padding: 1.25rem;
`;

export const PatientSummary = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  height: 3rem;
`;

export const NameSex = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

export const Subtitle = styled.span`
  color: #151515;
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.25rem;
  margin-left: 0.5rem;
`;

export const Description = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
`;

export const Sex = styled(Description)`
  margin-left: 0.5rem;
`;

export const Birthday = styled(Description)`
  margin-left: 5rem;
`;

export const Hr = styled.hr`
  border: 0;
  height: 0.125rem;
  background: #e9e9ee;
  margin: 1rem 0;
`;

export const InnerBox = styled.div`
  padding: 0.75rem 0;
`;

export const SpecialNoteList = styled.div``;
