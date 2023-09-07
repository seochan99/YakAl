import {
  DateBox,
  List,
  Name,
  OptionBar,
  Outer,
  SearchBar,
  SearchButton,
  SearchInput,
  SelectBox,
  SelectButton,
  SelectItem,
  SelectItemButton,
  SelectList,
  Sex,
  TableHeader,
  TestProgress,
} from "./style.ts";
import React, { ReactNode, useEffect, useRef, useState } from "react";
import { useMediaQuery } from "react-responsive";
import { useGetPatientListQuery } from "../../../api/patient-list.ts";
import { EPatientFilter } from "../../../type/patient-filter.ts";
import ErrorPage from "../../error-page";
import PatientItem from "./child/patient-item";
import { ListFooter } from "../../../style.ts";
import Pagination from "react-js-pagination";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";

const PAGING_SIZE = 10;

function PatientList() {
  const [searchName, setSearchName] = useState<string>("");
  const [page, setPage] = useState<number>(1);
  const [filterOptionIsOpen, setFilterOptionIsOpen] = useState<boolean>(false);
  const [selected, setSelected] = useState<string>(EPatientFilter.SUBMISSION_DATE);

  const { data, isLoading, isError } = useGetPatientListQuery({
    sort:
      selected === EPatientFilter.SUBMISSION_DATE
        ? "date"
        : selected === EPatientFilter.NAME
        ? "name"
        : selected === EPatientFilter.BIRTHDAY
        ? "birth"
        : "",
    order: "asc",
    page: page - 1,
    name: searchName,
  });

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

  if (isLoading) {
    return <></>;
  }

  if (isError || !data || !data.datalist) {
    return <ErrorPage />;
  }

  const getDummyList = (): ReactNode[] => {
    const dummyList: ReactNode[] = [];

    if (PAGING_SIZE * page <= data.datalist.length) {
      return dummyList;
    }

    for (let i = 0; i < PAGING_SIZE - (data.datalist.length % PAGING_SIZE); ++i) {
      dummyList.push(<PatientItem key={i} />);
    }
    return dummyList;
  };

  const userList = data.datalist;

  console.log(userList);

  return (
    <Outer>
      <OptionBar>
        <SearchBar>
          <SearchButton />
          <SearchInput
            type="text"
            placeholder="환자 이름으로 검색"
            value={searchName}
            onChange={(e) => setSearchName(e.target.value)}
          />
        </SearchBar>
        <SelectBox data-role="selectbox">
          <SelectButton
            className={filterOptionIsOpen ? "open" : ""}
            onClick={() => setFilterOptionIsOpen(!filterOptionIsOpen)}
          >
            <ArrowDropDownIcon />
            <span>{selected ? selected : "필터"}</span>
          </SelectButton>
          {filterOptionIsOpen && (
            <SelectList ref={selectListRef}>
              {Object.keys(EPatientFilter).map((patientFilter) => {
                const value = EPatientFilter[patientFilter as keyof typeof EPatientFilter];
                return (
                  <SelectItem key={patientFilter}>
                    <SelectItemButton value={value} onClick={handleSelect}>
                      {value}
                    </SelectItemButton>
                  </SelectItem>
                );
              })}
            </SelectList>
          )}
        </SelectBox>
      </OptionBar>
      <List>
        <TableHeader>
          <Name>{`이름`}</Name>
          {!isMiddleMobile && <Sex>{`성별`}</Sex>}
          <DateBox>
            {`생년월일`}
            {!isMiddleMobile && `(만 나이)`}
          </DateBox>
          {!isMiddleMobile && <TestProgress>{`설문 완료율`}</TestProgress>}
          <DateBox>{`최근 설문 제출일`}</DateBox>
        </TableHeader>
        {userList.map((user) => {
          return <PatientItem key={user.id} userInfo={user} />;
        })}
        {getDummyList()}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={PAGING_SIZE}
          totalItemsCount={data.pageInfo.totalElements}
          pageRangeDisplayed={5}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </Outer>
  );
}

export default PatientList;
