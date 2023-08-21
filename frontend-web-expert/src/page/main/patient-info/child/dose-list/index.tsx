import Pagination from "react-js-pagination";
import {
  Bar,
  Header,
  CommonItem,
  ItemTitle,
  List,
  ListFooter,
  ListRow,
  PeriodSelectBox,
  PeriodSelectButton,
  RiskHeader,
  Title,
  TitleHeader,
  CommonBox,
  DateHeader,
} from "./style";
import { useState } from "react";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";

function DoseList() {
  const [page, setPage] = useState<number>(1);
  const [isOpen, setIsOpen] = useState<boolean>(false);

  const handlePageChange = (page: number) => {
    setPage(page);
    console.log(page);
  };

  const doseList = [
    {
      name: "동화디트로판정",
      polypharmacyRisk: 1,
      prescribed_at: new Date("2023-08-14"),
    },
    { name: "알레그라정", polypharmacyRisk: 2, prescribed_at: new Date("2023-08-15") },
    { name: "스토가정", polypharmacyRisk: 3, prescribed_at: new Date("2023-08-16") },
    { name: "아낙정", polypharmacyRisk: 8, prescribed_at: new Date("2023-08-17") },
    { name: "가나릴정", polypharmacyRisk: 9, prescribed_at: new Date("2023-08-18") },
    { name: "네가박트정", polypharmacyRisk: 10, prescribed_at: new Date("2023-08-19") },
  ];

  return (
    <>
      <Header>
        <Title>복약 목록</Title>
        <PeriodSelectBox data-role="selectbox">
          <PeriodSelectButton onClick={() => setIsOpen(!isOpen)}>
            <ArrowDropDownIcon />
            기간
          </PeriodSelectButton>
          {isOpen && (
            <ul>
              <li>
                <button value="ONE_WEEK">일주일</button>
              </li>
              <li>
                <button value="ONE_MONTH">한달</button>
              </li>
              <li>
                <button value="THREE_MONTH">3개월</button>
              </li>
              <li>
                <button value="HALF_YEAR">6개월</button>
              </li>
              <li>
                <button value="ONE_YEAR">1년</button>
              </li>
              <li>
                <button value="ALL">전체</button>
              </li>
            </ul>
          )}
        </PeriodSelectBox>
      </Header>
      <Bar />
      <List>
        <ListRow>
          <TitleHeader>약품명</TitleHeader>
          <CommonBox>
            <RiskHeader>위험도</RiskHeader>
            <DateHeader>처방일</DateHeader>
          </CommonBox>
        </ListRow>
        {doseList.slice(5 * (page - 1), 5 * page).map((dose) => (
          <ListRow key={dose.name.concat("_" + dose.prescribed_at.toDateString())}>
            <ItemTitle>{dose.name.length > 9 ? dose.name.substring(0, 8).concat("...") : dose.name}</ItemTitle>
            <CommonBox>
              <CommonItem>{dose.polypharmacyRisk}</CommonItem>
              <CommonItem>
                {`${dose.prescribed_at.getFullYear()}.
                ${
                  dose.prescribed_at.getMonth() + 1 < 10
                    ? "0".concat((dose.prescribed_at.getMonth() + 1).toString())
                    : dose.prescribed_at.getMonth() + 1
                }.
                ${dose.prescribed_at.getDate()}.`}
              </CommonItem>
            </CommonBox>
          </ListRow>
        ))}
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={5}
          totalItemsCount={doseList.length}
          pageRangeDisplayed={3}
          prevPageText={"‹"}
          nextPageText={"›"}
          onChange={handlePageChange}
        />
      </ListFooter>
    </>
  );
}

export default DoseList;
