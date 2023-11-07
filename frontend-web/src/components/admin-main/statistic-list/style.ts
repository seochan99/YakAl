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
  gap: 1rem;
`;

// HeaderTitle
export const HeaderTitle = styled.div`
  font-size: 1.5rem;
  font-weight: 500;
  line-height: 1.5rem;
  color: var(--Black1, #1b1b1b);
`;

// DateContainer
export const DateContainer = styled.div`
  display: flex;
  flex-direction: row;

  gap: 0.5rem;
`;
// SearchResultContainer
export const SearchResultContainer = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 0.5rem;
`;

// SearchButton
export const SearchButton = styled.button`
  /* Style */
  width: var(--IconSize);
  height: var(--IconSize);
`;

// SearchMedicineList
export const SearchMedicineList = styled.div`
  display: flex;
  flex-direction: column;
  gap: 1rem;
`;
