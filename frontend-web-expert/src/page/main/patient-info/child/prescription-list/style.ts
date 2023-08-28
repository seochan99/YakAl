import styled from "styled-components";

export const Header = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
`;

export const Title = styled.span`
  color: #151515;
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.25rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.125rem;
  background: #e9e9ee;
  margin: 1rem 0;
`;

export const List = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: start;
  flex: 1;
  height: 100%;
  gap: 0.5rem;
`;

export const Item = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  padding: 0.75rem 0;
  border-radius: 0.25rem;
`;

export const TitleHeader = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 700;
  line-height: 1rem;
`;

export const ItemTitle = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
`;
