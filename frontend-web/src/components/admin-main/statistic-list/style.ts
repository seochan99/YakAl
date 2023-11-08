import { styled } from "styled-components";
import { ReactComponent as SearchIconSvg } from "/public/assets/icons/magnifying-glass-icon.svg";

export const OptionBarDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
`;

export const SearchBarDiv = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  border-radius: 0.5rem;
  border: 0.125rem solid var(--Gray2, #e9e9ee);
  height: 2.5rem;
  gap: 0.8rem;
  flex: 1;
`;

export const CalendarDateBtn = styled.button`
  padding: 10px 20px;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-right: 10px;
  background-color: #fff;
  cursor: pointer;

  &:hover {
    background-color: #f0f0f0;
  }
`;
export const StyledSearchIconSvg = styled(SearchIconSvg)`
  /* Variable */
  --IconSize: 1.2rem;

  /* Style */
  width: var(--IconSize);
  height: var(--IconSize);
  margin-left: var(--IconSize);
`;

// MedicineLinstContainer
export const MedicineListContainer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: stretch;
  gap: 1rem;
`;

// HeaderTitle
export const HeaderTitle = styled.span`
  font-size: 1.5rem;
  font-weight: 500;
  line-height: 1.5rem;
  text-align: center;
  color: var(--Black1, #151515);
`;

// DateContainer
export const DateContainer = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 0.5rem;
`;
// SearchResultContainer
export const SearchResultContainer = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 0.5rem;
`;
export const ColCalendar = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.2rem;
`;
// SearchButton
export const SearchButton = styled.button`
  background-color: var(--MainColor, #00a8ff);
  color: var(--White1, #ffffff);
  // main color border
  border: 0.125rem solid var(--MainColor, #00a8ff);

  &:hover {
    background-color: var(--White1, #ffffff);
    color: var(--MainColor, #00a8ff);
    cursor: pointer;
  }

  padding: 0.5rem 1rem;
`;

export const CalendarLabel = styled.span`
  color: var(--Black1, #1b1b1b);
  font-size: 1rem;
  text-align: center;
`;

// SearchMedicineList
export const SearchMedicineList = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1rem;
`;
