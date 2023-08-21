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
  justify-content: space-between;
  padding: 0 0.5rem;
  height: 3rem;
`;

export const NameSex = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

export const Name = styled.span`
  color: #151515;
  font-size: 1.5rem;
  font-weight: 700;
  line-height: 1.5rem;
`;

export const SpecialNoteHeader = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
`;

export const Subtitle = styled.span`
  color: #151515;
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.25rem;
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

export const Hr = styled.hr`
  border: 0;
  height: 0.125rem;
  background: #e9e9ee;
  margin: 1rem 0;
`;

export const InnerBox = styled.div`
  display: flex;
  flex-direction: column;
  padding: 0.75rem 0.5rem;
`;

export const SpecialNoteList = styled.div`
  display: grid;
  grid-template-rows: repeat(1, 7rem);
  grid-template-columns: repeat(3, 1fr);
  gap: 0.8rem;
  margin: 1rem 0;
  padding: 0.5rem;
`;

export const SpecialNoteItem = styled.div`
  & {
    display: flex;
    flex-direction: column;
    padding: 1rem;
    border-radius: 0.25rem;
    border: 1px solid #90909f;
  }
  &:hover {
    background-color: #f5f5f9;
  }
  &:active {
    background-color: #e9e9ee;
  }
`;

export const Content = styled.div`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1.5rem;
  margin-bottom: 0.9rem;
`;

export const RecordedDate = styled.div`
  text-align: right;
  color: #90909f;
  font-size: 0.9rem;
  font-weight: 500;
  line-height: 0.9rem;
`;
