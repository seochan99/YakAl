import Pagination from "react-js-pagination";
import * as S from "./style.ts";
import { useEffect, useRef, useState } from "react";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { ListFooter } from "../../../../../../style.ts";
import { EPeriod } from "../../../../../../type/period.ts";

export type TDoseListProps = {
  patientId: number;
};

const PAGING_SIZE = 5;

function Doses() {
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
        return <S.GreenIcon />;
      case 2:
        return <S.YellowIcon />;
      case 3:
        return <S.RedIcon />;
      default:
        return <S.QuestionIcon />;
    }
  };

  return (
    <>
      <S.Header>
        <S.Title>복약 목록</S.Title>
        <S.PeriodSelectBox data-role="selectbox">
          <S.PeriodSelectButton className={isOpen ? "open" : ""} onClick={() => setIsOpen(!isOpen)}>
            <ArrowDropDownIcon />
            <span>{Object.values(EPeriod)[selected]}</span>
          </S.PeriodSelectButton>
          {isOpen && (
            <S.PeriodList ref={periodListRef}>
              {[0, 1, 2, 3, 4, 5].map((period) => {
                return (
                  <S.PeriodItem key={period}>
                    <S.PeriodItemButton onClick={handleSelect(period)}>
                      {Object.values(EPeriod)[period]}
                    </S.PeriodItemButton>
                  </S.PeriodItem>
                );
              })}
            </S.PeriodList>
          )}
        </S.PeriodSelectBox>
      </S.Header>
      <S.Bar />
      <S.List>
        <S.ListHeader>
          <S.TitleHeader>약품명</S.TitleHeader>
          <S.RiskHeader>위험도</S.RiskHeader>
          <S.DateHeader>처방일</S.DateHeader>
        </S.ListHeader>
        <S.Item key={"동화디트로판정"}>
          <S.ItemTitle>
            {"동화디트로판정".length > 9 ? "동화디트로판정".substring(0, 8).concat("...") : "동화디트로판정"}
          </S.ItemTitle>
          <S.ItemIcon>{getRiskIcon(2)}</S.ItemIcon>
          <S.ItemDate>{`2022. 12. 12.`}</S.ItemDate>
        </S.Item>
      </S.List>
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

export default Doses;
