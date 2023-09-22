import * as S from "./style.ts";
import React, { useEffect, useRef, useState } from "react";
import { useMediaQuery } from "react-responsive";
import { EPatientFilter } from "../../../../type/patient-filter.ts";
import { ListFooter } from "../../../../style.ts";
import Pagination from "react-js-pagination";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";

const PAGING_SIZE = 10;

function PatientListPage() {
  const [searchName, setSearchName] = useState<string>("");
  const [page, setPage] = useState<number>(1);
  const [filterOptionIsOpen, setFilterOptionIsOpen] = useState<boolean>(false);
  const [selected, setSelected] = useState<string>(EPatientFilter.SUBMISSION_DATE);

  const isMiddleMobile = useMediaQuery({ query: "(max-width: 671px)" });

  const selectListRef = useRef<HTMLUListElement>(null);

  useEffect(() => {
    const handleOutOfMenuClick = (e: MouseEvent) => {
      if (selectListRef.current) {
        if (!(e.target instanceof Node) || !selectListRef.current.contains(e.target)) {
          if (filterOptionIsOpen) {
            setTimeout(() => setFilterOptionIsOpen(false), 20);
          }
        }
      }
    };

    document.addEventListener("mouseup", handleOutOfMenuClick);

    return () => {
      document.removeEventListener("mouseup", handleOutOfMenuClick);
    };
  }, [filterOptionIsOpen]);

  const handleSelect = (e: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
    setSelected(e.currentTarget.value);
    setFilterOptionIsOpen(false);
  };

  const handlePageChange = (page: number) => {
    setPage(page);
  };

  return (
    <S.Outer>
      <S.OptionBar>
        <S.SearchBar>
          <S.SearchButton />
          <S.SearchInput
            type="text"
            placeholder="환자 이름으로 검색"
            value={searchName}
            onChange={(e) => setSearchName(e.target.value)}
          />
        </S.SearchBar>
        <S.SelectBox data-role="selectbox">
          <S.SelectButton
            className={filterOptionIsOpen ? "open" : ""}
            onClick={() => setFilterOptionIsOpen(!filterOptionIsOpen)}
          >
            <ArrowDropDownIcon />
            <span>{selected ? selected : "필터"}</span>
          </S.SelectButton>
          {filterOptionIsOpen && (
            <S.SelectList ref={selectListRef}>
              {Object.keys(EPatientFilter).map((patientFilter) => {
                const value = EPatientFilter[patientFilter as keyof typeof EPatientFilter];
                return (
                  <S.SelectItem key={patientFilter}>
                    <S.SelectItemButton value={value} onClick={handleSelect}>
                      {value}
                    </S.SelectItemButton>
                  </S.SelectItem>
                );
              })}
            </S.SelectList>
          )}
        </S.SelectBox>
      </S.OptionBar>
      <S.List>
        <S.TableHeader>
          <S.Name>{`이름`}</S.Name>
          {!isMiddleMobile && <S.Sex>{`성별`}</S.Sex>}
          <S.DateBox>
            {`생년월일`}
            {!isMiddleMobile && `(만 나이)`}
          </S.DateBox>
          {!isMiddleMobile && <S.TestProgress>{`설문 완료율`}</S.TestProgress>}
          <S.DateBox>{`최근 설문 제출일`}</S.DateBox>
        </S.TableHeader>
      </S.List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={PAGING_SIZE}
          totalItemsCount={10}
          pageRangeDisplayed={5}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </S.Outer>
  );
}

export default PatientListPage;
