import Pagination from "react-js-pagination";
import {
  Bar,
  DateHeader,
  GreenIcon,
  Header,
  Item,
  ItemDate,
  ItemIcon,
  ItemTitle,
  List,
  ListHeader,
  PeriodItem,
  PeriodItemButton,
  PeriodList,
  PeriodSelectBox,
  PeriodSelectButton,
  QuestionIcon,
  RedIcon,
  RiskHeader,
  Title,
  TitleHeader,
  YellowIcon,
} from "./style.ts";
import { useEffect, useRef, useState } from "react";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { ListFooter } from "../../../../../../style.ts";
import { EPeriod } from "../../../../../../type/period.ts";

export type TDoseListProps = {
  patientId: number;
};

const PAGING_SIZE = 5;

function DoseList() {
  const [page, setPage] = useState<number>(1);
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [selected, setSelected] = useState<number>(5);

  const periodListRef = useRef<HTMLUListElement>(null);

  useEffect(() => {
    const handleOutOfMenuClick = (e: MouseEvent) => {
      if (periodListRef.current) {
        if (!(e.target instanceof Node) || !periodListRef.current.contains(e.target)) {
          if (isOpen) {
            setTimeout(() => setIsOpen(false), 20);
          }
        }
      }
    };

    document.addEventListener("mouseup", handleOutOfMenuClick);

    return () => {
      document.removeEventListener("mouseup", handleOutOfMenuClick);
    };
  }, [isOpen]);

  const handlePageChange = (page: number) => {
    setPage(page);
  };

  const handleSelect = (period: number) => () => {
    setSelected(period);
    setIsOpen(false);
  };

  const getRiskIcon = (polypharmacyRisk: number) => {
    switch (polypharmacyRisk) {
      case 0:
      case 1:
        return <GreenIcon />;
      case 2:
        return <YellowIcon />;
      case 3:
        return <RedIcon />;
      default:
        return <QuestionIcon />;
    }
  };

  return (
    <>
      <Header>
        <Title>복약 목록</Title>
        <PeriodSelectBox data-role="selectbox">
          <PeriodSelectButton className={isOpen ? "open" : ""} onClick={() => setIsOpen(!isOpen)}>
            <ArrowDropDownIcon />
            <span>{Object.values(EPeriod)[selected]}</span>
          </PeriodSelectButton>
          {isOpen && (
            <PeriodList ref={periodListRef}>
              {[0, 1, 2, 3, 4, 5].map((period) => {
                return (
                  <PeriodItem key={period}>
                    <PeriodItemButton onClick={handleSelect(period)}>{Object.values(EPeriod)[period]}</PeriodItemButton>
                  </PeriodItem>
                );
              })}
            </PeriodList>
          )}
        </PeriodSelectBox>
      </Header>
      <Bar />
      <List>
        <ListHeader>
          <TitleHeader>약품명</TitleHeader>
          <RiskHeader>위험도</RiskHeader>
          <DateHeader>처방일</DateHeader>
        </ListHeader>
        <Item key={"동화디트로판정"}>
          <ItemTitle>
            {"동화디트로판정".length > 9 ? "동화디트로판정".substring(0, 8).concat("...") : "동화디트로판정"}
          </ItemTitle>
          <ItemIcon>{getRiskIcon(2)}</ItemIcon>
          <ItemDate>{`2022. 12. 12.`}</ItemDate>
        </Item>
      </List>
      <ListFooter>
        <Pagination
          activePage={page}
          itemsCountPerPage={PAGING_SIZE}
          totalItemsCount={10}
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
